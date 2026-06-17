# Later Phase Notes

00-entry 中に出たが、00で深掘り・決定しない話を残す。

## Source-First Rule

後続phaseに見える話でも、実物、サンプル、ルール、台帳、ログ、担当者確認が必要なものは、まず10-source-intakeへ送る。

例:

- 手順、分岐、例外、重複経路は、20で分解する前に10でsource確認する。
- 必須列、入力項目、期限ルールは、40や50で契約/承認にする前に10でsource確認する。
- AI読取や自動化案は、30/60で設計する前に10でサンプルや現物を確認する。

## Notes

| note_id | first_check_phase | after_confirmed_phase | note | why_not_00 | source_or_speaker | status |
|---|---|---|---|---|---|---|
| `L-001` | `10-source-intake` | `20-decompose-encrs` | `<手順、例外、分岐、IPO候補>` | `source確認後にAs-Is分解で扱う` | `<誰/どこから>` | `open` |
| `L-002` | `10-source-intake` | `30-route-executor` | `<automation/Skill/human/external候補>` | `source確認後にroutingで扱う` | `<誰/どこから>` | `open` |
| `L-003` | `10-source-intake` | `40-ir-freeze` | `<IR/contract/manifest候補>` | `source確認後に契約凍結で扱う` | `<誰/どこから>` | `open` |
| `L-004` | `10-source-intake` | `50-consent` | `<承認/同意表示/差戻し候補>` | `source確認後にconsentで扱う` | `<誰/どこから>` | `open` |
| `L-005` | `10-source-intake` | `60-validation` | `<test/検証/fresh executor候補>` | `source確認後にvalidationで扱う` | `<誰/どこから>` | `open` |
| `L-006` | `none` | `70-improvement` | `<改善/eval/drift候補>` | `運用後に扱う` | `<誰/どこから>` | `open` |
| `L-007` | `none` | `80-operation` | `<運用/runbook/ledger候補>` | `運用phaseで扱う` | `<誰/どこから>` | `open` |

## Rule

後続phaseの話は捨てない。ただし、00のgate resultに必要な最小情報へ変換し、詳細判断は送る。

`first_check_phase = 10-source-intake` が付いたnoteは、10のsource inventoryやfact registerで確認してから、`after_confirmed_phase` へ渡す。
