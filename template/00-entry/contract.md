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
| entry_type | `existing_work` / `new_work` / `unclear` (`unclear` はdraft/rework専用。handoff不可) |
| work_unit | `single_business` / `workflow_or_operation` / `business_program` / `unclear` |
| delivery_shape | `single_executor` / `multi_executor_team` / `unknown` |
| source_posture | `first_party` / `source_holder_connected` / `proxy_hearsay` / `mixed` / `unknown` |
| 20_readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` / `do_not_proceed_rework` / `do_not_proceed_stop` |
| intent | `<automate/improve/redesign/reduce_manual_work/add_ai_support/create_new_operation/design_workflow/validate_idea/prepare_launch>` |
| target_statement | `<この業務候補を一文で説明>` |
| rough_goal | `<00時点の仮ゴール>` |
| requester | `<依頼者>` |
| actor_owner_candidate | `<担当者/責任者候補>` |
| user_candidate | `<利用者候補>` |
| approver_candidate | `<承認者候補または不明>` |

## Route Flag Contract

00は最初にroute flagを仮置きし、terminal resultまでに本人またはsource holderへ確認した状態を記録する。これは20へ入る前の分類であり、executor/team staffing確定ではない。

| Field | Value |
|---|---|
| route_flags_initialized | `yes` / `no` |
| route_flag_basis | `requester_statement` / `material_hint` / `source_holder_answer` / `main_inference` |
| route_confirmation_question | `<本人に確認した自然文質問。内部語彙は出さない>` |
| route_confirmed_by_requester | `yes` / `partial` / `no` / `not_yet` |
| route_confirmation_answer_or_evidence | `<回答、資料、またはsource holder根拠>` |
| route_delta_after_confirmation | `none` / `existing_to_new` / `new_to_existing` / `single_to_program` / `program_to_single` / `unknown_to_fixed` |

`pass` / `defer` のhandoffでは、`route_confirmed_by_requester` を `yes` / `partial` / `not_applicable` のいずれかにする。`not_yet` / `no` / `unknown` のままなら00内で追加質問へ戻す。本人に確認する時は「これは既存業務ですか」だけで終えず、「今ある作業そのものを整理する話か、新しく業務/運用/事業を作る話か」を自然文で確認する。

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
| authorization unclear | `yes/no/unknown` | `<requester/owner/approver/送信主体/source利用許可が不明か>` |
| responsibility unclear | `yes/no/unknown` | `<責任者/停止者が不明か>` |
| abuse or deception signal | `yes/no/unknown` | `<なりすまし、隠蔽、承認迂回、同意なし収集など>` |

## Boundary Contract

| Item | Required State |
|---|---|
| no As-Is decomposition | 詳細手順は20へ送る |
| no executor routing | automation / Skill / human 判断は30へ送る |
| no IR freeze | IR / manifest / schema は40へ送る |
| no consent design | 同意ビューやapproval displayは50へ送る |
| no validation design | test / fresh executor / validation planは60へ送る |
| later phase notes | 後続phaseの話は `artifacts/later-phase-notes.md` に残す |

## 20 Readiness Contract

00は「20へ進めるか」だけでなく、「20へ何として渡すか」を決める。既存業務のAs-Is分解、新規運用の要求候補、新規事業プログラムの設計候補を混ぜない。

| entry_type | work_unit | source_posture | 20_readiness | 20で許すこと | 20で禁じること |
|---|---|---|---|---|---|
| `existing_work` | `single_business` / `workflow_or_operation` | `first_party` / `source_holder_connected` | `as_is_decompose` | 観測sourceに基づくAs-Is候補分解 | executor routing、automation確定、チーム編成確定 |
| `existing_work` | any | `proxy_hearsay` / `mixed` | `do_not_proceed_rework` または `requirements_candidate` | 困りごとや確認計画の整理 | 現場As-Isとしての分解 |
| `new_work` | `workflow_or_operation` | any | `requirements_candidate` | 課題、関係者、制約、成功条件から要求候補を切る | 現行業務が観測済みであるかのようなAs-Is分解 |
| `new_work` | `business_program` | any | `business_design_candidate` | 事業/運用群/役割群の候補を分ける | 個別executorや人員配置の確定 |

30のような代理相談は、現場既存作業をそのまま改善したいならsource holder接続まで `do_not_proceed_rework` とする。社長室などが新しい受付・確認・整理業務を作りたいなら `new_work` + `requirements_candidate` として20へ渡せる。

## Gate Result

| Field | Value |
|---|---|
| result | `pass` / `defer` / `rework` / `stop` |
| terminality | `terminal` / `non-terminal loop` |
| interaction_state | `initial_request_only` / `after_user_answer` / `with_material_evidence` |
| reason | `<判断理由>` |
| rework_target | `00-entry` / `none` |
| deferred_items | `<10で検証する未確認事項>` |
| defer_contract_id | `<deferの場合はDC-001など。pass/rework/stopならnone>` |
| next_00_questions | `<reworkの場合に00内で次に聞く質問>` |
| next_phase | `10-source-intake` / `none` (`10-source-intake` は `entry_type` が `existing_work` / `new_work` に切れている場合だけ) |
| stop_reason_type | `benign_non_bizcompiler` / `unsafe_or_unauthorized` / `dangerous_scope_unclear` / `none` |
| stop_reason | `<stopの場合の理由>` |

`pass` / `defer` / `stop` はterminal resultとして00を閉じる。`rework` はnon-terminal loopであり、このcontractを完了扱いにせず、00内で追加質問して再判定する。`entry_type = unclear` は `rework` 条件であり、`pass` / `defer` のhandoffに残さない。初回発話のみ、質問0、追加回答なし、資料実物なしの状態では `pass` / `defer` にしない。

## Defer Contract

`defer` は10-source-intakeで検証する未解決契約である。`defer` の場合は最低1行以上を埋め、`pass` の場合は `none` とする。

| defer_contract_id | defer_reason | deferred_item | verification_phase | suggested_source | if_unresolved | return_to_phase | must_resolve_before |
|---|---|---|---|---|---|---|---|
| `DC-001` | `authority/source_integrity/sensitive/external/irreversible/proxy/hearsay/low_articulation` | `<未確認事項>` | `10-source-intake` | `<SC-001など>` | `<確認できない場合の扱い>` | `00-entry` / `stop` / `10-source-intake` | `20-decompose-encrs` |

`if_unresolved` は、確認できなかった場合に00へ戻す、scopeを狭める、停止する、10で追加sourceを探す、のいずれかを明記する。未解決のまま20以降へ進める場合は、その理由と残リスクを別途mainが承認する。

## Stop Reason Types

| stop_reason_type | 使う時 |
|---|---|
| `benign_non_bizcompiler` | 単発文面作成、一般相談、業務コンパイル対象外の支援 |
| `unsafe_or_unauthorized` | なりすまし、隠蔽、承認迂回、同意なし収集、権限のない外部作用 |
| `dangerous_scope_unclear` | 外部送信、sensitive、不可逆操作などを含むが、owner/承認/source利用許可が切れず安全側に狭められない |
| `none` | `stop` 以外 |

## Handoff Minimum

00から10へ渡す最小情報は次の通り。`pass` / `defer` の場合だけhandoffする。`rework` は00内loop、`stop` は停止理由を残して閉じる。

- entry_type (`existing_work` / `new_work` のみ。`unclear` はhandoff不可)
- route flags: `work_unit` / `delivery_shape` / `source_posture` / `20_readiness`
- target_statement
- rough_goal
- scope in/out/undecided
- actor / owner / approver候補
- rough input/output
- source candidates（00の `provided` は10へ `collected` + 未reviewとして渡す）
- initial risk hints
- unknowns / explanation-only items
- defer contract（`defer` の場合）
- route confirmation（本人/source holderに確認した質問、回答、route delta）
- later phase notes
