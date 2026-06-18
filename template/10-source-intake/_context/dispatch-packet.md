# 10-source-intake Subagent Dispatch Packet

このファイルは10-source-intake専用である。00-entryから渡されたsource候補、defer_contract、scope、risk hintを、20-decompose-encrsが使えるsource inventory / intake log / fact registerへ変換するためのdispatch packetである。

## Dispatch Rule

10担当subagentを立てる時は、このファイルの本文を必ず渡す。`10をやって` だけの短い依頼で開始しない。

subagentは、`必読ファイル` に挙げたファイルを読んでからsource確認を始める。これは10-source-intakeの分岐ではなく開始前提である。必読ファイルを読めない状態では10を開始しない。

返答後のmain reviewは `template/10-source-intake/_context/dispatch-checks.md` で行う。

## Preflight Retry

必読ファイルのtimeout、途中打ち切り、未読、読めなかったファイルは10-source-intakeの結果ではない。`rework` / `stop` / `defer` へ倒すルートを作らず、必読ファイルを読み終わるまでpreflight retryを続ける。

発生した場合は、業務相談へ返答せず、同じ必読ファイルを再読込する。通常読み、分割読み、検索、対象箇所の再取得など手段を変えて、読了するまで10-source-intakeの判定へ入らない。

## Natural Conversation Rule

10担当は、00 handoffを清書するだけでは完了しない。source intakeとして、最大3問までで次を確認する。

- 実物資料、画面、ログ、サンプルの有無
- source holder、owner、承認者、利用許可者の候補
- 差戻し、例外、near-miss、古い資料との差分

返答には `source_intake_interaction` を必ず含める。

| field | required |
|---|---|
| question_turn_count | 10担当がsource確認として投げた質問ターン数。初回は最大3 |
| material_evidence_count | 実資料、ログ、画面、サンプル、添付fixtureなどを確認した数 |
| source_contact_attempt_count | source holder / owner / 実担当者への接続、または接続依頼を行った数 |
| source_gap_policy | 足りないsourceを10で追加観測するか、00へ戻すか、20へdeferするか |

`pass` / `defer` のterminal resultでは、`material_evidence_count + source_contact_attempt_count >= 1` が必要である。`pass` は少なくとも1つの実資料/ログ/画面/観測source確認を必要とする。
## Task Goal

00-entryから渡されたsource候補と未確認事項を、20-decompose-encrsでAs-Is分解に使えるsource-backed claimへ変換する。

## Phase Boundary

10-source-intakeはsource確認とclaim分離の工程である。

- 20のAs-Is分解を完了しない。
- 30のautomation / Skill / executor routingを決めない。
- 40のIR / manifest / schemaを凍結しない。
- 50のconsent表示や承認UIを設計しない。
- 60のvalidation planを作らない。

後続phaseに見える話は `later_phase_notes` または handoff の reviewer notes に逃がし、source確認済みclaimと混ぜない。

## Required Files

- `Hello-world.md`
- `SOUL.md`
- `USER.md`
- `COMPASS.md`
- `knowledge/docs/lexicon.md`
- `MEMORY.md`
- `knowledge/docs/meta/phase-catalog.md`
- `knowledge/docs/ir/evidence-confidence-model.md`
- `template/10-source-intake/README.md`
- `template/10-source-intake/questions.md`
- `template/10-source-intake/checks.md`
- `template/10-source-intake/contract.md`
- `template/10-source-intake/handoff.md`
- `template/10-source-intake/artifacts/source-inventory.md`
- `template/10-source-intake/artifacts/intake-log.md`
- `template/10-source-intake/artifacts/fact-register.md`

## Required Transformations

| Input from 00 | 10 handling |
|---|---|
| source candidate `target` | `source-inventory.md` に `target` として登録 |
| source candidate `provided` | `collected` + `review_state = not_reviewed` として登録。10 statusに `provided` を残さない |
| source candidate `unavailable` | `unavailable` と理由を残す |
| source candidate `unknown` | 存在確認が10のtaskなら `target`。対象自体が切れないなら00へrework |
| low confidence hypothesis | `fact-register.md` に `hypothesis` / `unconfirmed` として登録 |
| defer_contract | 10で解くか、20へ制約付きで渡すか、00/10へ戻すかを明記 |

## Required Return Shape

subagentは、main agentへ次の順で返す。

0. preflight確認。timeout/未読/読込失敗がある場合は10-source-intakeの判定へ進まず、読了までpreflight retryする
1. source_intake_interaction: question_turn_count、material_evidence_count、source_contact_attempt_count、source_gap_policy
2. 入力handoffの確認: 00から何を受け取ったか
3. source inventory summary: source_id、status、source_class、source_holder、owner/permission
4. intake log summary: 何を聞いた/読んだ/観測したか
5. fact register summary: `observed_fact` / `person_explanation` / `hypothesis` / `unconfirmed` / `derived` を分ける。主張内容を `observed` に昇格しない
6. provenance / confidence: 各主要claimの source_ids、provenance、confidence
7. permission / risk / counter_evidence: 権限、閲覧範囲、source利用許可、反例、near-miss
8. phase boundary notes: 20以降へ送るが10で決めない話
9. gate result: `pass` / `defer` / `rework` / `stop`、terminality、rework_target、deferred_items
10. completion reviewerへ見てほしい点
11. pass / defer のterminal resultの場合は、`10_SOURCE_INVENTORY`、`10_INTAKE_LOG`、`10_FACT_REGISTER`、`10_HANDOFF` のdraft blocks

## 20 Handoff Minimum

10から20へ進めるterminal resultは、handoff draftの存在だけでは通さない。次が欠ける場合、10は `accept_pass` / `accept_defer` にならない。

- `source-inventory.md` draft: `S-001` 形式のsource_id、status、source_class、source_holderを含む。10 statusに `provided` を残さない
- `intake-log.md` draft: source_idに紐づく取得、確認、観測、未取得理由を含む
- `fact-register.md` draft: `C-001` 形式のclaim_id、claim_type、source_id、provenance、confidenceを含む
- `handoff.md` draft: `Source Summary`、`Observed Facts For 20`、`Person Explanations For 20`、`Hypotheses / Unconfirmed`、`Deferred Claims For 20`、`Reviewer Notes`、`Scope / Gate Notes` を含む
- `pass` の場合: 20で使う主材料は source-backed observed fact とし、deferred claimsを残さない
- `defer` の場合: `why_20_can_continue`、`next_check`、`must_resolve_before` を持つdeferred claimを明記する
- テンプレートplaceholderの `<...>` を残さない
## Terminal Output Drafts

`pass` / `defer` のterminal resultは、main agentがそのまま10成果物としてmaterializeできるdraftを必ず含める。

```markdown
source_intake_interaction:
| field | value |
|---|---|
| question_turn_count | 1 |
| material_evidence_count | 1 |
| source_contact_attempt_count | 1 |
| source_gap_policy | 20へ渡すdeferと10で追加観測する不足を分ける |

<!-- 10_SOURCE_INVENTORY_START -->
# Source Inventory

| source_id | source_name | status | source_class | source_holder | owner | permission_status | notes |
|---|---|---|---|---|---|---|---|
| S-001 | ... | reviewed | primary | ... | ... | confirmed | ... |
<!-- 10_SOURCE_INVENTORY_END -->

<!-- 10_INTAKE_LOG_START -->
# Intake Log

| event_id | source_id | action | observation | actor | timestamp_or_order | notes |
|---|---|---|---|---|---|---|
| I-001 | S-001 | reviewed | ... | ... | 1 | ... |
<!-- 10_INTAKE_LOG_END -->

<!-- 10_FACT_REGISTER_START -->
# Fact Register

| claim_id | claim_type | statement | source_id | provenance | confidence | used_by_20 | notes |
|---|---|---|---|---|---|---|---|
| C-001 | observed_fact | ... | S-001 | observed | medium | yes | ... |
<!-- 10_FACT_REGISTER_END -->

<!-- 10_HANDOFF_START -->
# 10 -> 20 Handoff Packet

## Packet

| Field | Value |
|---|---|
| phase_id | 10-source-intake |
| next_phase | 20-decompose-encrs |
| gate_result | pass | defer |
| terminality | terminal |
| artifacts_produced | source-inventory.md, intake-log.md, fact-register.md |

## Source Summary

| Source Group | source_id | What it supports | Status |
|---|---|---|---|

## Observed Facts For 20

| claim_id | Statement | source_id | confidence |
|---|---|---|---|

## Person Explanations For 20

| claim_id | Statement | source_id | confidence | Caveat |
|---|---|---|---|---|

## Hypotheses / Unconfirmed

| claim_id | Statement | Why it matters | Next check |
|---|---|---|---|

## Deferred Claims For 20

| claim_id | deferred_item | current_confidence | why_20_can_continue | next_check | must_resolve_before |
|---|---|---|---|---|---|

## Reviewer Notes

| Lens | Note | Action |
|---|---|---|

## Scope / Gate Notes

| Item | Note | Gate implication |
|---|---|---|

<!-- 10_HANDOFF_END -->
```

main agentはreviewで `accept_pass` / `accept_defer` になった後、`phase-orchestrator.ps1 finalize` を実行して、これらを `output/Biz-XXX-業務名/10-source-intake/` 配下の `handoff.md` と `artifacts/` へ書く。
## Gate Semantics

| result | terminality | 使う時 |
|---|---|---|
| `pass` | terminal | 20で分解する主要sourceとclaimの由来が揃っている |
| `defer` | terminal | 20へ制約付きで渡せる未確認claimがある。deferred_itemsと次の確認先が明確 |
| `rework` | non-terminal loop | source不足、claim分離不足、scopeずれで10内追加観測または00差戻しが必要 |
| `stop` | terminal | 権限なし、承認迂回、同意なし収集、不正な外部作用などで進めない |

## Do Not

- 00のsource candidateを、内容確認前に `reviewed` へ上げない。
- 10 statusに `provided` を残さない。
- 本人説明、権限者説明、ベテラン経験、善意、代理/伝聞を `observed_fact` にしない。
- source_idのない主要claimを20へ渡さない。
- low confidence claimからautomationやexecutor判断へ直行しない。
- 最終成果物だけから作業実態を確定しない。逆算なら逆算として明記する。
