# 00-entry Dispatch Checks

このファイルは、00担当subagentの返答をmain agentが受け取った後に見るreview観点である。00担当subagentへ渡す入力契約は `dispatch-packet.md`、phase全体の出口チェックは `../checks.md`、entry-gateの詳細は `gate-rubric.md` を正本にする。

## Use When

- 00担当subagentから入口判断、source候補、risk、low confidence hypotheses、entry-gate resultが返った時。
- main agentが、00を閉じてよいか、00内で追加質問へ戻すか、stopにするかを判断する時。

## Required Return Fields

| Field | 通す条件 |
|---|---|
| 前提ファイル確認 | 必読ファイルの読了または未読理由がある |
| entry_type | draftでは `existing_work` / `new_work` / `unclear`、handoff時点では `existing_work` / `new_work` |
| target_statement | 業務候補を一文で言える |
| source_candidates | 10-source-intakeが次に確認する資料/現物/構想材料がある |
| low_confidence_hypotheses | assistant補完、本人説明、source候補、合意scopeが混ざらず記録されている |
| risk_hints | external / sensitive / irreversible / authorization / abuse signalの初期確認がある |
| later_phase_notes | 20以降の話を00で決めずに逃がしている |
| entry_gate_result | `pass` / `defer` / `rework` / `stop` とterminalityが一致している |

## Main Review Lenses

| Lens | 差戻し条件 |
|---|---|
| read routing | README/context未読のまま質問・判定している |
| phase boundary | 00でAs-Is詳細、executor、IR、validationを決めている |
| confidence | low confidenceのassistant仮説を確定扱いしている |
| provenance | `person_explanation` や `source_candidate` を `provenance` 値にしている |
| source path | 10で何を読むか分からない |
| entry type | `unclear` のままhandoffしようとしている |
| risk | 権限、外部作用、sensitive、不可逆操作の不明点を薄めている |
| abuse | なりすまし、隠蔽、承認迂回、同意なし収集を普通の効率化として扱っている |
| wording | ユーザー向けに `10-source-intake` など内部語彙をそのまま出している |
| rework | `rework` をterminal resultとして扱っている |

## Decision

| reviewer_result | 意味 | 次の動き |
|---|---|---|
| `accept_pass` | 00を `pass` で閉じてよい | `handoff.md` を作り10へ進める |
| `accept_defer` | 00を `defer` で閉じてよい | 未確認事項を明記して10へ進める |
| `ask_rework` | 00内で追加質問が必要 | 次の質問を1つに絞って戻す |
| `accept_stop` | 00を `stop` で閉じてよい | stop理由を残す |
| `main_override` | subagent判断をmainが修正する | 修正理由、根拠、差戻し要否を残す |

## Reviewer Output

main agentは、最低限次を残す。

- `reviewer_result`
- `reason`
- `accepted_entry_gate_result`
- `required_follow_up_question`
- `handoff_ready: yes/no`
- `residual_risk`
