"""Lightweight persistent code-impact graph for Biz-compiler meta assets."""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sqlite3
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Sequence

VERSION = "code-impact-v0.1"
EXCLUDED_PARTS = {".git", ".index", ".venv", "node_modules", "__pycache__", ".mypy_cache", ".pytest_cache"}
INCLUDED_EXTS = {".md", ".ps1", ".py", ".json", ".html", ".yml", ".yaml", ".txt", ".cmd", ".bat"}
ROOT_FILES = {"AGENTS.md", "Hello-world.md", "SOUL.md", "USER.md", "COMPASS.md", "MEMORY.md", "README.md", "setup.md", ".gitignore", ".gitattributes"}
MAX_WEAK_TOKEN_FANOUT = 50
DEFAULT_LIMIT = 60
PATH_LIKE_RE = re.compile(r"(?<![A-Za-z0-9_])(?:\.?[A-Za-z0-9_.-]+[\\/])+[A-Za-z0-9_.-]+")
FILE_NAME_RE = re.compile(r"(?<![A-Za-z0-9_])([A-Za-z0-9_.-]+\.(?:md|ps1|py|json|html|yml|yaml|txt|cmd|bat))(?![A-Za-z0-9_])", re.I)
MARKDOWN_LINK_RE = re.compile(r"\[[^\]]*\]\(([^)\s]+)")
INLINE_CODE_RE = re.compile(r"`([^`]+)`")
WORD_RE = re.compile(r"\b[A-Za-z_][A-Za-z0-9_-]{2,}\b")
JSON_KEY_RE = re.compile(r'"([A-Za-z0-9_.:/-]{2,})"\s*:')
PS_FUNCTION_RE = re.compile(r"(?im)^\s*function\s+([A-Za-z_][A-Za-z0-9_-]*)")
PS_PARAM_BLOCK_RE = re.compile(r"(?ims)param\s*\((.*?)\)")
PS_PARAM_RE = re.compile(r"\$([A-Za-z_][A-Za-z0-9_]*)")
PY_DEF_RE = re.compile(r"(?m)^\s*(?:async\s+def|def)\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(")
PY_CLASS_RE = re.compile(r"(?m)^\s*class\s+([A-Za-z_][A-Za-z0-9_]*)\b")
ARGPARSE_ADD_PARSER_RE = re.compile(r"\.add_parser\(\s*['\"]([^'\"]+)['\"]")
ARGPARSE_CHOICES_RE = re.compile(r"choices\s*=\s*\[([^\]]+)\]")
QUOTED_STRING_RE = re.compile(r"['\"]([^'\"]+)['\"]")
RISK_PATTERNS = [
    ("shell", re.compile(r"\b(shell|bash|cmd)\b|Start-Process|Invoke-Expression|subprocess\.|os\.system", re.I)),
    ("file-write", re.compile(r"Set-Content|Out-File|Remove-Item|Move-Item|Copy-Item|WriteAllText", re.I)),
    ("external-call", re.compile(r"Invoke-WebRequest|Invoke-RestMethod|\bcurl\b|requests\.|\bfetch\s*\(|\bemail\b|\bsmtp\b|\bsend\b", re.I)),
    ("secret-env", re.compile(r"\$env:|os\.environ|\bsecret\b|\btoken\b|\bpassword\b|api[_-]?key", re.I)),
]
COMMON_WEAK_TOKENS = {"readme", "index", "template", "output", "knowledge", "docs", "journal", "pending", "json", "html", "python", "powershell", "script", "command", "function", "status", "result", "value", "path", "file", "files", "name", "type", "kind", "source", "target", "title", "reason", "risk", "risks"}

@dataclass(frozen=True)
class FileRecord:
    path: str
    source: str
    ext: str
    sha256: str
    mtime: float
    size: int
    text: str

@dataclass(frozen=True)
class TokenHit:
    path: str
    kind: str
    value: str
    role: str
    line: int
    confidence: float

@dataclass(frozen=True)
class Edge:
    from_path: str
    to_path: str
    edge_kind: str
    token: str
    line: int
    confidence: float
    reason: str

def rel_path(path: Path, repo_root: Path) -> str:
    return path.relative_to(repo_root).as_posix()

def normalize_rel_path(value: str) -> str:
    candidate = value.strip().strip("`'\"<>[](){}.,;:")
    candidate = candidate.split("#", 1)[0].split("?", 1)[0].replace("\\", "/")
    while candidate.startswith("./"):
        candidate = candidate[2:]
    return re.sub(r"/+", "/", candidate).strip("/")

def normalize_token(kind: str, value: str) -> str:
    normalized = normalize_rel_path(value) if kind in {"path", "basename", "stem", "script"} else value.strip()
    return normalized.lower()

def confidence_label(value: float) -> str:
    return "high" if value >= 0.85 else "medium" if value >= 0.6 else "low"

def split_items(value: str | Sequence[str]) -> list[str]:
    raw_items = [value] if isinstance(value, str) else [str(item) for item in value]
    result, seen = [], set()
    for item in raw_items:
        for part in re.split(r"\r?\n|;", item):
            cleaned = normalize_rel_path(part)
            if cleaned and cleaned not in seen:
                seen.add(cleaned)
                result.append(cleaned)
    return result

def should_skip(path: Path, repo_root: Path) -> bool:
    try:
        rel_parts = path.relative_to(repo_root).parts
    except ValueError:
        return True
    return any(part in EXCLUDED_PARTS for part in rel_parts) or (bool(rel_parts) and rel_parts[0] == "output")

def classify_source(relative_path: str) -> str:
    if "/" not in relative_path:
        return "root"
    for prefix, source in [("knowledge/docs/", "knowledge_docs"), ("knowledge/pending/", "knowledge_pending"), ("knowledge/journal/", "knowledge_journal"), ("knowledge/ops/", "knowledge_ops"), ("template/", "template")]:
        if relative_path.startswith(prefix):
            return source
    return "other"

def should_index_file(path: Path, repo_root: Path) -> bool:
    if should_skip(path, repo_root) or not path.is_file():
        return False
    relative_path = rel_path(path, repo_root)
    parts = Path(relative_path).parts
    if len(parts) == 1:
        return path.name in ROOT_FILES or path.suffix.lower() in INCLUDED_EXTS
    return parts[0] in {"knowledge", "template"} and path.suffix.lower() in INCLUDED_EXTS

def iter_indexable_paths(repo_root: Path) -> Iterable[Path]:
    for path in sorted(repo_root.rglob("*")):
        if should_index_file(path, repo_root):
            yield path

def read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8", errors="replace")

def file_hash(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8", errors="replace")).hexdigest()

def collect_files(repo_root: Path) -> list[FileRecord]:
    records = []
    for path in iter_indexable_paths(repo_root):
        text = read_text(path)
        stat = path.stat()
        relative_path = rel_path(path, repo_root)
        records.append(FileRecord(relative_path, classify_source(relative_path), path.suffix.lower(), file_hash(text), stat.st_mtime, stat.st_size, text))
    return records
def connect(db_path: Path) -> sqlite3.Connection:
    db_path.parent.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(str(db_path))
    conn.row_factory = sqlite3.Row
    conn.execute("PRAGMA journal_mode=WAL")
    conn.execute("PRAGMA busy_timeout=5000")
    return conn

def remove_db_files(db_path: Path) -> None:
    for candidate in (db_path, Path(str(db_path) + "-wal"), Path(str(db_path) + "-shm"), Path(str(db_path) + "-journal")):
        try:
            candidate.unlink()
        except FileNotFoundError:
            pass

def recreate_schema(conn: sqlite3.Connection) -> None:
    conn.executescript("""
        DROP TABLE IF EXISTS edges;
        DROP TABLE IF EXISTS file_tokens;
        DROP TABLE IF EXISTS tokens;
        DROP TABLE IF EXISTS files;
        DROP TABLE IF EXISTS meta;
        CREATE TABLE meta (key TEXT PRIMARY KEY, value TEXT NOT NULL);
        CREATE TABLE files (path TEXT PRIMARY KEY, source TEXT NOT NULL, ext TEXT NOT NULL, sha256 TEXT NOT NULL, mtime REAL NOT NULL, size INTEGER NOT NULL, indexed_at REAL NOT NULL);
        CREATE TABLE tokens (id INTEGER PRIMARY KEY AUTOINCREMENT, kind TEXT NOT NULL, value TEXT NOT NULL, normalized_value TEXT NOT NULL, UNIQUE(kind, normalized_value));
        CREATE TABLE file_tokens (file_path TEXT NOT NULL, token_id INTEGER NOT NULL, role TEXT NOT NULL, line INTEGER NOT NULL, confidence REAL NOT NULL, FOREIGN KEY(token_id) REFERENCES tokens(id));
        CREATE TABLE edges (id INTEGER PRIMARY KEY AUTOINCREMENT, from_path TEXT NOT NULL, to_path TEXT NOT NULL, edge_kind TEXT NOT NULL, token TEXT NOT NULL, line INTEGER NOT NULL, confidence REAL NOT NULL, reason TEXT NOT NULL);
        CREATE INDEX idx_files_source ON files(source);
        CREATE INDEX idx_tokens_kind_norm ON tokens(kind, normalized_value);
        CREATE INDEX idx_file_tokens_file ON file_tokens(file_path);
        CREATE INDEX idx_file_tokens_token ON file_tokens(token_id);
        CREATE INDEX idx_edges_from ON edges(from_path);
        CREATE INDEX idx_edges_to ON edges(to_path);
        CREATE INDEX idx_edges_token ON edges(token);
    """)

def add_token_hit(hits: list[TokenHit], path: str, kind: str, value: str, role: str, line: int, confidence: float) -> None:
    if value and value.strip():
        hits.append(TokenHit(path, kind, value.strip(), role, max(1, line), confidence))

def add_edge(edges: list[Edge], from_path: str, to_path: str, edge_kind: str, token: str, line: int, confidence: float, reason: str) -> None:
    if from_path and to_path and from_path != to_path:
        edges.append(Edge(from_path, to_path, edge_kind, token, max(1, line), confidence, reason))

def find_line(text: str, start_index: int) -> int:
    return text.count("\n", 0, start_index) + 1

def extract_definitions(record: FileRecord) -> list[TokenHit]:
    hits: list[TokenHit] = []
    path_obj = Path(record.path)
    add_token_hit(hits, record.path, "path", record.path, "define", 1, 1.0)
    add_token_hit(hits, record.path, "basename", path_obj.name, "define", 1, 0.85)
    if path_obj.stem:
        add_token_hit(hits, record.path, "stem", path_obj.stem, "define", 1, 0.65)
    if record.ext in {".ps1", ".py", ".cmd", ".bat"}:
        add_token_hit(hits, record.path, "script", path_obj.name, "define", 1, 0.9)
        add_token_hit(hits, record.path, "script", path_obj.stem, "define", 1, 0.7)
    if record.ext == ".ps1":
        for match in PS_FUNCTION_RE.finditer(record.text):
            add_token_hit(hits, record.path, "symbol", match.group(1), "define", find_line(record.text, match.start()), 0.95)
        for block in PS_PARAM_BLOCK_RE.finditer(record.text):
            block_text, block_start = block.group(1), block.start(1)
            for param_match in PS_PARAM_RE.finditer(block_text):
                add_token_hit(hits, record.path, "param", param_match.group(1), "define", find_line(record.text, block_start + param_match.start()), 0.75)
    if record.ext == ".py":
        for match in PY_DEF_RE.finditer(record.text):
            add_token_hit(hits, record.path, "symbol", match.group(1), "define", find_line(record.text, match.start()), 0.95)
        for match in PY_CLASS_RE.finditer(record.text):
            add_token_hit(hits, record.path, "symbol", match.group(1), "define", find_line(record.text, match.start()), 0.95)
        for match in ARGPARSE_ADD_PARSER_RE.finditer(record.text):
            add_token_hit(hits, record.path, "command", match.group(1), "define", find_line(record.text, match.start()), 0.85)
        for match in ARGPARSE_CHOICES_RE.finditer(record.text):
            for choice_match in QUOTED_STRING_RE.finditer(match.group(1)):
                add_token_hit(hits, record.path, "command", choice_match.group(1), "define", find_line(record.text, match.start()), 0.75)
    if record.ext in {".json", ".html", ".md", ".yml", ".yaml"}:
        for match in JSON_KEY_RE.finditer(record.text):
            add_token_hit(hits, record.path, "key", match.group(1), "define", find_line(record.text, match.start()), 0.55)
    return hits

def extract_risk_hints(record: FileRecord) -> list[TokenHit]:
    hits: list[TokenHit] = []
    for line_number, line in enumerate(record.text.splitlines(), start=1):
        for risk_name, pattern in RISK_PATTERNS:
            match = pattern.search(line)
            if match:
                add_token_hit(hits, record.path, "risk", f"{risk_name}:{match.group(0)}", "risk", line_number, 0.8)
    return hits

def extract_path_mentions(line: str) -> list[str]:
    candidates = [m.group(1) for m in MARKDOWN_LINK_RE.finditer(line)]
    candidates.extend(m.group(1) for m in INLINE_CODE_RE.finditer(line))
    candidates.extend(m.group(0) for m in PATH_LIKE_RE.finditer(line))
    candidates.extend(m.group(1) for m in FILE_NAME_RE.finditer(line))
    return candidates
def build_path_edges(records: list[FileRecord]) -> tuple[list[TokenHit], list[Edge]]:
    hits: list[TokenHit] = []
    edges: list[Edge] = []
    by_rel = {normalize_rel_path(record.path).lower(): record.path for record in records}
    by_basename: dict[str, list[str]] = {}
    by_stem: dict[str, list[str]] = {}
    for record in records:
        path_obj = Path(record.path)
        by_basename.setdefault(path_obj.name.lower(), []).append(record.path)
        if len(path_obj.stem) >= 3:
            by_stem.setdefault(path_obj.stem.lower(), []).append(record.path)
    for record in records:
        for line_number, line in enumerate(record.text.splitlines(), start=1):
            for raw_candidate in extract_path_mentions(line):
                candidate = normalize_rel_path(raw_candidate)
                if not candidate:
                    continue
                candidate_lower = candidate.lower()
                if candidate_lower in by_rel:
                    add_token_hit(hits, record.path, "path", candidate, "mention", line_number, 0.95)
                    add_edge(edges, record.path, by_rel[candidate_lower], "path-reference", candidate, line_number, 0.95, "repo-relative path reference")
                    continue
                basename = Path(candidate).name.lower()
                if basename in by_basename:
                    add_token_hit(hits, record.path, "basename", basename, "mention", line_number, 0.65)
                    for to_path in by_basename[basename]:
                        add_edge(edges, record.path, to_path, "basename-reference", basename, line_number, 0.65, "basename reference")
                    continue
                stem = Path(candidate).stem.lower()
                if stem and stem not in COMMON_WEAK_TOKENS and stem in by_stem:
                    add_token_hit(hits, record.path, "stem", stem, "mention", line_number, 0.45)
                    for to_path in by_stem[stem]:
                        add_edge(edges, record.path, to_path, "stem-reference", stem, line_number, 0.45, "stem reference")
            for word_match in WORD_RE.finditer(line):
                word = word_match.group(0).lower()
                if word not in COMMON_WEAK_TOKENS and word in by_stem:
                    add_token_hit(hits, record.path, "stem", word, "mention", line_number, 0.4)
                    for to_path in by_stem[word]:
                        add_edge(edges, record.path, to_path, "stem-reference", word, line_number, 0.4, "word-to-stem reference")
    return hits, edges

def extract_definition_index(definition_hits: list[TokenHit]) -> dict[tuple[str, str], list[TokenHit]]:
    index: dict[tuple[str, str], list[TokenHit]] = {}
    for hit in definition_hits:
        if hit.role != "define" or hit.kind in {"path", "basename", "stem", "script"}:
            continue
        key = (hit.kind, normalize_token(hit.kind, hit.value))
        if len(key[1]) >= 3 and key[1] not in COMMON_WEAK_TOKENS:
            index.setdefault(key, []).append(hit)
    return index

def build_symbol_edges(records: list[FileRecord], definition_hits: list[TokenHit]) -> tuple[list[TokenHit], list[Edge]]:
    definition_index = extract_definition_index(definition_hits)
    if not definition_index:
        return [], []
    hits: list[TokenHit] = []
    edges: list[Edge] = []
    kinds_by_normalized: dict[str, set[str]] = {}
    for kind, normalized in definition_index:
        kinds_by_normalized.setdefault(normalized, set()).add(kind)
    for record in records:
        for line_number, line in enumerate(record.text.splitlines(), start=1):
            mention_values = [match.group(0) for match in WORD_RE.finditer(line)]
            mention_values.extend(match.group(1) for match in JSON_KEY_RE.finditer(line))
            seen_line_values: set[tuple[str, str]] = set()
            for value in mention_values:
                normalized = value.lower()
                if normalized not in kinds_by_normalized or normalized in COMMON_WEAK_TOKENS:
                    continue
                for kind in kinds_by_normalized[normalized]:
                    key = (kind, normalized)
                    if key in seen_line_values:
                        continue
                    seen_line_values.add(key)
                    add_token_hit(hits, record.path, kind, value, "mention", line_number, 0.55)
                    for definition in definition_index[key]:
                        confidence = 0.7 if kind in {"symbol", "command"} else 0.55
                        add_edge(edges, record.path, definition.path, f"{kind}-reference", value, line_number, confidence, f"{kind} token reference")
    return hits, edges

def dedupe_hits(hits: Iterable[TokenHit]) -> list[TokenHit]:
    result: list[TokenHit] = []
    seen: set[tuple[str, str, str, str, int]] = set()
    for hit in hits:
        key = (hit.path, hit.kind, normalize_token(hit.kind, hit.value), hit.role, hit.line)
        if key not in seen:
            seen.add(key)
            result.append(hit)
    return result

def dedupe_edges(edges: Iterable[Edge]) -> list[Edge]:
    result: list[Edge] = []
    seen: set[tuple[str, str, str, str, int, str]] = set()
    for edge in edges:
        key = (edge.from_path, edge.to_path, edge.edge_kind, edge.token.lower(), edge.line, edge.reason)
        if key not in seen:
            seen.add(key)
            result.append(edge)
    return result

def get_token_id(conn: sqlite3.Connection, kind: str, value: str) -> int:
    normalized = normalize_token(kind, value)
    conn.execute("INSERT OR IGNORE INTO tokens(kind, value, normalized_value) VALUES (?, ?, ?)", (kind, value, normalized))
    row = conn.execute("SELECT id FROM tokens WHERE kind = ? AND normalized_value = ?", (kind, normalized)).fetchone()
    return int(row["id"])

def index_repo(repo_root: Path, db_path: Path, rebuild: bool) -> dict[str, object]:
    if rebuild:
        remove_db_files(db_path)
    started = time.time()
    records = collect_files(repo_root)
    conn = connect(db_path)
    recreate_schema(conn)
    indexed_at = time.time()
    for record in records:
        conn.execute("INSERT INTO files(path, source, ext, sha256, mtime, size, indexed_at) VALUES (?, ?, ?, ?, ?, ?, ?)", (record.path, record.source, record.ext, record.sha256, record.mtime, record.size, indexed_at))
    definition_hits: list[TokenHit] = []
    risk_hits: list[TokenHit] = []
    for record in records:
        definition_hits.extend(extract_definitions(record))
        risk_hits.extend(extract_risk_hints(record))
    path_hits, path_edges = build_path_edges(records)
    symbol_hits, symbol_edges = build_symbol_edges(records, definition_hits)
    all_hits = dedupe_hits([*definition_hits, *risk_hits, *path_hits, *symbol_hits])
    all_edges = dedupe_edges([*path_edges, *symbol_edges])
    for hit in all_hits:
        token_id = get_token_id(conn, hit.kind, hit.value)
        conn.execute("INSERT INTO file_tokens(file_path, token_id, role, line, confidence) VALUES (?, ?, ?, ?, ?)", (hit.path, token_id, hit.role, hit.line, hit.confidence))
    for edge in all_edges:
        conn.execute("INSERT INTO edges(from_path, to_path, edge_kind, token, line, confidence, reason) VALUES (?, ?, ?, ?, ?, ?, ?)", (edge.from_path, edge.to_path, edge.edge_kind, edge.token, edge.line, edge.confidence, edge.reason))
    source_counts: dict[str, int] = {}
    for record in records:
        source_counts[record.source] = source_counts.get(record.source, 0) + 1
    meta: dict[str, object] = {"generator_version": VERSION, "repo_root": str(repo_root), "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S%z"), "file_count": len(records), "token_count": len(all_hits), "edge_count": len(all_edges), "source_counts": source_counts}
    for key, value in meta.items():
        conn.execute("INSERT INTO meta(key, value) VALUES (?, ?)", (key, value if isinstance(value, str) else json.dumps(value, ensure_ascii=False)))
    conn.commit()
    conn.close()
    return {"db_path": str(db_path), "file_count": len(records), "token_count": len(all_hits), "edge_count": len(all_edges), "source_counts": source_counts, "duration_ms": int((time.time() - started) * 1000)}
def load_meta(conn: sqlite3.Connection) -> dict[str, str]:
    return {row["key"]: row["value"] for row in conn.execute("SELECT key, value FROM meta ORDER BY key")}

def detect_staleness(repo_root: Path, db_path: Path) -> dict[str, object]:
    if not db_path.exists():
        return {"exists": False, "stale": True, "reason": "index missing", "missing_in_index": [], "changed": [], "deleted": []}
    records = collect_files(repo_root)
    current = {record.path: record for record in records}
    conn = connect(db_path)
    try:
        indexed_rows = conn.execute("SELECT path, sha256, size FROM files").fetchall()
    except sqlite3.Error as exc:
        conn.close()
        return {"exists": True, "stale": True, "reason": f"index unreadable: {exc}", "missing_in_index": [], "changed": [], "deleted": []}
    conn.close()
    indexed = {row["path"]: row for row in indexed_rows}
    missing_in_index = sorted(path for path in current if path not in indexed)
    deleted = sorted(path for path in indexed if path not in current)
    changed = sorted(path for path, record in current.items() if path in indexed and record.sha256 != indexed[path]["sha256"])
    stale = bool(missing_in_index or deleted or changed)
    return {"exists": True, "stale": stale, "reason": "stale" if stale else "fresh", "missing_in_index": missing_in_index, "changed": changed, "deleted": deleted}

def status_payload(repo_root: Path, db_path: Path) -> dict[str, object]:
    staleness = detect_staleness(repo_root, db_path)
    if not db_path.exists():
        return {"exists": False, "db_path": str(db_path), "staleness": staleness}
    conn = connect(db_path)
    try:
        file_count = conn.execute("SELECT COUNT(*) FROM files").fetchone()[0]
        token_count = conn.execute("SELECT COUNT(*) FROM file_tokens").fetchone()[0]
        edge_count = conn.execute("SELECT COUNT(*) FROM edges").fetchone()[0]
        source_rows = conn.execute("SELECT source, COUNT(*) AS count FROM files GROUP BY source ORDER BY source").fetchall()
        meta = load_meta(conn)
    finally:
        conn.close()
    return {"exists": True, "db_path": str(db_path), "file_count": file_count, "token_count": token_count, "edge_count": edge_count, "sources": {row["source"]: row["count"] for row in source_rows}, "meta": meta, "staleness": staleness}

def resolve_target_path(conn: sqlite3.Connection, target: str) -> str | None:
    normalized = normalize_rel_path(target)
    row = conn.execute("SELECT path FROM files WHERE lower(path) = lower(?)", (normalized,)).fetchone()
    if row:
        return str(row["path"])
    basename = Path(normalized).name
    if basename:
        rows = conn.execute("SELECT path FROM files WHERE lower(path) LIKE ? ORDER BY length(path), path", (f"%/{basename.lower()}",)).fetchall()
        if not rows:
            rows = conn.execute("SELECT path FROM files WHERE lower(path) = lower(?) ORDER BY length(path), path", (basename,)).fetchall()
        if len(rows) == 1:
            return str(rows[0]["path"])
    return None

def edge_token_fanout(conn: sqlite3.Connection, token: str) -> int:
    row = conn.execute("SELECT COUNT(*) AS count FROM edges WHERE lower(token) = lower(?)", (token,)).fetchone()
    return int(row["count"])

def adjacent_edges(conn: sqlite3.Connection, path: str) -> list[sqlite3.Row]:
    return conn.execute("""
        SELECT from_path, to_path, edge_kind, token, line, confidence, reason
        FROM edges
        WHERE from_path = ? OR to_path = ?
        ORDER BY confidence DESC, edge_kind, token, from_path, to_path
        """, (path, path)).fetchall()

def walk_graph(conn: sqlite3.Connection, targets: list[str], depth: int, limit: int) -> tuple[list[dict[str, object]], list[str]]:
    warnings: list[str] = []
    target_set, visited, frontier = set(targets), set(targets), set(targets)
    candidates: dict[str, dict[str, object]] = {}
    skipped_tokens: set[str] = set()
    for current_depth in range(1, max(0, depth) + 1):
        next_frontier: set[str] = set()
        for current_path in sorted(frontier):
            for edge in adjacent_edges(conn, current_path):
                from_path, to_path = str(edge["from_path"]), str(edge["to_path"])
                other_path = to_path if from_path == current_path else from_path
                if other_path in target_set:
                    continue
                token, confidence = str(edge["token"]), float(edge["confidence"])
                fanout = edge_token_fanout(conn, token)
                if confidence < 0.6 and fanout > MAX_WEAK_TOKEN_FANOUT:
                    warning_key = token.lower()
                    if warning_key not in skipped_tokens:
                        skipped_tokens.add(warning_key)
                        warnings.append(f"weak token fanout skipped: {token} ({fanout} edges)")
                    continue
                candidate = {"path": other_path, "depth": current_depth, "via": current_path, "edge_kind": str(edge["edge_kind"]), "token": token, "line": int(edge["line"]), "confidence_score": confidence, "confidence": confidence_label(confidence), "reason": str(edge["reason"])}
                existing = candidates.get(other_path)
                if existing is None or (current_depth, -confidence) < (int(existing["depth"]), -float(existing["confidence_score"])):
                    candidates[other_path] = candidate
                if other_path not in visited:
                    next_frontier.add(other_path)
                    visited.add(other_path)
                if len(candidates) >= limit:
                    break
            if len(candidates) >= limit:
                break
        if len(candidates) >= limit or not next_frontier:
            break
        frontier = next_frontier
    ordered = sorted(candidates.values(), key=lambda item: (int(item["depth"]), -float(item["confidence_score"]), str(item["path"])))
    if len(ordered) >= limit:
        warnings.append(f"related file limit reached: {limit}")
    return ordered[:limit], warnings

def fetch_symbols(conn: sqlite3.Connection, paths: Sequence[str], limit: int = 40) -> list[dict[str, object]]:
    if not paths:
        return []
    placeholders = ",".join("?" for _ in paths)
    rows = conn.execute(f"""
        SELECT DISTINCT ft.file_path, t.kind, t.value, ft.role, ft.line, ft.confidence
        FROM file_tokens ft JOIN tokens t ON t.id = ft.token_id
        WHERE ft.file_path IN ({placeholders}) AND t.kind IN ('symbol', 'command', 'key', 'param') AND ft.role IN ('define', 'mention')
        ORDER BY ft.confidence DESC, t.kind, t.value, ft.file_path LIMIT ?
        """, [*paths, limit]).fetchall()
    return [{"path": str(row["file_path"]), "kind": str(row["kind"]), "value": str(row["value"]), "role": str(row["role"]), "line": int(row["line"]), "confidence_score": float(row["confidence"]), "confidence": confidence_label(float(row["confidence"]))} for row in rows]

def fetch_risk_hints(conn: sqlite3.Connection, paths: Sequence[str], limit: int = 30) -> list[dict[str, object]]:
    if not paths:
        return []
    placeholders = ",".join("?" for _ in paths)
    rows = conn.execute(f"""
        SELECT ft.file_path, t.value, ft.line, ft.confidence
        FROM file_tokens ft JOIN tokens t ON t.id = ft.token_id
        WHERE ft.file_path IN ({placeholders}) AND t.kind = 'risk'
        ORDER BY ft.file_path, ft.line LIMIT ?
        """, [*paths, limit]).fetchall()
    return [{"path": str(row["file_path"]), "hint": str(row["value"]), "line": int(row["line"]), "confidence_score": float(row["confidence"]), "confidence": confidence_label(float(row["confidence"]))} for row in rows]
def validation_candidates(paths: Sequence[str]) -> list[str]:
    commands: list[str] = []
    seen: set[str] = set()
    def add(command: str) -> None:
        if command not in seen:
            seen.add(command)
            commands.append(command)
    add("git diff --check")
    add(".\\knowledge\\ops\\orchestrators\\code-impact\\code-impact.ps1 status")
    for path in paths[:20]:
        ext = Path(path).suffix.lower()
        win_path = path.replace("/", "\\")
        if ext == ".py":
            add(f"python -m py_compile {win_path}")
        elif ext == ".ps1":
            add("$errors = $null; " + f"[System.Management.Automation.Language.Parser]::ParseFile(\"{win_path}\", [ref]$null, [ref]$errors) | Out-Null; " + "if ($errors.Count) { throw ($errors | Out-String) }")
    return commands

def relative_db_path(db_path: Path, repo_root: Path) -> str:
    try:
        return db_path.relative_to(repo_root).as_posix()
    except ValueError:
        return str(db_path)

def query_index(repo_root: Path, db_path: Path, files_arg: str, depth: int, limit: int, allow_stale: bool) -> dict[str, object]:
    staleness = detect_staleness(repo_root, db_path)
    if staleness.get("stale") and not allow_stale:
        raise RuntimeError("code-impact: index is stale or missing. Run .\\knowledge\\ops\\orchestrators\\code-impact\\code-impact.ps1 rebuild")
    if not db_path.exists():
        raise RuntimeError("code-impact: index not found. Run .\\knowledge\\ops\\orchestrators\\code-impact\\code-impact.ps1 rebuild")
    requested_targets = split_items(files_arg)
    if not requested_targets:
        raise RuntimeError("code-impact: --files is required for query")
    conn = connect(db_path)
    try:
        targets: list[str] = []
        unresolved: list[str] = []
        for target in requested_targets:
            resolved = resolve_target_path(conn, target)
            if resolved:
                targets.append(resolved)
            else:
                unresolved.append(target)
        if unresolved:
            raise RuntimeError(f"code-impact: target file(s) not indexed: {', '.join(unresolved)}")
        related_files, warnings = walk_graph(conn, targets, depth=depth, limit=limit)
        if staleness.get("stale") and allow_stale:
            warnings.insert(0, "using stale index because --allow-stale was specified")
        selected_paths = list(dict.fromkeys([*targets, *[str(item["path"]) for item in related_files]]))
        symbols = fetch_symbols(conn, selected_paths)
        risk_hints = fetch_risk_hints(conn, selected_paths)
        meta = load_meta(conn)
        db_file_count = conn.execute("SELECT COUNT(*) FROM files").fetchone()[0]
        db_edge_count = conn.execute("SELECT COUNT(*) FROM edges").fetchone()[0]
    finally:
        conn.close()
    return {
        "targets": targets,
        "related_files": related_files,
        "symbols_and_keys": symbols,
        "risk_hints": risk_hints,
        "validation_candidates": validation_candidates(selected_paths),
        "index_status": {
            "db_path": relative_db_path(db_path, repo_root),
            "generated_at": meta.get("generated_at", "unknown"),
            "generator_version": meta.get("generator_version", "unknown"),
            "file_count": db_file_count,
            "edge_count": db_edge_count,
            "stale": bool(staleness.get("stale")),
            "stale_reason": staleness.get("reason"),
            "changed": staleness.get("changed", [])[:20],
            "missing_in_index": staleness.get("missing_in_index", [])[:20],
            "deleted": staleness.get("deleted", [])[:20],
        },
        "warnings": warnings,
    }

def print_index_result(payload: dict[str, object], as_json: bool) -> None:
    if as_json:
        print(json.dumps(payload, ensure_ascii=False, indent=2))
        return
    print(f"code-impact: indexed {payload['file_count']} file(s), {payload['token_count']} token hit(s), {payload['edge_count']} edge(s)")
    print(f"db: {payload['db_path']}")
    print(f"duration_ms: {payload['duration_ms']}")
    source_counts = payload.get("source_counts", {})
    if isinstance(source_counts, dict):
        for source, count in sorted(source_counts.items()):
            print(f"- {source}: {count}")

def print_status(payload: dict[str, object], as_json: bool) -> None:
    if as_json:
        print(json.dumps(payload, ensure_ascii=False, indent=2))
        return
    if not payload.get("exists"):
        print(f"code-impact: index not found: {payload['db_path']}")
        print("stale: yes")
        return
    print(f"code-impact: index exists: {payload['db_path']}")
    print(f"files: {payload['file_count']}")
    print(f"token_hits: {payload['token_count']}")
    print(f"edges: {payload['edge_count']}")
    staleness = payload.get("staleness", {})
    print(f"stale: {'yes' if staleness.get('stale') else 'no'}")
    for key in ("missing_in_index", "changed", "deleted"):
        values = staleness.get(key, []) if isinstance(staleness, dict) else []
        if values:
            print(f"{key}: {len(values)}")
            for value in values[:10]:
                print(f"- {value}")
    sources = payload.get("sources", {})
    if isinstance(sources, dict):
        for source, count in sources.items():
            print(f"- {source}: {count}")
def print_markdown(payload: dict[str, object]) -> None:
    print("## Code Impact Candidates")
    warnings = payload.get("warnings", [])
    if warnings:
        print("")
        print("> Warnings")
        for warning in warnings:
            print(f"> - {warning}")
    print("")
    print("### Related Files")
    related = payload.get("related_files", [])
    if not related:
        print("- None")
    else:
        for item in related:
            print(f"- {item['path']}")
            print(f"  - depth: {item['depth']}")
            print(f"  - via: {item['via']}")
            print(f"  - edge: {item['edge_kind']} `{item['token']}` at line {item['line']}")
            print(f"  - confidence: {item['confidence']}")
            print(f"  - reason: {item['reason']}")
    print("")
    print("### Symbols And Keys")
    symbols = payload.get("symbols_and_keys", [])
    if not symbols:
        print("- None")
    else:
        for item in symbols[:30]:
            print(f"- `{item['value']}` ({item['kind']}, {item['role']}, {item['confidence']}) - {item['path']}:{item['line']}")
    print("")
    print("### Risk Hints")
    risks = payload.get("risk_hints", [])
    if not risks:
        print("- None")
    else:
        for item in risks[:30]:
            print(f"- {item['path']}:{item['line']} - `{item['hint']}` ({item['confidence']})")
    print("")
    print("### Validation Candidates")
    for command in payload.get("validation_candidates", []):
        print(f"- `{command}`")
    print("")
    print("### Index Status")
    status = payload.get("index_status", {})
    print(f"- db: {status.get('db_path')}")
    print(f"- generated_at: {status.get('generated_at')}")
    print(f"- generator_version: {status.get('generator_version')}")
    print(f"- files: {status.get('file_count')}")
    print(f"- edges: {status.get('edge_count')}")
    print(f"- stale: {'yes' if status.get('stale') else 'no'}")

def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Biz-compiler lightweight code impact graph")
    parser.add_argument("command", choices=["index", "rebuild", "status", "query"])
    parser.add_argument("--repo-root", required=True)
    parser.add_argument("--db-path", required=True)
    parser.add_argument("--files", default="")
    parser.add_argument("--depth", type=int, default=2)
    parser.add_argument("--format", choices=["markdown", "json"], default="markdown")
    parser.add_argument("--limit", type=int, default=DEFAULT_LIMIT)
    parser.add_argument("--allow-stale", action="store_true")
    return parser.parse_args(argv)

def main(argv: list[str]) -> int:
    args = parse_args(argv)
    repo_root = Path(args.repo_root).resolve()
    db_path = Path(args.db_path).resolve()
    as_json = args.format == "json"
    try:
        if args.command in {"index", "rebuild"}:
            payload = index_repo(repo_root, db_path, rebuild=True)
            print_index_result(payload, as_json)
            return 0
        if args.command == "status":
            print_status(status_payload(repo_root, db_path), as_json)
            return 0
        if args.command == "query":
            payload = query_index(repo_root, db_path, args.files, args.depth, args.limit, args.allow_stale)
            if as_json:
                print(json.dumps(payload, ensure_ascii=False, indent=2))
            else:
                print_markdown(payload)
            return 0
    except RuntimeError as exc:
        if as_json:
            print(json.dumps({"error": str(exc)}, ensure_ascii=False, indent=2))
        else:
            print(str(exc), file=sys.stderr)
        return 2
    raise SystemExit(f"unknown command: {args.command}")

if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))