# Upfront Existing Materials Fixtures

このフォルダは、00-entry の「初手で既存フロー、手順書、マニュアル、Excelを渡してくる」および「資料内容と依頼者発話が噛み合わない」テスト用fixtureである。

ここに置く資料は架空のテスト材料であり、正本要求でも実業務資料でもない。質問側phase agentが、資料を観測済みAs-Isや正本として扱わず、owner、更新日、実担当者、例外、差戻し履歴、実運用との差分を聞けるかを見るために使う。

## Files

| Persona | Fixture | 役割 | 期待する00-entryの扱い |
|---:|---|---|---|
| 31 | `p31-onboarding-flow.md` | 入退社手続きフロー図風資料 | フロー図のowner、更新日、実担当者、例外、退社scopeの欠落を確認して `defer` |
| 32 | `p32-invoice-payment-procedure.md` | 請求書支払処理の手順書 | 支払、承認、締め、例外、支払予定表への登録境界を確認して `defer` |
| 33 | `p33-sales-pipeline-register.csv` + `p33-sales-pipeline-notes.md` | 案件管理Excel風台帳 | 単一Excelを業務全体とみなさず、CRM、更新者、前後工程を確認して `defer` |
| 34 | `p34-cs-refund-complaint-manual.md` | 返金・クレーム対応マニュアル | 古いマニュアルと実運用差分、返金判断、顧客連絡、承認境界を確認して `defer` |
| 35 | `p35-order-processing-flow-proxy.md` | 代理者が持ってきた受注後処理フロー | 代理/伝聞と資料持ち込みを分け、本人/source holder未接続なら `rework` |
| 36 | `p36-manager-misreads-team-flow.md` | 上司が部下の受注後処理フローを営業日報自動化と誤読する資料 | 資料内容と発話の不一致を分け、実担当者/source holder未接続なら `rework` |
| 37 | `p37-overconfident-newcomer-misreads-procurement-flow.md` | 新入社員が購買承認依頼フローを発注自動化まで広げる資料 | 資料scopeと発話scopeを分け、発注/承認/外部連絡を未確定のまま `defer` |
| 38 | `p38-incoherent-request-with-expense-flow.md` | 経費精算フローを持つが採用・クレーム・在庫へ話が飛ぶ資料 | 対象業務を1つへ絞れないなら `rework` |

## Test Use

Paired subagent testでは、回答側persona agentに `personas/<id>/persona.md` のPersona Prompt、部署/役職、初回テーマ、該当fixtureだけを渡す。回答側personaには `COMPASS.md`、phase README、gate/checks、Biz-compiler内部語彙を渡さない。

質問側phase agentには通常どおり `COMPASS.md`、00-entry README、phase-local context、checksを渡す。fixtureの中身を見せる場合も、それは「ユーザーが持ち込んだ資料」として扱わせる。

## Expected Failure Modes

- 資料があるだけで `pass` にする。
- フロー図や手順書を実運用確認済みのAs-Isとして扱う。
- 古い版、owner不明、例外未記載、差戻し履歴なしを見落とす。
- Excel台帳を前後工程まで含む業務全体として扱う。
- 代理者が持ってきた資料を一次情報として扱う。
- 資料の内容と依頼者の発話が噛み合っていないのに、1つの業務として統合する。
