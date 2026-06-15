# Knowledge Index

このディレクトリは、Markdown正本を検索するための生成物置き場である。

- 正本は `MEMORY.md`、`knowledge/docs/`、`knowledge/journal/`、`knowledge/pending/`、`template/` などのMarkdownファイル。
- `knowledge.sqlite` は `knowledge-search` が作るSQLite FTS5 indexであり、正本ではない。
- `*.sqlite` と `*.sqlite-*` は `.gitignore` で除外する。
- indexが古い場合は `knowledge-search.ps1 index` で作り直す。

```powershell
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 index
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 search -Query "検索語"
```