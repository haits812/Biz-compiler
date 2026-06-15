# Markdown正本をSQLite FTS5で検索するindexを追加する

## Context

Biz-compilerでは `MEMORY.md`、`knowledge/docs/decisions/`、`knowledge/journal/`、`knowledge/pending/`、`template/` などに知識が分散している。

Markdown正本のまま読みやすく保つ方針は維持したい。一方で、過去の会話、作業メモ、決定、ユーザー設定を横断して探すには、ファイルパス指定や `rg` だけでは将来的に弱くなる。

OpenSquillaのMemory実装を参考に、正本と検索indexを分ける発想を採用する。

## Decision

`knowledge/ops/orchestrators/knowledge-search/` を追加し、Markdown正本をSQLite FTS5へindex/searchする。

SQLite DBは `knowledge/.index/knowledge.sqlite` に生成する。これは生成物/cacheであり、正本ではない。

正本は引き続きMarkdownファイルとする。SQLite内の本文を直接編集しない。

## Scope

v0でindexするもの:

- rootの `*.md`
- `knowledge/docs/**/*.md`
- `knowledge/pending/**/*.md`
- `knowledge/journal/**/*.md`
- `knowledge/ops/**/*.md`
- `template/**/*.md`
- `output/**/*.md`

v0でやらないもの:

- embedding / vector search
- session resume / export専用コマンド
- HTML、JSON、契約artifactの構造検索
- SQLiteを正本にする運用

## Consequences

- 過去の決定や作業メモを `path#Lx-Ly` で引ける。
- `knowledge/.index/*.sqlite` は `.gitignore` で除外する。
- indexが古い時は `knowledge-search.ps1 index` で再生成する。
- 将来、session export/resumeを作る場合も、このindexを検索入口として使える。