# 10-source-intake Dispatch Checks

このファイルは、10担当subagentの返答をmain agentが受け取った後に見るreview観点である。10担当subagentへ渡す入力契約は `dispatch-packet.md`、phase全体の出口チェックは `../checks.md`、source / claimの正本雛形は `../artifacts/` を使う。

## Required Return Fields

| Field | 通す条件 |
|---|---|
| preflight確認 | 必読ファイルを全件読了している。timeout / 未読 / 読めなかったファイルが1つでもあれば10-source-intakeの判定に入らず `preflight_retry` |
| source_inventory | 主要sourceに `source_id`、status、source_class、source_holderがある |
| source_intake_interaction | `question_turn_count`、`material_evidence_count`、`source_contact_attempt_count` があり、terminal result前のsource確認作業が見える |
| terminal_source_work | `pass` / `defer` では資料確認またはsource holder接続が少なくとも1つある。`pass` は実資料/ログ/画面/観測source確認が少なくとも1つある |
| status_normalization | 00由来の `provided` が10 statusとして残っていない |
| fact_register | `observed_fact` / `person_explanation` / `hypothesis` / `unconfirmed` が分かれている |
| provenance_confidence | 主要claimに source_id、provenance、confidence がある |
| permission_risk | owner、approver、source利用許可、閲覧範囲、external/sensitive候補が未確認なら未確認として残っている |
| counter_evidence | 反例、矛盾、near-miss、差戻し例の有無が確認されている |
| phase_boundary | As-Is分解、executor routing、IR freezeを10で決めていない |
| gate_result | `pass` / `defer` / `rework` / `stop` とterminalityが一致している |
| terminal_output_drafts | `pass` / `defer` のterminal resultでは、10成果物 `source-inventory.md`、`intake-log.md`、`fact-register.md`、`handoff.md` のdraft blocksがある |

## Main Review Lenses

| Lens | 差戻し条件 |
|---|---|
| preflight retry | timeout、未読、読めなかったファイルを10-source-intakeの `rework` / `stop` / `defer` として扱っている |
| source status | `provided` が10 statusとして残っている、または未review sourceをreviewed扱いしている |
| source class | `primary` / `secondary` / `hearsay` / `assumption` の区別がない |
| claim separation | 本人説明、仮説、未確認がobserved factに混ざっている |
| claim provenance | `person_explanation` / `hypothesis` / `unconfirmed` を `provenance=observed` に昇格している、または `reported` など標準外provenanceが残っている |
| provenance | source_idやprovenanceのない主要claimがある |
| confidence | low confidenceを確定扱いしている |
| permission | 権限、閲覧範囲、利用許可、外部連絡条件が未確認のまま薄められている |
| reverse engineering | 最終成果物だけから作業実態を確定している |
| phase boundary | 20/30/40以降の判断を10で確定している |
| defer split | 20へ渡せるdeferと、10/00へ戻すreworkが分かれていない |
| output materialization | terminal resultなのに10成果物draftがなく、main agentが10 outputを生成できない |

## Output Minimum For 20

`accept_pass` / `accept_defer` は、handoff draftの存在だけでは通さない。main reviewは次を10最後のgateとして確認する。

| Check | 通す条件 |
|---|---|
| source inventory draft | `10_SOURCE_INVENTORY` blockがあり、`S-001`、status、source_classがある |
| source intake interaction | terminal result本文に質問回数、資料確認数、source holder接続数がある |
| intake log draft | `10_INTAKE_LOG` blockがあり、source_idに紐づく取得/確認/観測記録がある |
| fact register draft | `10_FACT_REGISTER` blockがあり、`C-001`、claim_type、source_id、provenance、confidenceがある |
| handoff draft | `10_HANDOFF` blockがあり、20が読むsectionを含む |
| no placeholders | `<...>` のテンプレートplaceholderが残っていない |
| no provided status | 10 outputに `provided` statusを残さない |
| pass strictness | `pass` の場合、20へ渡すdeferred claimsを残さない |
| defer boundedness | `defer` の場合、`why_20_can_continue`、`next_check`、`must_resolve_before` がある |
## Decision

| reviewer_result | 意味 | 次の動き |
|---|---|---|
| `accept_pass` | 10を `pass` で閉じてよい | `phase-orchestrator.ps1 finalize` で10成果物と `handoff.md` をmaterializeして20へ進める |
| `accept_defer` | 10を `defer` で閉じてよい | deferred_itemsと20での扱いを含むdraftから `phase-orchestrator.ps1 finalize` で10成果物と `handoff.md` をmaterializeして20へ進める |
| `ask_rework` | 10内または00への追加確認が必要 | rework_targetに従って戻す |
| `preflight_retry` | 必読ファイルがまだ読了されていない | 会話へ進まず、読了するまで必読ファイルを再読込する |
| `accept_stop` | 10を `stop` で閉じてよい | stop理由を残す |
| `main_override` | subagent判断をmainが修正する | 修正理由、根拠、差戻し要否を残す |

## Reviewer Output

main agentは、最低限次を残す。

- `reviewer_result`
- `reason`
- `accepted_source_gate_result`（`preflight_retry` の場合は空または未採用）
- `handoff_ready: yes/no`（yesは10成果物draftとhandoff draftあり。実ファイルはfinalize後に確定）
- `required_follow_up`
- `residual_risk`
