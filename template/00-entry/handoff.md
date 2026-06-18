# 00 -> 10 Handoff Packet

このファイルは、00-entry から 10-source-intake へ渡す最小情報の形である。`pass` / `defer` のterminal resultで00を閉じる時だけ作る。`rework` は00内のnon-terminal loopであり、このhandoffを作らず追加質問して再判定する。`stop` はhandoffせず停止理由を残す。

`entry_type = unclear` はhandoff不可である。既存業務か新規業務かが切れない場合は、00内で追加質問して `existing_work` / `new_work` のどちらかへ寄せるか、`stop` 理由を残す。

## Packet

| Field | Value |
|---|---|
| phase_id | `00-entry` |
| next_phase | `10-source-intake` |
| entry_type | `existing_work` / `new_work` |
| work_unit | `single_business` / `workflow_or_operation` / `business_program` |
| delivery_shape | `single_executor` / `multi_executor_team` / `unknown` |
| source_posture | `first_party` / `source_holder_connected` / `proxy_hearsay` / `mixed` / `unknown` |
| 20_readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` |
| route_confirmed_by_requester | `yes` / `partial` / `not_applicable` |
| route_confirmation_source | `requester_answer` / `source_holder_answer` / `material_evidence` |
| intent | `<intent values>` |
| target_statement | `<業務候補の一文説明>` |
| business_scope | `<in-scope / out-of-scope / undecided summary>` |
| inputs_used | `<00で使った会話、資料、source_candidate_id>` |
| open_hypotheses | `<low confidence hypothesis id list>` |
| evidence | `<00時点で支えにしたsource_candidate_idまたは会話参照>` |
| counter_evidence | `<反例、矛盾、未確認。なければ未確認として明記>` |
| gate_policy | `<pass/deferの理由、10で検証する条件>` |
| artifacts_produced | `entry-packet.md`, `scope-memo.md`, `initial-risk-memo.md`, `source-candidates.md`, `later-phase-notes.md` |
| contracts_frozen | `contract.md` |
| gate_result | `pass` / `defer` |
| defer_contract_id | `<deferの場合はDC-001など。passの場合はnone>` |
| deferred_items | `<deferの場合に10で検証する未確認事項。passの場合はnone>` |

## Scope Summary

| Item | Summary |
|---|---|
| in_scope | `<対象に含めるもの>` |
| out_of_scope | `<対象外>` |
| undecided_scope | `<まだ境界が曖昧なもの>` |
| rough_input | `<入力の粗い見立て>` |
| rough_output | `<出力の粗い見立て>` |

## Actor / Owner Summary

| Role | Candidate | Confidence | Notes |
|---|---|---|---|
| requester | `<依頼者>` | `<low/medium>` | `<本人説明/観測候補>` |
| actor | `<実行者候補>` | `<low/medium>` | `<未確認なら明記>` |
| owner | `<責任者候補>` | `<low/medium>` | `<不明ならunknown>` |
| approver | `<承認者候補>` | `<low/medium>` | `<不明ならunknown>` |

## Source Candidates For 10

| source_candidate_id | source_type | description | expected_use | 00_status | 10_initial_status | review_state | notes |
|---|---|---|---|---|---|---|---|
| `SC-001` | `document/tool/log/screen/output_sample/concept_note/reference` | `<10で確認するもの>` | `<何を支えるか>` | `target` | `target` | `not_reviewed` | `<注意>` |

## 00 To 10 Source Status Mapping

| 00_status | 10_initial_status | 10での扱い |
|---|---|---|
| `target` | `target` | 確認対象。まだ取得していない |
| `provided` | `collected` | 受領済みだが未読。`review_state = not_reviewed` として扱う |
| `unavailable` | `unavailable` | 取得不能または存在しない候補として理由を残す |
| `unknown` | `target` または00へrework | 存在確認自体が10のsource taskなら `target`。何を確認するか不明なら00へ戻す |

10-source-intake の正規statusに `provided` は入れない。00から来た `provided` は、handoff時点で必ず `collected` に正規化し、内容未確認であることを残す。

## 20 Readiness

00は10へsource確認を依頼するだけでなく、20へ何として渡す前提かを明示する。このrouteは10で上書きしてよいが、消してはいけない。

| Field | Value |
|---|---|
| work_unit | `single_business` / `workflow_or_operation` / `business_program` |
| delivery_shape | `single_executor` / `multi_executor_team` / `unknown` |
| source_posture | `first_party` / `source_holder_connected` / `proxy_hearsay` / `mixed` / `unknown` |
| 20_readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` |
| route_confirmed_by_requester | `yes` / `partial` / `not_applicable` |
| route_confirmation_source | `requester_answer` / `source_holder_answer` / `material_evidence` |
| 20_route_reason | `<このrouteにした理由>` |
| route_recheck_in_10 | `<10で見直す条件>` |

`as_is_decompose` は、既存業務かつ本人/source holder/実物sourceに接続できる見込みがある時だけ候補にする。代理/伝聞だけなら `requirements_candidate` または `do_not_proceed_rework` に倒す。新規事業や派遣チーム相当の構想は `business_design_candidate` として20へ渡し、30のexecutor/team staffingを00で決めない。

## Route Confirmation

| Field | Value |
|---|---|
| route_flags_initialized | `yes` |
| route_flag_basis | `<requester_statement / material_hint / source_holder_answer / main_inference>` |
| route_confirmation_question | `<本人に確認した自然文質問>` |
| route_confirmed_by_requester | `yes` / `partial` / `not_applicable` |
| route_confirmation_answer_or_evidence | `<回答または根拠>` |
| route_delta_after_confirmation | `none` / `existing_to_new` / `new_to_existing` / `single_to_program` / `program_to_single` / `unknown_to_fixed` |

`route_confirmed_by_requester = no` / `not_yet` / `unknown` のままではhandoffしない。確認でrouteが変わった場合は、このhandoff内の `entry_type`、`work_unit`、`delivery_shape`、`source_posture`、`20_readiness` を修正済みにする。

## Initial Risk Hints
| Risk | Status | Notes | Suggested handling in 10 |
|---|---|---|---|
| external impact | `yes/no/unknown` | `<他部署、社外、顧客など>` | `<確認source>` |
| sensitive data | `yes/no/unknown` | `<個人情報、契約情報など>` | `<確認source>` |
| irreversible action | `yes/no/unknown` | `<発注、確定、削除など>` | `<確認source>` |
| approval need | `yes/no/unknown` | `<人間確認候補>` | `<確認source>` |
| authorization unclear | `yes/no/unknown` | `<requester/owner/approver/送信主体の権限不明>` | `<確認sourceまたは00へ差戻>` |
| abuse or deception signal | `yes/no/unknown` | `<なりすまし、隠蔽、承認迂回、同意なし収集など>` | `<yesならstop/rework。10へ送る場合は正規業務として確認>` |

## Defer Contract

`defer` は「未確認のまま通す」ではなく、10-source-intakeで検証する未解決契約である。`pass` の場合、この表は `none` としてよい。`defer` の場合は最低1行以上を埋める。

| defer_contract_id | defer_reason | deferred_item | verification_phase | suggested_source | if_unresolved | return_to_phase | must_resolve_before |
|---|---|---|---|---|---|---|---|
| `DC-001` | `authority/source_integrity/sensitive/external/irreversible/proxy/hearsay/low_articulation` | `<未確認事項>` | `10-source-intake` | `<SC-001など>` | `<確認できない場合の扱い>` | `00-entry` / `stop` / `10-source-intake` | `20-decompose-encrs` |

`if_unresolved` は、確認できなかった場合に「そのまま20へ送る」のではなく、00へ戻す、scopeを狭める、停止する、10で追加sourceを探す、のどれかを明記する。

## Unknowns For 10

| unknown_id | Question | Why it matters | Suggested source |
|---|---|---|---|
| `U-001` | `<未確認事項>` | `<10で確認する理由>` | `<source candidate>` |

## Low Confidence Hypotheses For 10

| hypothesis_id | Area | Candidate | provenance | claim_type | source_type | source_ref | Confidence | Suggested source |
|---|---|---|---|---|---|---|---|---|
| `H-001` | `<business_name/target_statement/success_guess/rough_io/scope/owner>` | `<assistantが置いた候補>` | `hypothesized` | `hypothesis` | `assumption` | `conversation` | `low` | `<10で確認するsource>` |

## Later Phase Notes

| note_id | first_check_phase | after_confirmed_phase | Note | Do not decide in 00 |
|---|---|---|---|---|
| `L-001` | `10-source-intake` | `20-decompose-encrs` | `<source確認後に後続phaseで扱う話>` | `yes` |

## Rework Targets Before Handoff

| Condition | Rework target |
|---|---|
| entry_typeが切れない | `00-entry` |
| 業務候補を一文で言えない | `00-entry` |
| source候補がなく10で何を読むか分からない | `00-entry` |
| 権限、承認者、送信主体が不明なまま外部作用やsensitiveを扱おうとしている | `00-entry` |
| なりすまし、隠蔽、承認迂回、同意なし収集の疑いがある | `00-entry` / `stop` |
| source確認でscopeが違うと判明 | `00-entry` |

## Handoff Notes

- `rework` 条件が残っている場合、このhandoffを作らず00内で追加質問して再判定する。
- `entry_type = unclear` はrework条件であり、`pass` / `defer` のhandoffには残さない。
- `defer` の場合、`defer_contract_id` と `Defer Contract` を必ず埋める。
- 10では、00の本人説明を観測済み事実として扱わない。
- 00でassistantが置いた仮説は、ユーザー同意があってもsource確認まで `confidence = low` として扱う。
- 既存型は現物sourceの取得と確認を優先する。
- 新規型は仮説、参考例、想定シナリオをsource候補として扱う。
- `20_readiness` は10で再確認するが、00で切った入口routeと `Route Confirmation` を10のhandoffから落とさない。
- 新規事業やAI派遣チーム相当の構想は `business_design_candidate` として渡し、役割数やexecutor割当は30以降に送る。
- 00で出たautomationやexecutor案は、30まで設計判断にしない。
- 手順、例外、必須列、期限ルール、対応表、AI読取精度などは、20以降に送る前に10でsource確認する。