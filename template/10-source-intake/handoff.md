# 10 -> 20 Handoff Packet

このファイルは、10-source-intake から 20-decompose-encrs へ渡す最小情報の形である。実業務では10 terminal resultの `10_HANDOFF_START` / `10_HANDOFF_END` draftから `phase-orchestrator.ps1 finalize` がmaterializeする。

## Packet

| Field | Value |
|---|---|
| phase_id | `10-source-intake` |
| next_phase | `20-decompose-encrs` |
| entry_type | `existing_work` / `new_work` |
| work_unit | `single_business` / `workflow_or_operation` / `business_program` |
| delivery_shape | `single_executor` / `multi_executor_team` / `unknown` |
| source_posture | `first_party` / `source_holder_connected` / `proxy_hearsay` / `mixed` / `unknown` |
| route_confirmed_by_requester | `yes` / `partial` / `not_applicable` |
| route_confirmation_source | `00_handoff` / `source_holder_answer` / `reviewed_material` |
| route_delta_from_00 | `none` / `existing_to_new` / `new_to_existing` / `single_to_program` / `program_to_single` |
| business_scope | `<in-scope / out-of-scope summary>` |
| inputs_used | `<source_id list>` |
| artifacts_produced | `source-inventory.md`, `intake-log.md`, `fact-register.md` |
| contracts_frozen | `contract.md` |
| gate_result | `pass` / `defer` / `rework` / `stop` |
| terminality | `terminal` / `non-terminal loop` |
| completion_reviewer_result | `<pass/defer/rework/stop>` |
| completion_reviewer_notes | `<20へ渡す前の注意>` |

## Route Confirmation

| Field | Value |
|---|---|
| route_rechecked_in_10 | `yes` |
| route_confirmation_source | `00_handoff` / `source_holder_answer` / `reviewed_material` |
| route_delta_from_00 | `none` / `existing_to_new` / `new_to_existing` / `single_to_program` / `program_to_single` |
| route_delta_reason | `<source確認後も維持/変更する理由>` |

routeが不確実なままなら20へ渡さず、10内追加観測または00へ戻す。

## Source Intake Interaction
| Field | Value |
|---|---|
| question_turn_count | `<10担当がsource確認として投げた質問ターン数>` |
| material_evidence_count | `<実資料、ログ、画面、サンプル等を確認した数>` |
| source_contact_attempt_count | `<source holder / owner / 実担当者への接続または接続依頼数>` |
| source_gap_policy | `<10で追加観測 / 00へ戻す / 20へdefer の扱い>` |

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

## Deferred Claims For 20

`defer` で20へ渡す場合は、20が確定手順として扱ってよいものと、制約付きで扱うものを分ける。

| claim_id | deferred_item | current_confidence | why_20_can_continue | next_check | must_resolve_before |
|---|---|---|---|---|---|
| `<C-020>` | `<未確認事項>` | `low` | `<20で仮置き分解だけなら可能、など>` | `<追加source / owner確認>` | `<30-route-executor / 40-ir-freeze>` |

## 20 Readiness

10はsource確認の結果として、20へ渡す入口を確定する。00のrouteをそのまま写すだけでなく、source確認で必要なら戻す。

| Field | Value |
|---|---|
| 20_readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` |
| 20_input_contract | `observed_as_is_sources` / `requirements_candidate_sources` / `business_program_hypotheses` |
| as_is_observed | `true` / `false` |
| work_unit | `single_business` / `workflow_or_operation` / `business_program` |
| delivery_shape | `single_executor` / `multi_executor_team` / `unknown` |
| source_posture | `first_party` / `source_holder_connected` / `proxy_hearsay` / `mixed` / `unknown` |
| route_confirmed_by_requester | `yes` / `partial` / `not_applicable` |
| route_confirmation_source | `00_handoff` / `source_holder_answer` / `reviewed_material` |
| route_delta_from_00 | `none` / `existing_to_new` / `new_to_existing` / `single_to_program` / `program_to_single` |
| must_not_do_in_20 | executor routing, automation scope, team staffing are later-phase topics |

`as_is_decompose` は `as_is_observed = true` の時だけ使う。新規業務は `requirements_candidate`、新規事業や複数役割の派遣チーム相当は `business_design_candidate` として20へ渡す。

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
- `as_is_decompose` は `as_is_observed = true` の時だけ20へ渡す。
- `requirements_candidate` は課題、制約、成功条件、関係者、source候補から20で要求候補を切る入口にする。
- `business_design_candidate` は複数workflow/role候補を扱ってよいが、executor routingやteam staffing確定は30以降に送る。