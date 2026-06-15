# Phase Handoff and Contract Gate v0

- Status: v0
- Date: 2026-06-15
- Read when: phase-local README、contract、questions、checks、handoffを作る時

## Purpose

この文書は、各数字phaseの末尾で何を確認し、何を次phaseへ渡すかを揃えるための共通ルールである。

Contract Gate は独立した大きなphaseではない。各phase末尾に入る出口チェックであり、「次へ進めるだけの契約条件が揃ったか」を見る。

## Terms

| Term | 意味 |
|---|---|
| `phase artifact` | phase内で作った成果物、表、contract、ledger、view |
| `handoff packet` | 次phaseへ渡す最小情報の束 |
| `contract gate` | phase末尾の出口チェック。通す、戻す、保留する |
| `rework target` | 不足が見つかった時に戻すphaseまたはartifact |

## Common Handoff Packet

全phaseのhandoffには、最低限これを持たせる。

| Field | 意味 |
|---|---|
| `phase_id` | handoff元phase |
| `business_scope` | 今回のscopeとout-of-scope |
| `inputs_used` | このphaseで使った入力 |
| `artifacts_produced` | 作った成果物 |
| `contracts_frozen` | このphaseで凍結したcontract |
| `open_hypotheses` | 未検証仮説、低confidence項目 |
| `evidence` | 主張を支える根拠 |
| `counter_evidence` | 反例、near-miss、差戻し、未確認 |
| `gate_policy` | 次へ渡す時のgate要求 |
| `rework_targets` | 不足時に戻る先 |
| `next_phase` | 次に進めるphase |

## Common Contract Gate Check

各phase末尾で、最低限これを確認する。

| Check | 問い |
|---|---|
| 入力 | このphaseの判断に必要な入力が揃っているか |
| 由来 | 重要な主張にprovenanceとevidenceがあるか |
| confidence | 低confidenceを高confidenceのように扱っていないか |
| scope | scope内、scope外、external、sensitiveを混ぜていないか |
| contract | 入力、責務、出力、gate、handoffが書かれているか |
| gate | `gate-policy-matrix.md` に照らして最低gateを満たすか |
| 反例 | counter_evidenceやnear-missを落としていないか |
| 孤児 | 次phaseへ行き先のない手順、判断、成果物がないか |
| 差戻し | 不足がある場合、戻り先が明確か |

## Phase-Specific Handoff

| From | To | 渡すもの | 止める条件 |
|---|---|---|---|
| `00-entry` | `10-source-intake` | 業務候補、scope、仮ゴール、初期リスク、読むsource候補 | 対象業務やscopeが曖昧 |
| `10-source-intake` | `20-decompose-encrs` | source inventory、observed facts、本人説明、未確認、provenance | source不足、由来不明、事実と推測の混在 |
| `20-decompose-encrs` | `30-route-executor` | As-Is手順、IPO候補、disposition、N-interface候補、例外 | orphan手順、dispositionなし、共有interface変更の見落とし |
| `30-route-executor` | `40-ir-freeze` | executor routing、自律レベル、gate案、human-only理由、危険組合せ | executor未定、gate不足、危険組合せ未解決 |
| `40-ir-freeze` | `50-consent` | IR draft/freeze、contract、manifest delta、未検証仮説 | IRにevidence/gate/scopeがない、表示と実行payloadの境界不明 |
| `50-consent` | `60-validation` | consent packet、approval record、差戻し理由、同意済みcontract | approvalが曖昧、保留項目が実行対象に混入 |
| `60-validation` | `70/80` | validation result、rework項目、pass/defer/rework判定 | fresh executorが迷う、型は通るが意味が通らない、反例あり |
| `70-improvement` | `30/40/50/80` | 改善案、drift、near-miss、昇降格候補 | 本番反映に必要なapproval/gateがない |
| `80-operation` | `70-improvement` | operation ledger、event log、audit link、停止/エスカレーション | ledgerがなく改善判断の根拠がない |

## Rework Rule v0

差戻しは、問題を所有する最も早いphaseへ戻す。

| 問題 | 戻る先 |
|---|---|
| scopeや対象業務が違う | `00-entry` |
| sourceや観測根拠が足りない | `10-source-intake` |
| As-Is分解やdispositionが不足 | `20-decompose-encrs` |
| executor、autonomy、gateが危険 | `30-route-executor` |
| IR、contract、manifest deltaが不足 | `40-ir-freeze` |
| 人間同意、保留、差戻し理由が不足 | `50-consent` |
| 実行可能性や検証条件が不足 | `60-validation` |

40以降のcontractを変えた場合、下流のconsent / validation / operationはそのまま有効とみなさない。v0では、該当artifactに `stale` と理由を残し、正式なRevision/Recompile Modelは70/80到達後に整備する。

## Contract Gate Output

contract gateの結果は、次のどれかにする。

| Result | 意味 |
|---|---|
| `pass` | 次phaseへ渡せる |
| `defer` | 未確認はあるが、明示した制約付きで次へ進める |
| `rework` | 指定phaseへ戻す |
| `stop` | scope外、危険組合せ、外部作用などで止める |

`defer` を使う時は、未確認事項、期限、次に検証するphase、gateを必ず書く。

## Do Not

- Contract Gateを独立phaseとして増やさない。
- approvalをvalidationとして扱わない。
- 低confidence項目を、handoff時に黙って確定扱いにしない。
- 下流artifactがstaleになった時に、理由なしで使い続けない。
- phase-local不足をmeta台帳へ混ぜない。

## Update Rule

この文書を変える場合は、`phase-catalog.md`、`gate-policy-matrix.md`、`evidence-confidence-model.md`、各 `template/<phase>/README.md`、将来のphase contract雛形へ影響するかを確認する。