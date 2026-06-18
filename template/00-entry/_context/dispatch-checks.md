# 00-entry Dispatch Checks

このファイルは、00担当subagentの返答をmain agentが受け取った後に見るreview観点である。00担当subagentへ渡す入力契約は `dispatch-packet.md`、phase全体の出口チェックは `../checks.md`、entry-gateの詳細は `gate-rubric.md` を正本にする。

## Use When

- 00担当subagentから入口判断、source候補、risk、low confidence hypotheses、entry-gate resultが返った時。
- main agentが、00を閉じてよいか、00内で追加質問へ戻すか、stopにするかを判断する時。

## Required Return Fields

| Field | 通す条件 |
|---|---|
| preflight確認 | 必読ファイルを全件読了している。timeout / 未読 / 読めなかったファイルが1つでもあれば00-entryの判定に入らず `preflight_retry` |
| interaction_state | `initial_request_only`、`user_answer_count`、`material_evidence_count`、`asked_question_count` があり、terminal resultなら質問0完了ではない根拠がある |
| entry_type | draftでは `existing_work` / `new_work` / `unclear`、handoff時点では `existing_work` / `new_work` |
| target_statement | 業務候補を一文で言える |
| source_candidates | 10-source-intakeが次に確認する資料/現物/構想材料がある |
| low_confidence_hypotheses | assistant補完、本人説明、source候補、合意scopeが混ざらず記録されている |
| risk_hints | external / sensitive / irreversible / authorization / abuse signalの初期確認がある |
| later_phase_notes | 20以降の話を00で決めずに逃がしている |
| route_confirmation | `pass` / `defer` のterminal resultでは、route flagを本人/source holderへ確認した質問、回答または根拠、route deltaがある |
| entry_gate_result | `pass` / `defer` / `rework` / `stop` とterminalityが一致している |
| handoff_draft | `pass` / `defer` のterminal resultでは、`00_HANDOFF_START` / `00_HANDOFF_END` で囲まれた `handoff.md` 本文がある |
| defer_contract | `defer` の場合、`defer_contract_id`、未解決事項、解けなかった場合の戻し先がある |
| stop_reason_type | `stop` の場合、停止理由の型がある |

## Main Review Lenses

| Lens | 差戻し条件 |
|---|---|
| read routing | README/context未読のまま質問・判定している |
| preflight retry | timeout、未読、読めなかったファイルを00-entryの `rework` / `stop` / `defer` として扱わず、読了まで再読込に戻している |
| phase boundary | 00でAs-Is詳細、executor、IR、validationを決めている |
| question0 output | 質問0でフェーズ表、解決策、自動化範囲、実行分担を出している |
| question count | `rework` で確認質問が4つ以上ある、または質問数が明記されていない |
| confidence | low confidenceのassistant仮説を確定扱いしている |
| provenance | `person_explanation` や `source_candidate` を `provenance` 値にしている |
| source path | 10で何を読むか分からない |
| handoff materialization | terminal resultなのにhandoff draftがなく、main agentが `handoff.md` を生成できない |
| entry type | `unclear` のままhandoffしようとしている |
| risk | 権限、外部作用、sensitive、不可逆操作の不明点を薄めている |
| abuse | なりすまし、隠蔽、承認迂回、同意なし収集を普通の効率化として扱っている |
| wording | ユーザー向けに `10-source-intake` など内部語彙をそのまま出している |
| rework | `rework` をterminal resultとして扱っている |
| zero-question terminal | 初回発話だけ、または質問0の状態で `pass` / `defer` をterminal resultにしている |
| defer contract | `defer` なのに10で解く未解決契約、戻し先、停止条件がない |
| stop reason type | `stop` なのに停止理由の型がない |

## Handoff Minimum For 10

`accept_pass` / `accept_defer` は、handoff draftの存在だけでは通さない。main reviewは次を00最後のgateとして確認する。

| Check | 通す条件 |
|---|---|
| no placeholders | `<...>` のテンプレートplaceholderが残っていない |
| entry_type | `existing_work` / `new_work` のどちらか |
| target_statement | 業務候補の一文が具体化されている |
| gate_result | 00で採用したgate resultとhandoff内のgate resultが一致する |
| scope | `in_scope` / `out_of_scope` / `undecided_scope` がある |
| source candidates | `SC-001` 形式のsource候補と10初期statusがある |
| source status normalization | 10初期statusに `provided` を残さない |
| risk hints | external / sensitive / irreversible / approval / authorization / abuse signal が `yes/no/unknown` で分類されている |
| unknowns | `U-001` 形式、または明示的に `none` |
| low confidence hypotheses | `H-001` 形式、または明示的に `none` |
| later phase notes | `L-001` 形式、または明示的に `none` |
| pass risk strictness | `pass` の場合、external / sensitive / irreversible / approval / authorization unclear に `yes` / `unknown` が残らない。残るなら `defer` / `rework` / `stop` |
| defer contract | `defer` の場合、`DC-001`、`if_unresolved`、`return_to_phase`、`must_resolve_before` がある |
## Decision

| reviewer_result | 意味 | 次の動き |
|---|---|---|
| `accept_pass` | 00を `pass` で閉じてよい | `phase-orchestrator.ps1 finalize` で `handoff.md` をmaterializeして10へ進める |
| `accept_defer` | 00を `defer` で閉じてよい | `defer_contract` と未解決時の戻し先を含むdraftから `phase-orchestrator.ps1 finalize` で `handoff.md` をmaterializeして10へ進める |
| `ask_rework` | 00内で追加質問が必要 | 次の質問を1つに絞って戻す |
| `preflight_retry` | 必読ファイルがまだ読了されていない | 会話へ進まず、読了するまで必読ファイルを再読込する |
| `accept_stop` | 00を `stop` で閉じてよい | stop理由を残す |
| `main_override` | subagent判断をmainが修正する | 修正理由、根拠、差戻し要否を残す |

## Reviewer Output

main agentは、最低限次を残す。

- `reviewer_result`
- `reason`
- `accepted_entry_gate_result`（`preflight_retry` の場合は空または未採用）
- `interaction_state`
- `required_follow_up_question`
- `handoff_ready: yes/no`（yesはhandoff draftあり。実ファイルはfinalize後に確定）
- `residual_risk`
