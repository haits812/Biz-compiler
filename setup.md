# setup.md

> clone直後や環境を作り直した時に読む初期セットアップ入口。
>
> Hello World は現在地、AGENTS は作業規約、setup は環境構築である。

## Scope

このファイルは、Biz-compiler repoを動かすためのローカル環境前提、hook接続、生成物、初期化コマンドを書く。

ここに置くもの:

- 必要な外部ツール
- clone直後に実行する初期化
- 環境側へ接続するhook adapterの入口
- 生成物の置き場とcommitしないもの
- 壊れた時の再生成・確認コマンド

ここに置かないもの:

- 個別業務ごとの依存やrunbook
- phase-localな雛形や手順
- hook一覧の複製
- Skill / orchestrator / command台帳の複製

個別業務の依存は将来 `output/Biz-001-業務名/` 側へ置く。phase固有の依存は `template/<数字phase>/` 側へ置く。

## Required Tools

| tool | 用途 | 備考 |
|---|---|---|
| Git | clone、commit、push | `origin` は GitHub repo を指す |
| PowerShell | repo-local `.ps1` の実行 | Windows環境を前提にする |
| Python 3 | `knowledge-search` のSQLite FTS5 index/search | SQLiteはPython標準ライブラリ `sqlite3` を使う。別途SQLite CLIは必須ではない |

現時点で、Node.js や外部Python packageは必須ではない。必要になったらこのファイルに追記する。

## Clone後の初期確認

任意の場所へcloneしてよい。以降のコマンド例は、cloneしたrepo rootで実行する前提で相対パスを書く。

```powershell
git rev-parse --show-toplevel
git status --short --branch
python --version
```

Markdown正本やスクリプトには、特定PCのユーザーディレクトリやドライブ直下など、ローカル絶対パスを前提として焼かない。ローカル実パスを確認する必要がある時は、手元の一時出力か `git rev-parse --show-toplevel` の結果として扱う。

`Hello-world.md` が現在地の入口である。環境構築後、構成が変わった場合は最後に Hello World Gate を通す。

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `
  -Type "運用" `
  -Subject "初期セットアップを確認する" `
  -Reason "clone後の環境前提と現在地を同期するため。" `
  -Verified "git status、python --version、hook正本一覧の確認。" `
  -Risks "環境側hook接続は各実行環境で確認する。"
```

## Hooks

clone直後は、repo-local hook adapterをすべて環境側へ接続する。

hook一覧の正本:

- `knowledge/ops/registry.md`
- `knowledge/ops/hooks/README.md`

`setup.md` にはhook一覧を複製しない。追加・削除・改名は `knowledge/ops/registry.md` と `knowledge/ops/hooks/README.md` を更新し、最後に Hello World Gate を通す。

環境側の設定ファイル、deny list、local settingsは、このrepoから勝手に編集しない。Codex / Claude Code など各環境で、上記hook adapterを呼ぶ設定を再現する。

## Knowledge Search Index

Markdown正本の横断検索には `knowledge-search` を使う。

```powershell
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 index
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 search -Query "前にこんな会話しなかったっけ"
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 status
```

SQLite DBは次に生成される。

```text
knowledge/.index/knowledge.sqlite
```

これは生成物であり、正本ではない。古い、壊れた、検索結果が弱い時は作り直す。

```powershell
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 rebuild
```

## Generated Files

commitしない生成物:

- `knowledge/.index/*.sqlite`
- `knowledge/.index/*.sqlite-*`
- `__pycache__/`
- `*.pyc`

生成物の除外は `.gitignore` に置く。生成物を正本として編集しない。

## Final Check

セットアップや依存、hook接続、生成物ルールを変えたら、次を確認する。

```powershell
git status --short --branch
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 status
```

root構成、必須ファイル、hook/orchestrator/Skill、生成物ルールを変えた場合は Hello World Gate を通す。
