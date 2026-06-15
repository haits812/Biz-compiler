# Knowledge Search Orchestrator

Markdown正本をSQLite FTS5へindexし、過去の会話、作業メモ、決定、ユーザー設定、templateメモを横断検索するrepo-local orchestratorである。

## 原則

- 正本はMarkdownファイルである。
- SQLiteは `knowledge/.index/knowledge.sqlite` に置く生成indexであり、直接編集しない。
- `knowledge/.index/*.sqlite` はgit管理しない。
- v0はMarkdownのみを対象にする。JSON、HTML、出力artifact、embedding/vector searchは必要になってから拡張する。

## 対象source

| source | 対象 |
|---|---|
| `root` | ルートの `*.md` |
| `knowledge_docs` | `knowledge/docs/**/*.md` |
| `knowledge_pending` | `knowledge/pending/**/*.md` |
| `knowledge_journal` | `knowledge/journal/**/*.md` |
| `knowledge_ops` | `knowledge/ops/**/*.md` |
| `template` | `template/**/*.md` |
| `output` | `output/**/*.md` |

## Natural Language Trigger

次のような自然文が出たら、ユーザーにコマンド名を求めず、このorchestratorを使う。

- 前にこんな会話しなかったっけ？
- 前にもこれ話した？
- あの時どう決めたっけ？
- 似た話、前にしてない？
- その設定どこかに残ってない？
- この話の経緯探して

まずユーザーの文をそのまま `-Query` に入れる。結果が弱い場合は、名詞・論点・日付・ファイル名などを2〜3語に分けて再検索する。
## Commands

indexを作る。

```powershell
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 index
```

DBを削除して作り直す。

```powershell
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 rebuild
```

検索する。

```powershell
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 search -Query "Hello World" -Limit 8
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 search -Query "承認 gate" -Source knowledge_docs
```

状態を見る。

```powershell
.\knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1 status
```

## 出力

検索結果は `path#Lstart-Lend`、source、snippetを返す。根拠へ戻れることを優先し、SQLite内の本文を正本として扱わない。

## 未実装

- session resume / export の専用コマンド
- embedding / vector search
- Markdown以外のHTML、JSON、契約artifact検索
- `output/Biz-001-*` の運用ledgerに特化した検索ビュー