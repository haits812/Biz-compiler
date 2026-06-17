# 案件管理Excel 補足メモ

> Persona 33: Excel台帳を正本視する営業企画担当向けfixture。
> CSVはExcel風台帳として使う。これは架空のテスト資料。

## Metadata

| Field | Value |
|---|---|
| document_type | Excel風案件管理台帳 |
| file_name | p33-sales-pipeline-register.csv |
| last_exported | 2026-06-05 |
| created_by | 営業企画担当 |
| current_owner | 営業企画だが、営業担当が直接編集することもある |
| source_system | CRM、Slack週報、口頭メモ、営業担当の手入力が混在 |
| known_gap | CRMとの差分、更新者、失注/解約防止の扱い、顧客情報の範囲が未整理 |

## Requester Claim

- このExcelを見れば、週次報告に必要なことは全部分かる。
- CRMは入力漏れが多いので、Excel側を正として扱いたい。
- 週次報告を自動生成したい。

## Known Issues

- `source_hint` が混在しており、観測済みsourceではない行がある。
- amountが0や未更新の行がある。
- `stage` の定義が現在の営業会議資料と違う可能性がある。
- 顧客名、商談名、金額を扱うため、共有範囲の確認が必要。
- `last_updated` は行更新日であり、元情報の鮮度ではない。

## 00-entry Test Trap

単一Excelを業務全体や正本として扱ってはいけない。CRM、Slack、口頭メモ、営業担当入力が混ざっているため、入力元、更新者、CRMとの差分、週次報告のowner、修正依頼の範囲、顧客情報の扱いを確認する必要がある。
