# 10 -> 20 Handoff Packet

このファイルは、10-source-intake から 20-decompose-encrs へ渡す最小情報の形である。

## Packet

| Field | Value |
|---|---|
| phase_id | `10-source-intake` |
| next_phase | `20-decompose-encrs` |
| business_scope | `<in-scope / out-of-scope summary>` |
| inputs_used | `<source_id list>` |
| artifacts_produced | `source-inventory.md`, `intake-log.md`, `fact-register.md` |
| contracts_frozen | `contract.md` |
| gate_result | `pass` / `defer` / `rework` / `stop` |
| completion_reviewer_result | `<pass/defer/rework/stop>` |
| completion_reviewer_notes | `<20へ渡す前の注意>` |

## Source Summary

| Source Group | source_id | What it supports | Status |
|---|---|---|---|
| primary workflow evidence | `<S-001>` | `<どの業務実態を支えるか>` | `<reviewed>` |
| input/output examples | `<S-002>` | `<入出力の対応>` | `<reviewed>` |
| person explanation | `<S-003>` | `<本人説明>` | `<collected>` |
| failure / near-miss | `<S-004>` | `<例外・差戻し>` | `<target/collected/reviewed>` |
| owner / approval evidence | `<S-005>` | `<owner、承認者、利用許可>` | `<target/collected/reviewed>` |

## Observed Facts For 20

| claim_id | Statement | source_id | confidence |
|---|---|---|---|
| `<C-001>` | `<観測済み事実>` | `<S-001>` | `<medium>` |

## Person Explanations For 20

| claim_id | Statement | source_id | confidence | Caveat |
|---|---|---|---|---|
| `<C-010>` | `<本人説明>` | `<S-003>` | `<low>` | `observedではない` |

## Hypotheses / Unconfirmed

| claim_id | Statement | Why it matters | Next check |
|---|---|---|---|
| `<C-020>` | `<未確認事項>` | `<20で分解に効く理由>` | `<追加観測または20でdefer>` |

## Reviewer Notes

| Lens | Note | Action |
|---|---|---|
| primary / secondary / hearsay / assumption | `<claim分類の注意>` | `<20へ渡す/10へ戻す/00へ戻す>` |
| real worker / source holder | `<実担当者またはsource holderへの接続>` | `<20へ渡す/10へ戻す/00へ戻す>` |
| owner / approver / permission | `<権限、承認、利用許可>` | `<20へ渡す/10へ戻す/stop>` |
| final artifact reverse-engineering | `<最終成果物だけから逆算していないか>` | `<20へ渡す/10へ戻す>` |

## Scope / Gate Notes

| Item | Note | Gate implication |
|---|---|---|
| external candidate | `<他部署・社外・共有interface候補>` | `N-interface候補` |
| sensitive candidate | `<個人情報・契約情報など>` | `HITL-confirm以上の候補` |
| out-of-scope | `<対象外>` | `human-onlyまたは00へ戻す候補` |

## Rework Targets

| Condition | Rework target |
|---|---|
| 対象業務やscopeが曖昧 | `00-entry` |
| sourceや観測根拠が足りない | `10-source-intake` |
| As-Is分解中にsource不足が判明 | `10-source-intake` |

## Handoff Notes

- 20では、`observed_fact` をAs-Is分解の主材料にする。
- `person_explanation` と `hypothesis` は軽視しないが、確定手順として扱わない。
- low confidenceのclaimからautomationやexecutor判断へ直行しない。
