# 10 Source Intake Contract

> Copy this file into `output/Biz-001-業務名/10-source-intake/contract.md` when an actual business is created.

## Contract Identity

| Field | Value |
|---|---|
| phase_id | `10-source-intake` |
| contract_version | `v0` |
| business_id | `<Biz-XXX>` |
| business_name | `<業務名>` |
| prepared_by | `<作業者>` |
| last_updated | `<YYYY-MM-DD>` |
| gate_result | `draft` |

## Scope From 00

| Field | Value |
|---|---|
| in_scope | `<対象に含めるもの>` |
| out_of_scope | `<対象外>` |
| external_or_sensitive_candidates | `<他部署、社外、個人情報、契約情報など>` |
| initial_goal | `<仮ゴール>` |
| entry_type | `existing_work` / `new_work` |
| work_unit | `single_business` / `workflow_or_operation` / `business_program` |
| delivery_shape | `single_executor` / `multi_executor_team` / `unknown` |
| source_posture | `first_party` / `source_holder_connected` / `proxy_hearsay` / `mixed` / `unknown` |
| 00_20_readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` |
| route_confirmed_by_requester | `yes` / `partial` / `not_applicable` |
| route_confirmation_source | `requester_answer` / `source_holder_answer` / `material_evidence` |
| source_candidates_from_00 | `<00から渡されたsource候補。providedはcollected + 未reviewへ正規化>` |

## Route Confirmation Policy

10は00から来たroute flagを消さない。source確認でrouteが変わる場合は、変更理由と差分を記録して20へ渡す。

| Field | Value |
|---|---|
| route_rechecked_in_10 | `yes` / `no` |
| route_confirmation_source | `00_handoff` / `source_holder_answer` / `reviewed_material` / `main_reclassification` |
| route_delta_from_00 | `none` / `existing_to_new` / `new_to_existing` / `single_to_program` / `program_to_single` / `route_uncertain_rework` |
| route_delta_reason | `<変更または維持の理由>` |

`route_delta_from_00 = route_uncertain_rework` の場合は20へ渡さず、10内追加観測または00へ戻す。

## Source Intake Contract
| Contract Item | Required State |
|---|---|
| source inventory | 主要sourceが `source_id` 付きで登録されている |
| source intake interaction | `question_turn_count`、`material_evidence_count`、`source_contact_attempt_count` があり、terminal result前のsource確認作業が見える |
| source status | `target` / `collected` / `reviewed` / `unavailable` が分かる。00由来の `provided` は残さない |
| source class | `primary` / `secondary` / `hearsay` / `assumption` 相当が分かる |
| actor separation | 実担当者、source holder、owner、承認者、利用許可者が混ざっていない |
| fact separation | `observed_fact` / `person_explanation` / `hypothesis` / `unconfirmed` が分かれている |
| provenance | 各主張に `observed` / `hypothesized` / `negotiated` / `derived` の由来がある |
| confidence | 各主張に `low` / `medium` / `high` がある |
| evidence | 主張を支えるsource_idまたはログ参照がある |
| permission | 権限、閲覧範囲、source利用許可、外部連絡条件が必要なものは未確認のまま進んでいない |
| counter_evidence | 反例、未確認、矛盾、near-missが記録されている |
| 20 readiness route | 00から来た `20_readiness` と route confirmation を10で再確認し、`20_input_contract`、`as_is_observed`、`route_delta_from_00` を付けて20へ渡す |
| handoff | 20へ渡すsource packetが作られている |

## Evidence Policy

| Claim Type | provenance | Initial confidence | Notes |
|---|---|---|---|
| observed_fact | `observed` | `medium` | 複数sourceまたは再現で `high` 候補 |
| person_explanation | `hypothesized` | `low` | 本人説明は重要だが観測済みではない。発話した事実を観測しても、説明内容のprovenanceは `observed` にしない |
| negotiated_scope | `negotiated` | `medium` | 合意でありvalidationではない |
| derived_claim | `derived` | 入力の最弱confidence以下 | 導出元を必ず残す |
| unconfirmed | `hypothesized` | `low` | 20へ渡す場合はdefer理由が必要 |

## Preflight Policy

必読ファイルの未読、timeout、途中打ち切りは10-source-intakeの結果ではない。`pass` / `defer` / `rework` / `stop` に分類せず、読了まで `preflight_retry` として再読込する。

## Gate Result

| Field | Value |
|---|---|
| result | `pass` / `defer` / `rework` / `stop` |
| terminality | `terminal` / `non-terminal loop` (`rework` は10内または00への戻りであり、10完了ではない) |
| reason | `<判断理由>` |
| rework_target | `10-source-intake` / `00-entry` / `none` |
| deferred_items | `<deferする未確認項目>` |
| defer_policy | `<20へ制約付きで渡す理由、次の確認先、must_resolve_before>` |
| next_phase | `20-decompose-encrs` / `none` |
| gate_policy_notes | `<gate-policy-matrix上の注意>` |
| completion_reviewer_result | `<pass/defer/rework/stop>` |
| completion_reviewer_notes | `<一次情報化、権限、代理/伝聞、差戻し理由>` |
| 20_readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` |
| 20_input_contract | `observed_as_is_sources` / `requirements_candidate_sources` / `business_program_hypotheses` |
| as_is_observed | `true` / `false` |

## Handoff Minimum

10から20へ渡す最小情報は次の通り。

- source intake interaction metadata: 質問回数、資料確認数、source holder接続数
- source inventoryへの参照
- observed facts一覧
- person explanation一覧
- hypotheses / unconfirmed一覧
- source不足と追加観測候補
- primary / secondary / hearsay / assumption の区別
- 実担当者、source holder、owner、承認者、利用許可者の区別
- scope外、external、sensitive候補
- confidenceが低いが20で扱う必要がある項目
- `20_readiness` / `20_input_contract` / `as_is_observed` / `route_delta_from_00` のroute確認
- `business_program` や `multi_executor_team` の場合、20で扱う設計候補と30以降へ送るexecutor/team staffing候補の分離