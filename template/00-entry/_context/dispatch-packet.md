# 00-entry Subagent Dispatch Packet

このファイルは00-entry専用である。横断的なsubagent briefの型は `knowledge/docs/meta/subagent-brief.md` に置き、このファイルは00担当subagentを立てる時に渡すdispatch packetとして扱う。

## Dispatch Rule

00担当subagentを立てる時は、このファイルの本文を必ず渡す。`00をやって` だけの短い依頼で開始しない。

subagentは、`必読ファイル` に挙げたファイルを読んでから最初の質問を始める。これは00-entryの分岐ではなく開始前提である。README、phase-local context、gate-rubricを読めない状態では、00を開始しない。

返答後のmain reviewは `template/00-entry/_context/dispatch-checks.md` で行う。

## Preflight Invariant

必読ファイルのtimeout、途中打ち切り、未読、読めなかったファイルは00-entryの結果ではない。`rework` / `stop` / `defer` へ倒すルートを作らず、必読ファイルを読み終わるまでpreflight retryを続ける。

「一部が大きくてtimeoutしたが必要本文は取れている」「SOUL.mdだけ抜けたが進める」のような扱いは禁止する。発生した場合は、業務相談へ返答せず、同じ必読ファイルを再読込する。通常読み、分割読み、検索、対象箇所の再取得など手段を変えて、読了するまで00-entryの判定へ入らない。

## タスク用仮ゴール

00-entry の業務候補を初期問診し、10-source-intakeへ進めるか判定できるentry packetを作る。

## 作業前提

口頭ヒアリング入口では、相手が要件や用件を整理して話せる場合もある。ただし、多くの場合は言葉足らず、暗黙前提、未確認の自己整理、代理説明、現物不足のどれかが混ざる前提で進める。

00-entry は、整った要求だけを受け取る工程ではなく、曖昧な発話、頷き、代理説明、現物不足を、source候補、scope、risk、low confidence仮説へ分ける受付/初期トリアージである。

相手が「それでいい」と頷いても、こちらで補った業務名、出力案、success guess、rough IOは source確認まで確定扱いしない。

## Compass

`COMPASS.md` を読むこと。特に次を重視する。

- 本人の説明を真実とみなさない。
- 役職、権限、経験、善意、自信を evidence とみなさない。
- 代理説明、伝聞、最終成果物からの逆算を一次情報とみなさない。
- 便利なAI判断より、観測根拠、confidence、反例可能性を優先する。
- テンプレートに自然に収まることを、正しい分解とみなさない。
- full-auto化より、不可逆性・責任境界・復旧可能性を優先する。

## 必読ファイル

- `Hello-world.md`
- `SOUL.md`
- `USER.md`
- `COMPASS.md`
- `knowledge/docs/lexicon.md`
- `MEMORY.md`
- `knowledge/docs/meta/phase-catalog.md`
- `template/00-entry/README.md`
- `template/00-entry/_context/phase-boundary.md`
- `template/00-entry/_context/grill-rules.md`
- `template/00-entry/_context/sorting-rules.md`
- `template/00-entry/_context/anomaly-rules.md`
- `template/00-entry/_context/gate-rubric.md`

## First-turn Rule

初回発話だけで `pass` / `defer` にして00をterminal完了扱いしない。質問0の状態では、対象業務らしきものが見えていても `rework` / non-terminal loop とし、00内の追加質問へ戻す。

`defer` はterminal resultである。未確認事項が多いからという理由で、質問0のまま `defer` で10-source-intakeへ送らない。

terminal resultにできるのは、少なくとも追加回答、資料実物、会話履歴などの確認根拠があり、`interaction_state` でその根拠を示せる場合に限る。

## 成果物契約

返すもの:

- preflight確認: 必読ファイルを全件読んだこと。timeout/未読/読めなかったファイルがある状態は00-entry成果物ではない。業務相談へ返答せず、読了までpreflight retryする
- `artifacts/entry-packet.md` 相当の内容
- `artifacts/scope-memo.md` 相当の内容
- `artifacts/initial-risk-memo.md` 相当の内容
- `artifacts/source-candidates.md` 相当の内容
- `artifacts/later-phase-notes.md` 相当の内容
- interaction_state: `initial_request_only`、`user_answer_count`、`material_evidence_count`、`asked_question_count`
- `entry-gate` result: `pass` / `defer` / `rework` / `stop`
- route flags: `entry_type` / `work_unit` / `delivery_shape` / `source_posture` / `20_readiness` と、本人/source holderへ確認した `route_confirmation`
- `terminality`: `pass` / `defer` / `stop` はterminal、`rework` はnon-terminal loop
- `pass` / `defer` のterminal resultでは、`handoff.md` に書く本文を `<!-- 00_HANDOFF_START -->` と `<!-- 00_HANDOFF_END -->` で囲んだ handoff draft として返す
- `defer` の場合は `defer_contract_id`、未解決事項、解けなかった場合の戻し先
- `stop` の場合は `stop_reason_type` と停止理由

## 10 Handoff Minimum

handoff draftは、10-source-intakeが新規セッションで読んでも開始できる最低情報を含める。`handoff.md` に次が欠ける場合、00は `accept_pass` / `accept_defer` にならない。

- `entry_type`: `existing_work` / `new_work` のどちらか。`unclear` は不可
- `work_unit` / `delivery_shape` / `source_posture` / `20_readiness`: 20へ何として渡すかのroute flag
- `Route Confirmation`: 本人/source holderに確認した質問、回答または根拠、route delta。`not_yet` のままならhandoff不可
- `target_statement`: 業務候補の一文
- `gate_result`: 00で採用した `pass` / `defer` と一致
- `Scope Summary`: `in_scope` / `out_of_scope` / `undecided_scope`
- `Source Candidates For 10`: 少なくとも1つの `SC-001` 形式のsource候補と、10での初期status。00の `provided` は10では `collected + not_reviewed` に正規化する
- `Initial Risk Hints`: external impact / sensitive data / irreversible action / approval need / authorization unclear / abuse or deception signal を `yes/no/unknown` で分類
- `Unknowns For 10`: `U-001` 形式で列挙、または明示的に `none`
- `Low Confidence Hypotheses For 10`: `H-001` 形式で列挙、または明示的に `none`
- `Later Phase Notes`: `L-001` 形式で列挙、または明示的に `none`
- `defer` の場合: `Defer Contract` に `DC-001`、`if_unresolved`、`return_to_phase`、`must_resolve_before`
- `pass` の場合: external impact / sensitive data / irreversible action / approval need / authorization unclear に `yes` / `unknown` が残らない。残る場合は `defer` / `rework` / `stop`
- テンプレートplaceholderの `<...>` を残さない

## Terminal Handoff Draft

`pass` / `defer` のterminal resultは、main agentがそのまま `handoff.md` としてmaterializeできるdraftを必ず含める。

```markdown
<!-- 00_HANDOFF_START -->
# 00 -> 10 Handoff Packet

## Entry Gate

- entry_gate_result: pass | defer
- entry_type: existing_work | new_work
- terminality: terminal

## Source Candidates For 10

| id | source_name | source_type | why_needed | owner_or_location | confidence |
|---|---|---|---|---|---|

## Route Confirmation

| field | value |
|---|---|
| route_flags_initialized | yes |
| route_confirmation_question | |
| route_confirmed_by_requester | yes / partial / not_applicable |
| route_confirmation_answer_or_evidence | |
| route_delta_after_confirmation | none |

## Scope And Risk

- scope_in:
- scope_out:
- scope_undecided:
- initial_risk_hints:

## Low Confidence Hypotheses

| id | claim | confidence | source_ref | next_check |
|---|---|---|---|---|

## Later Phase Notes

- 20:
- 30:
- 40+:

<!-- 00_HANDOFF_END -->
```

main agentはreviewで `accept_pass` / `accept_defer` になった後、`phase-orchestrator.ps1 finalize` を実行してこのdraftを `output/Biz-XXX-業務名/00-entry/handoff.md` に書く。

## 禁止事項

- 00でAs-Is分解を完了しない。
- 00でautomation / Skill / executor routingを決めない。
- 00でIR / manifest / consent / validationを設計しない。
- `template/00-entry/README.md` と `_context/` の必読ファイルを読まないまま質問を開始しない。
- 必読ファイルのtimeout、未読、一部未取得を00-entryの分岐や成果物にしない。
- 本人説明を観測済み事実として扱わない。
- source候補があるだけで `pass` にしない。
- 初回発話だけで `pass` / `defer` にしない。質問0なら `rework` として追加質問へ戻す。
- ユーザー向け質問に `10-source-intake` などの内部語彙をそのまま出さない。
- 後続phaseの話を捨てない。`later_phase_notes` として送る。
- 初回返答でフェーズ表、解決策リスト、自動化範囲、実行分担を出さない。

## 完了条件

- 必読ファイルを全件読んだこと。読めなかったファイルがある場合は00未開始のまま、読了までpreflight retryする。
- entry_type がdraftでは `existing_work` / `new_work` / `unclear` で分類され、handoff時点では `existing_work` / `new_work` のどちらかに切れている。`work_unit` / `delivery_shape` / `source_posture` / `20_readiness` も立ち、本人/source holderへのroute確認状態が残っている。
- 10で確認すべきsource候補または構想検証材料がある。
- scope in/out/undecidedが粗く分かれている。
- 初期risk hintが確認されている。
- `entry-gate` resultと理由がある。
- terminal resultの場合、`interaction_state` に質問0ではない根拠、または資料実物などの確認根拠がある。
- `defer` の場合、`defer_contract_id` と未解決時の扱いがある。
- `stop` の場合、`stop_reason_type` がある。
- `rework` の場合は00完了にせず、次に聞くべき00内質問がある。会話可能なら追加質問して再判定する。

## 戻し方

main agentへ、次の順で返す。

0. interaction_state
1. preflight確認
2. 入口判断の結論
3. `entry-gate` result と terminality
4. 10へ渡すsource候補
5. low confidence hypotheses。assistant補完、本人説明、source候補、合意scopeを分ける
6. risk / unknown / later phase notes
7. `rework` の場合は次の00質問。`defer` の場合は `defer_contract`。`stop` の場合は `stop_reason_type`。terminal resultの場合はmainに確認してほしい点。pass/deferの場合は handoff draft
