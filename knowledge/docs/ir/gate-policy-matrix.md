# Gate Policy Matrix v0

- Status: v0
- Date: 2026-06-15
- Read when: `gate_policy`、scope境界、自律レベル、executor routing、同意ビュー、検証条件を決める時

## Purpose

この文書は、危険な組み合わせをphaseごとの気分で判断しないための最小gate表である。

`COMPASS.md` は「不可逆性・責任境界・復旧可能性を優先する」というheadingを持つ。実際に `gate_policy` をIRやcontractへ落とす時は、この文書を読む。

## Gate Values

| Gate | 意味 | 使う時 |
|---|---|---|
| `none` | gateなしで実行できる | in-scope、可逆、低影響、十分なevidenceがあり、外部作用がない |
| `report-after` | 実行後にledgerへ記録し、人間へ報告する | 可逆で低リスクだが、追跡性が必要な時 |
| `HITL-confirm` | 実行前に人間が確認する | 不可逆、costly-reversible、低confidence、責任境界が重い時 |
| `N-interface` | 他人・他部署・社外との共有interface変更として調整する | external / sensitive / 共有手順変更 / 社外送信 / 権限境界変更がある時 |
| `human-only` | AI/automationに実行させない | scope外、法務・契約・人事・高責任判断、本人判断そのものが成果物の時 |

複数条件に当てはまる場合は、強いgateを採用する。

```text
human-only > N-interface > HITL-confirm > report-after > none
```

## Inputs

Gateを決める時は、少なくとも次を見る。

| Input | 値の例 | 見る理由 |
|---|---|---|
| `scope` | `in-scope` / `out-of-scope` / `external` / `sensitive` | 管理対象か、境界変更かを分ける |
| `irreversibility` | `reversible` / `costly-reversible` / `irreversible` | 巻き戻し困難な作用を軽く扱わない |
| `executor` | `script` / `automation` / `Skill` / `orchestrator` / `human` / `external` | 実行主体ごとの事故の出方を分ける |
| `autonomy` | `suggest` / `draft` / `execute-after-confirm` / `full-auto` | 提案、下書き、実行を混ぜない |
| `data` | `public` / `internal` / `sensitive` / `contract` / `personal` | データ種別によって外部作用の重さが変わる |
| `confidence` | `low` / `medium` / `high` | 未検証の判断を自動化しない |
| `external_effect` | `none` / `notify` / `send` / `commit` / `order` / `delete` / `permission-change` | 外部に影響するかを見る |

## Minimum Matrix

| 条件 | 最低gate | 理由 |
|---|---|---|
| `scope = out-of-scope` | `human-only` | scope変更なしに静かに取り込まない |
| `scope = external` または N-interface候補あり | `N-interface` | 共有interface変更として扱う |
| `data = personal` または `contract` かつ外部送信あり | `N-interface` | 個人情報・契約情報の外部作用は共有境界を越える |
| `external_effect = order / delete / permission-change` | `HITL-confirm` 以上 | 発注、削除、権限変更は不可逆に近い |
| `irreversibility = irreversible` | `HITL-confirm` 以上 | 実績回数だけでfull-autoへ上げない |
| `irreversibility = costly-reversible` かつ executorがAI/automation系 | `HITL-confirm` | 戻せてもコストが高いなら事前確認する |
| `confidence = low` | `HITL-confirm` | 未検証仮説を自動実行しない |
| `confidence = medium` かつ `autonomy = full-auto` | `HITL-confirm` | full-autoには検証済みに近い根拠が必要 |
| AI/Skillが判断案だけを作る | `report-after` | 採用や外部反映は別gateで扱う |
| local read-only、可逆、in-scope、高confidence | `none` または `report-after` | 実行ログが必要ならreport-afterにする |

## Executor Notes

| Executor | v0の扱い |
|---|---|
| `human` | gate不要ではない。人間作業でもN-interfaceやapproval recordは必要になり得る |
| `script` | 決定的処理向き。外部作用がなければ `none` / `report-after` にしやすい |
| `automation` | repeat実行向き。不可逆・外部作用・低confidenceなら `HITL-confirm` 以上 |
| `Skill` | 判断補助や下書き向き。採用・送信・確定は別gateに分ける |
| `orchestrator` | 複数stepを束ねるため、内部stepごとのgate継承を明示する |
| `external` | 相手側の責務とinterfaceをcontract化し、原則 `N-interface` として扱う |

## Override Rule

Gateを弱める時は、contractまたはmanifest deltaに次を残す。

| Field | 必須内容 |
|---|---|
| `override_from` | 本来必要だったgate |
| `override_to` | 採用したgate |
| `reason` | なぜ弱めてよいか |
| `evidence` | 実績、検証、監査、shadow runなど |
| `residual_risk` | まだ残るリスク |
| `approved_by` | 人間承認者または承認記録 |

## Do Not

- `report-after` を責任移譲や承認済みとみなさない。
- HITLを置いただけでvalidation済みとみなさない。
- scope外を「便利だから」でin-scopeへ吸収しない。
- 実績回数だけで不可逆操作をfull-auto化しない。
- 同意ビューに表示した粗いgateを、実行時payloadの詳細gateと同一視しない。

## Update Rule

このmatrixを変える場合は、`minimum-ir-attributes.md`、`phase-handoff-and-contract-gate.md`、将来のIR schema、50-consent表示、60-validation観点へ影響するかを確認する。