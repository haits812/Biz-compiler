# 00 Entry Contract

> Copy this file into `output/Biz-001-業務名/00-entry/contract.md` when an actual business is created.

## Contract Identity

| Field | Value |
|---|---|
| phase_id | `00-entry` |
| contract_version | `v0` |
| business_id | `<Biz-XXX or candidate>` |
| business_name | `<業務名候補>` |
| prepared_by | `<作業者>` |
| last_updated | `<YYYY-MM-DD>` |
| gate_result | `draft` |

## Entry Decision

| Field | Value |
|---|---|
| entry_type | `existing_work` / `new_work` / `unclear` |
| intent | `<automate/improve/redesign/reduce_manual_work/add_ai_support/create_new_operation/design_workflow/validate_idea/prepare_launch>` |
| target_statement | `<この業務候補を一文で説明>` |
| rough_goal | `<00時点の仮ゴール>` |
| requester | `<依頼者>` |
| actor_owner_candidate | `<担当者/責任者候補>` |
| user_candidate | `<利用者候補>` |
| approver_candidate | `<承認者候補または不明>` |

## Scope Contract

| Field | Value |
|---|---|
| in_scope | `<対象に含めるもの>` |
| out_of_scope | `<対象外>` |
| undecided_scope | `<まだ境界が曖昧なもの>` |
| rough_input | `<何を受け取って始まるか>` |
| rough_output | `<何を出すか>` |
| known_constraints | `<制約、期限、利用環境など>` |

## Material Contract

| Field | Value |
|---|---|
| existing_materials | `<マニュアル、手順書、ツール、ログ、画面、成果物など>` |
| concept_materials | `<構想メモ、参考例、想定シナリオなど>` |
| source_candidates_for_10 | `<10で確認するsource候補>` |
| unavailable_or_missing_materials | `<ない/取れない/未確認の材料>` |
| explanation_only_items | `<本人説明だけで根拠未確認の重要事項>` |

## Initial Risk Contract

| Risk | Status | Notes |
|---|---|---|
| external impact | `yes/no/unknown` | `<他部署、社外、顧客、共有interface>` |
| sensitive data | `yes/no/unknown` | `<個人情報、契約情報、機密情報>` |
| irreversible action | `yes/no/unknown` | `<外部送信、発注、確定、削除、権限変更>` |
| approval need | `yes/no/unknown` | `<人間確認が必要そうな箇所>` |
| responsibility unclear | `yes/no/unknown` | `<責任者/停止者が不明か>` |

## Boundary Contract

| Item | Required State |
|---|---|
| no As-Is decomposition | 詳細手順は20へ送る |
| no executor routing | automation / Skill / human 判断は30へ送る |
| no IR freeze | IR / manifest / schema は40へ送る |
| no consent design | 同意ビューやapproval displayは50へ送る |
| no validation design | test / fresh executor / validation planは60へ送る |
| later phase notes | 後続phaseの話は `artifacts/later-phase-notes.md` に残す |

## Gate Result

| Field | Value |
|---|---|
| result | `pass` / `defer` / `rework` / `stop` |
| reason | `<判断理由>` |
| rework_target | `00-entry` / `none` |
| deferred_items | `<10で検証する未確認事項>` |
| next_phase | `10-source-intake` |
| stop_reason | `<stopの場合の理由>` |

## Handoff Minimum

00から10へ渡す最小情報は次の通り。

- entry_type
- target_statement
- rough_goal
- scope in/out/undecided
- actor / owner / approver候補
- rough input/output
- source candidates
- initial risk hints
- unknowns / explanation-only items
- later phase notes