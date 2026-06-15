"""SQLite FTS5 index/search for Biz-compiler Markdown knowledge."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sqlite3
import sys
import time
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Iterable

SCHEMA_VERSION = "knowledge-search-v1"
EXCLUDED_PARTS = {".git", ".index", ".venv", "node_modules", "__pycache__"}
CJK_RE = re.compile(r"[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]+")
TOKEN_RE = re.compile(r"[A-Za-z0-9_.:/\\-]+|[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]+")


@dataclass(frozen=True)
class IndexedFile:
    path: str
    source: str
    size: int
    sha256: str
    mtime: float


@dataclass(frozen=True)
class SearchResult:
    path: str
    source: str
    start_line: int
    end_line: int
    snippet: str
    rank: float
    citation: str


def rel_path(path: Path, repo_root: Path) -> str:
    return path.relative_to(repo_root).as_posix()


def should_skip(path: Path, repo_root: Path) -> bool:
    try:
        rel_parts = path.relative_to(repo_root).parts
    except ValueError:
        return True
    return any(part in EXCLUDED_PARTS for part in rel_parts)


def classify_source(relative_path: str) -> str:
    if "/" not in relative_path:
        return "root"
    if relative_path.startswith("knowledge/docs/"):
        return "knowledge_docs"
    if relative_path.startswith("knowledge/pending/"):
        return "knowledge_pending"
    if relative_path.startswith("knowledge/journal/"):
        return "knowledge_journal"
    if relative_path.startswith("knowledge/ops/"):
        return "knowledge_ops"
    if relative_path.startswith("template/"):
        return "template"
    if relative_path.startswith("output/"):
        return "output"
    return "other"


def iter_markdown_files(repo_root: Path) -> Iterable[Path]:
    for path in sorted(repo_root.rglob("*.md")):
        if should_skip(path, repo_root):
            continue
        if not path.is_file():
            continue
        yield path


def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")


def file_hash(content: str) -> str:
    return hashlib.sha256(content.encode("utf-8", errors="replace")).hexdigest()


def dedupe_preserve_order(items: Iterable[str]) -> list[str]:
    seen: set[str] = set()
    result: list[str] = []
    for item in items:
        if not item or item in seen:
            continue
        seen.add(item)
        result.append(item)
    return result


def segment_cjk_run(text: str) -> str:
    tokens: list[str] = [text]
    tokens.extend(text)
    if len(text) > 1:
        tokens.extend(text[i : i + 2] for i in range(len(text) - 1))
    return " ".join(dedupe_preserve_order(tokens))


def segment_for_fts(text: str) -> str:
    segmented = CJK_RE.sub(lambda match: f" {segment_cjk_run(match.group(0))} ", text)
    return re.sub(r"\s+", " ", segmented).strip()


def build_fts_query(query: str) -> str | None:
    segmented = segment_for_fts(query.lower())
    tokens = [token for token in TOKEN_RE.findall(segmented) if token.strip()]
    if not tokens:
        return None
    # Cap terms so very long pasted queries do not produce unusable MATCH strings.
    tokens = dedupe_preserve_order(tokens)[:80]
    quoted = []
    for token in tokens:
        safe = token.replace('"', '""')
        quoted.append(f'"{safe}"')
    return " OR ".join(quoted)


def chunk_lines(text: str, max_chars: int = 1800, max_lines: int = 80, overlap_lines: int = 2):
    lines = text.splitlines()
    if not lines:
        return
    i = 0
    while i < len(lines):
        start = i
        chars = 0
        chunk: list[str] = []
        while i < len(lines):
            line = lines[i]
            if chunk and (len(chunk) >= max_lines or chars + len(line) > max_chars):
                break
            chunk.append(line)
            chars += len(line) + 1
            i += 1
        text_value = "\n".join(chunk).strip()
        if text_value:
            yield start + 1, i, text_value
        if i >= len(lines):
            break
        i = max(i - overlap_lines, start + 1)


def connect(db_path: Path) -> sqlite3.Connection:
    db_path.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(str(db_path))
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA journal_mode=WAL")
    conn.execute("PRAGMA busy_timeout=5000")
    return conn


def remove_db_files(db_path: Path) -> None:
    for candidate in (
        db_path,
        Path(str(db_path) + "-wal"),
        Path(str(db_path) + "-shm"),
        Path(str(db_path) + "-journal"),
    ):
        try:
            candidate.unlink()
        except FileNotFoundError:
            pass


def recreate_schema(conn: sqlite3.Connection) -> None:
    conn.executescript(
        """
        DROP TABLE IF EXISTS chunks_fts;
        DROP TABLE IF EXISTS chunks;
        DROP TABLE IF EXISTS files;
        DROP TABLE IF EXISTS meta;

        CREATE TABLE files (
            path TEXT PRIMARY KEY,
            source TEXT NOT NULL,
            size INTEGER NOT NULL,
            sha256 TEXT NOT NULL,
            mtime REAL NOT NULL,
            indexed_at REAL NOT NULL
        );

        CREATE TABLE chunks (
            id TEXT PRIMARY KEY,
            path TEXT NOT NULL,
            source TEXT NOT NULL,
            start_line INTEGER NOT NULL,
            end_line INTEGER NOT NULL,
            text TEXT NOT NULL,
            sha256 TEXT NOT NULL
        );

        CREATE VIRTUAL TABLE chunks_fts USING fts5(
            text,
            chunk_id UNINDEXED,
            path UNINDEXED,
            source UNINDEXED,
            start_line UNINDEXED,
            end_line UNINDEXED,
            tokenize='unicode61'
        );

        CREATE TABLE meta (
            key TEXT PRIMARY KEY,
            value TEXT NOT NULL
        );

        CREATE INDEX idx_chunks_path ON chunks(path);
        CREATE INDEX idx_chunks_source ON chunks(source);
        """
    )


def index_repo(repo_root: Path, db_path: Path, rebuild: bool = False) -> dict[str, object]:
    if rebuild:
        remove_db_files(db_path)
    started = time.time()
    conn = connect(db_path)
    recreate_schema(conn)

    file_count = 0
    chunk_count = 0
    source_counts: dict[str, int] = {}

    for path in iter_markdown_files(repo_root):
        relative_path = rel_path(path, repo_root)
        source = classify_source(relative_path)
        content = read_text(path)
        stat = path.stat()
        sha = file_hash(content)
        indexed_at = time.time()
        indexed_file = IndexedFile(
            path=relative_path,
            source=source,
            size=stat.st_size,
            sha256=sha,
            mtime=stat.st_mtime,
        )
        conn.execute(
            "INSERT INTO files(path, source, size, sha256, mtime, indexed_at) VALUES (?, ?, ?, ?, ?, ?)",
            (
                indexed_file.path,
                indexed_file.source,
                indexed_file.size,
                indexed_file.sha256,
                indexed_file.mtime,
                indexed_at,
            ),
        )
        file_count += 1
        source_counts[source] = source_counts.get(source, 0) + 1

        for start_line, end_line, chunk_text_value in chunk_lines(content):
            chunk_sha = hashlib.sha256(
                f"{relative_path}:{start_line}:{end_line}:{chunk_text_value}".encode("utf-8", errors="replace")
            ).hexdigest()
            chunk_id = chunk_sha[:32]
            fts_text = segment_for_fts(f"{relative_path}\n{source}\n{chunk_text_value}")
            conn.execute(
                "INSERT INTO chunks(id, path, source, start_line, end_line, text, sha256) VALUES (?, ?, ?, ?, ?, ?, ?)",
                (chunk_id, relative_path, source, start_line, end_line, chunk_text_value, chunk_sha),
            )
            conn.execute(
                "INSERT INTO chunks_fts(text, chunk_id, path, source, start_line, end_line) VALUES (?, ?, ?, ?, ?, ?)",
                (fts_text, chunk_id, relative_path, source, start_line, end_line),
            )
            chunk_count += 1

    meta = {
        "schema_version": SCHEMA_VERSION,
        "repo_root": str(repo_root),
        "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S%z"),
        "file_count": file_count,
        "chunk_count": chunk_count,
        "source_counts": source_counts,
    }
    for key, value in meta.items():
        conn.execute(
            "INSERT INTO meta(key, value) VALUES (?, ?)",
            (key, json.dumps(value, ensure_ascii=False) if not isinstance(value, str) else value),
        )
    conn.commit()
    conn.close()
    return {
        "db_path": str(db_path),
        "file_count": file_count,
        "chunk_count": chunk_count,
        "source_counts": source_counts,
        "duration_ms": int((time.time() - started) * 1000),
    }


def compact_snippet(text: str, max_chars: int = 280) -> str:
    value = " ".join(line.strip() for line in text.splitlines() if line.strip())
    if len(value) <= max_chars:
        return value
    return value[: max_chars - 1].rstrip() + "..."


def search_index(db_path: Path, query: str, limit: int, source: str = "all") -> list[SearchResult]:
    if not db_path.exists():
        raise SystemExit(f"knowledge-search: index not found: {db_path}. Run index first.")
    fts_query = build_fts_query(query)
    if not fts_query:
        raise SystemExit("knowledge-search: query is empty after tokenization.")
    conn = connect(db_path)
    params: list[object] = [fts_query]
    source_clause = ""
    if source != "all":
        source_clause = " AND f.source = ?"
        params.append(source)
    params.append(limit)
    sql = f"""
        SELECT c.path, c.source, c.start_line, c.end_line, c.text, bm25(chunks_fts) AS rank
        FROM chunks_fts AS f
        JOIN chunks AS c ON c.id = f.chunk_id
        WHERE chunks_fts MATCH ?{source_clause}
        ORDER BY rank
        LIMIT ?
    """
    rows = conn.execute(sql, params).fetchall()
    conn.close()
    return [
        SearchResult(
            path=row["path"],
            source=row["source"],
            start_line=int(row["start_line"]),
            end_line=int(row["end_line"]),
            snippet=compact_snippet(row["text"]),
            rank=float(row["rank"]),
            citation=f"{row['path']}#L{row['start_line']}-L{row['end_line']}",
        )
        for row in rows
    ]


def status(db_path: Path) -> dict[str, object]:
    if not db_path.exists():
        return {"exists": False, "db_path": str(db_path)}
    conn = connect(db_path)
    file_count = conn.execute("SELECT COUNT(*) FROM files").fetchone()[0]
    chunk_count = conn.execute("SELECT COUNT(*) FROM chunks").fetchone()[0]
    source_rows = conn.execute("SELECT source, COUNT(*) AS count FROM files GROUP BY source ORDER BY source").fetchall()
    meta_rows = conn.execute("SELECT key, value FROM meta ORDER BY key").fetchall()
    conn.close()
    return {
        "exists": True,
        "db_path": str(db_path),
        "file_count": file_count,
        "chunk_count": chunk_count,
        "sources": {row["source"]: row["count"] for row in source_rows},
        "meta": {row["key"]: row["value"] for row in meta_rows},
    }


def print_index_result(payload: dict[str, object], as_json: bool) -> None:
    if as_json:
        print(json.dumps(payload, ensure_ascii=False, indent=2))
        return
    print(f"knowledge-search: indexed {payload['file_count']} file(s), {payload['chunk_count']} chunk(s)")
    print(f"db: {payload['db_path']}")
    print(f"duration_ms: {payload['duration_ms']}")
    source_counts = payload.get("source_counts", {})
    if isinstance(source_counts, dict):
        for source, count in sorted(source_counts.items()):
            print(f"- {source}: {count}")


def print_results(results: list[SearchResult], as_json: bool) -> None:
    if as_json:
        print(json.dumps([asdict(result) for result in results], ensure_ascii=False, indent=2))
        return
    print(f"knowledge-search: {len(results)} result(s)")
    for index, result in enumerate(results, start=1):
        print(f"{index}. {result.citation} [{result.source}]")
        print(f"   {result.snippet}")


def print_status(payload: dict[str, object], as_json: bool) -> None:
    if as_json:
        print(json.dumps(payload, ensure_ascii=False, indent=2))
        return
    if not payload.get("exists"):
        print(f"knowledge-search: index not found: {payload['db_path']}")
        return
    print(f"knowledge-search: index exists: {payload['db_path']}")
    print(f"files: {payload['file_count']}")
    print(f"chunks: {payload['chunk_count']}")
    sources = payload.get("sources", {})
    if isinstance(sources, dict):
        for source, count in sources.items():
            print(f"- {source}: {count}")


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Biz-compiler knowledge SQLite search")
    parser.add_argument("command", choices=["index", "rebuild", "search", "status"])
    parser.add_argument("--repo-root", required=True)
    parser.add_argument("--db-path", required=True)
    parser.add_argument("--query", default="")
    parser.add_argument("--limit", type=int, default=10)
    parser.add_argument(
        "--source",
        default="all",
        choices=["all", "root", "knowledge_docs", "knowledge_pending", "knowledge_journal", "knowledge_ops", "template", "output", "other"],
    )
    parser.add_argument("--json", action="store_true")
    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    args = parse_args(argv)
    repo_root = Path(args.repo_root).resolve()
    db_path = Path(args.db_path).resolve()

    if args.command in {"index", "rebuild"}:
        payload = index_repo(repo_root, db_path, rebuild=args.command == "rebuild")
        print_index_result(payload, args.json)
        return 0
    if args.command == "status":
        print_status(status(db_path), args.json)
        return 0
    if args.command == "search":
        if not args.query.strip():
            raise SystemExit("knowledge-search: -Query is required for search.")
        print_results(search_index(db_path, args.query, args.limit, args.source), args.json)
        return 0
    raise SystemExit(f"unknown command: {args.command}")


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
