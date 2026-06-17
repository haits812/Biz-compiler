# Source Candidates

00-entry で見えた、10-source-intake が確認する材料候補。

## Candidate Status Values

| Status | 意味 |
|---|---|
| `target` | 確認対象として挙げたが、まだ取得していない |
| `provided` | ユーザーが渡したが、内容確認は10で行う。10へは `collected` + 未reviewとして渡す |
| `unavailable` | ない、取れない、アクセスできない |
| `unknown` | 存在有無が不明 |

## Source Candidates

| source_candidate_id | source_type | description | owner_or_location | status | 10_initial_status | supports | caveat |
|---|---|---|---|---|---|---|---|
| `SC-001` | `manual/tool/log/screen/output_sample/email/spreadsheet/concept_note/reference/interview` | `<確認する材料>` | `<所在/持ち主>` | `target` | `target` | `<何の確認に使うか>` | `<注意>` |

## 10 Handoff Mapping

| 00 status | 10 initial status | 注意 |
|---|---|---|
| `target` | `target` | まだ取得していない確認対象 |
| `provided` | `collected` | 受領済みだが未読。review済みにしない |
| `unavailable` | `unavailable` | 取れない理由を残す |
| `unknown` | `target` または00へrework | 存在確認が10のtaskなら `target`。何を確認するか曖昧なら00で絞る |

10-source-intake の正規statusに `provided` はない。`provided` をそのまま10へ渡さない。

## Existing Work Hints

| Source Type | 例 |
|---|---|
| `manual` | 手順書、マニュアル、SOP |
| `tool` | 業務システム、管理画面、Excel、SaaS |
| `output_sample` | 直近成果物、納品物、報告書 |
| `log` | 実行ログ、差戻し、near-miss、監査ログ |
| `email` | 依頼メール、通知、承認メール |
| `spreadsheet` | 管理表、台帳、チェック表 |

## New Work Hints

| Source Type | 例 |
|---|---|
| `concept_note` | 構想メモ、目的メモ |
| `reference` | 参考にしたい既存業務、外部例、規程 |
| `scenario` | 想定ユーザー、想定ケース、入力/出力例 |
| `constraint` | 期限、法務、運用体制、利用ツール制約 |
