# 00 -> 10 Handoff Packet

このファイルは、00-entry から 10-source-intake へ渡す最小情報の形である。`pass` / `defer` のterminal resultで00を閉じる時だけ作る。`rework` は00内のnon-terminal loopであり、このhandoffを作らず追加質問して再判定する。`stop` はhandoffせず停止理由を残す。

`entry_type = unclear` はhandoff不可である。既存業務か新規業務かが切れない場合は、00内で追加質問して `existing_work` / `new_work` のどちらかへ寄せるか、`stop` 理由を残す。

## Packet

| Field | Value |
|---|---|
| phase_id | `00-entry` |
| next_phase | `10-source-intake` |
| entry_type | `existing_work` / `new_work` |
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
| deferred_items | `<deferの場合に10で検証する未確認事項>` |

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

## Initial Risk Hints

| Risk | Status | Notes | Suggested handling in 10 |
|---|---|---|---|
| external impact | `yes/no/unknown` | `<他部署、社外、顧客など>` | `<確認source>` |
| sensitive data | `yes/no/unknown` | `<個人情報、契約情報など>` | `<確認source>` |
| irreversible action | `yes/no/unknown` | `<発注、確定、削除など>` | `<確認source>` |
| approval need | `yes/no/unknown` | `<人間確認候補>` | `<確認source>` |
| authorization unclear | `yes/no/unknown` | `<requester/owner/approver/送信主体の権限不明>` | `<確認sourceまたは00へ差戻>` |
| abuse or deception signal | `yes/no/unknown` | `<なりすまし、隠蔽、承認迂回、同意なし収集など>` | `<yesならstop/rework。10へ送る場合は正規業務として確認>` |

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
- 10では、00の本人説明を観測済み事実として扱わない。
- 00でassistantが置いた仮説は、ユーザー同意があってもsource確認まで `confidence = low` として扱う。
- 既存型は現物sourceの取得と確認を優先する。
- 新規型は仮説、参考例、想定シナリオをsource候補として扱う。
- 00で出たautomationやexecutor案は、30まで設計判断にしない。
- 手順、例外、必須列、期限ルール、対応表、AI読取精度などは、20以降に送る前に10でsource確認する。
