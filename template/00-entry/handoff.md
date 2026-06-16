# 00 -> 10 Handoff Packet

このファイルは、00-entry から 10-source-intake へ渡す最小情報の形である。

## Packet

| Field | Value |
|---|---|
| phase_id | `00-entry` |
| next_phase | `10-source-intake` |
| entry_type | `existing_work` / `new_work` / `unclear` |
| intent | `<intent values>` |
| target_statement | `<業務候補の一文説明>` |
| artifacts_produced | `entry-packet.md`, `scope-memo.md`, `initial-risk-memo.md`, `source-candidates.md`, `later-phase-notes.md` |
| contracts_frozen | `contract.md` |
| gate_result | `pass` / `defer` / `rework` / `stop` |

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

| source_candidate_id | source_type | description | expected_use | status |
|---|---|---|---|---|
| `SC-001` | `document/tool/log/screen/output_sample/concept_note/reference` | `<10で確認するもの>` | `<何を支えるか>` | `target` |

## Initial Risk Hints

| Risk | Status | Notes | Suggested handling in 10 |
|---|---|---|---|
| external impact | `yes/no/unknown` | `<他部署、社外、顧客など>` | `<確認source>` |
| sensitive data | `yes/no/unknown` | `<個人情報、契約情報など>` | `<確認source>` |
| irreversible action | `yes/no/unknown` | `<発注、確定、削除など>` | `<確認source>` |
| approval need | `yes/no/unknown` | `<人間確認候補>` | `<確認source>` |

## Unknowns For 10

| unknown_id | Question | Why it matters | Suggested source |
|---|---|---|---|
| `U-001` | `<未確認事項>` | `<10で確認する理由>` | `<source candidate>` |

## Later Phase Notes

| note_id | suggested_phase | Note | Do not decide in 00 |
|---|---|---|---|
| `L-001` | `20-decompose-encrs` | `<後続phaseで扱う話>` | `yes` |

## Rework Targets

| Condition | Rework target |
|---|---|
| entry_typeが切れない | `00-entry` |
| 業務候補を一文で言えない | `00-entry` |
| source候補がなく10で何を読むか分からない | `00-entry` |
| source確認でscopeが違うと判明 | `00-entry` |

## Handoff Notes

- 10では、00の本人説明を観測済み事実として扱わない。
- 既存型は現物sourceの取得と確認を優先する。
- 新規型は仮説、参考例、想定シナリオをsource候補として扱う。
- 00で出たautomationやexecutor案は、30まで設計判断にしない。