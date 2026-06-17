# Source Inventory

10-source-intake で集めたsourceの台帳。

## Source Status Values

| Status | 意味 |
|---|---|
| `target` | 確認対象として挙げたが、まだ取得していない |
| `collected` | 取得済みだが、内容を十分に読んでいない |
| `reviewed` | 内容を確認し、claimへ接続済み |
| `unavailable` | 存在しない、アクセス不能、取得できない |

## Source Class Values

| source_class | 意味 |
|---|---|
| `primary` | 実作業、実データ、実ログ、実成果物など、対象業務を直接支えるsource |
| `secondary` | 手順書、まとめ資料、会議メモ、最終資料など、業務を間接的に説明するsource |
| `hearsay` | 代理説明、伝聞、本人以外から聞いた説明 |
| `assumption` | 作業者やassistantの仮説、未確認の推測 |

## Inventory

| source_id | source_type | source_class | source_ref | source_holder | owner | approver_or_permission | date_or_period | status | scope | data_class | supports | caveat |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `S-001` | `document` | `secondary` | `<path/url/name>` | `<持っている人/場所>` | `<owner>` | `<承認者/利用許可>` | `<YYYY-MM-DD>` | `target` | `in-scope` | `internal` | `<支える主張>` | `<注意点>` |

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
