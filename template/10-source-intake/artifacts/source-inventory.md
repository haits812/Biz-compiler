# Source Inventory

10-source-intake で集めたsourceの台帳。

## Source Status Values

| Status | 意味 |
|---|---|
| `target` | 確認対象として挙げたが、まだ取得していない |
| `collected` | 取得済みだが、内容を十分に読んでいない |
| `reviewed` | 内容を確認し、claimへ接続済み |
| `unavailable` | 存在しない、アクセス不能、取得できない |

## Inventory

| source_id | source_type | source_ref | owner | date_or_period | status | scope | data_class | supports | caveat |
|---|---|---|---|---|---|---|---|---|---|
| `S-001` | `document` | `<path/url/name>` | `<owner>` | `<YYYY-MM-DD>` | `target` | `in-scope` | `internal` | `<支える主張>` | `<注意点>` |

## Source Type Hints

| source_type | 例 |
|---|---|
| `document` | 手順書、要件、規約、テンプレート |
| `file` | 入力ファイル、出力ファイル、管理表 |
| `log` | 実行ログ、差戻しログ、監査ログ |
| `interview` | 本人説明、会話ログ、ヒアリング |
| `observation` | 実演、画面確認、操作観察 |
| `mail` | メール、通知、依頼文 |
| `meeting` | 会議メモ、議事録 |
| `system` | 業務システム、管理画面、API |
