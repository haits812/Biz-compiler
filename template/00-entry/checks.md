# 00 Entry Checks

00-entry の入口判定チェック。`pass` / `defer` / `stop` はterminal resultとして00を閉じる。`rework` はnon-terminal loopであり、10-source-intakeへ渡す前に00内で追加質問して再判定する。

## Entry Checks

| Check | Pass Criteria | Result |
|---|---|---|
| entry type | `existing_work` / `new_work` のどちらかに切れている。`unclear` は `rework` とし、handoffしない | `<pass/defer/rework/stop>` |
| work unit | `single_business` / `workflow_or_operation` / `business_program` のどれかに切れている。`business_program` は新規事業や派遣チーム相当の構想として扱う | `<pass/defer/rework>` |
| delivery shape | 1人相当のAI/automationで足りる候補か、複数役割のチーム編成候補かを粗く分ける。確定は30以降 | `<pass/defer/rework>` |
| source posture | 相談者本人、source holder接続済み、代理/伝聞、mixedを区別する | `<pass/defer/rework>` |
| 20 readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` / `do_not_proceed_*` のどれかに切る | `<pass/defer/rework/stop>` |
| route confirmation | `pass` / `defer` のterminal resultでは、最初に立てたroute flagを本人/source holderへ自然文で確認し、`route_confirmed_by_requester` と `route_delta_after_confirmation` を残している | `<pass/defer/rework>` |
| first-turn terminal guard | 初回発話だけ、質問0、追加回答なし、資料実物なしの場合は `pass` / `defer` にせず、00内の追加質問へ戻す。`defer` はterminalなので質問0完了の逃げ道にしない | `<rework>` |
| first response shape | 初回は業務候補らしさを短く受け止め、実物またはsource holderを1つだけ聞く。フェーズ表、解決策、自動化範囲、実行分担を出さない | `<rework>` |
| question count | `rework` では次の確認質問を1つ、最大でも3つまでに絞る | `<rework>` |
| target statement | 業務候補を一文で説明できる | `<pass/defer/rework/stop>` |
| intent | 何をしたいかが粗く分類されている | `<pass/defer/rework/stop>` |
| not a one-off | 単発作業ならBiz-compiler対象外として扱いが明記されている | `<pass/defer/rework/stop>` |
| assistant hypotheses | 低言語化ユーザーに対してこちらが置いた業務名、出力案、success guessが `provenance = hypothesized`、`claim_type = hypothesis`、`confidence = low` で分離されている | `<pass/defer/rework>` |
| provenance vocabulary | 00のclaimが `observed` / `hypothesized` / `negotiated` / `derived` 以外を `provenance` 値として使っていない | `<pass/defer/rework>` |
| low articulation pass guard | 低言語化経由の候補を、具体sourceとsource holder確認前に `pass` にしていない | `<defer/rework>` |
| authority is not evidence | 役職、権限、経験、善意、自信を観測済み事実として扱っていない | `<pass/defer/rework>` |
| proxy / hearsay | 代理説明、伝聞、最終成果物からの逆算を一次情報として扱っていない | `<pass/defer/rework>` |
| proxy pass guard | 代理/伝聞経由の候補を、本人またはsource holderへの実接続前に `pass` にしていない。「確認してよい」は `defer` として扱う | `<defer/rework>` |
| proxy as-is guard | `source_posture = proxy_hearsay` のまま `20_readiness = as_is_decompose` にしていない。source holderへ接続するか、`requirements_candidate` / `do_not_proceed_rework` に倒す | `<defer/rework>` |
| business program guard | 新規事業や派遣チーム相当の構想を、単体既存業務のAs-Is分解として扱っていない。`business_design_candidate` として20へ渡す | `<defer/rework>` |

## Material Checks

| Check | Pass Criteria | Result |
|---|---|---|
| existing material path | 既存型はマニュアル、ツール、成果物、ログ、画面などの候補がある | `<pass/defer/rework>` |
| upfront flow/material | 初手で既存フロー、手順書、マニュアル、Excelが渡された場合でも、owner、更新日、対象scope、実運用との差分、例外、差戻し履歴が未確認なら `defer` にしている | `<defer/rework>` |
| new concept path | 新規型は構想、参考例、想定シナリオ、制約の候補がある | `<pass/defer/rework>` |
| source candidates | 10で最初に確認するsource候補がある。ただし候補があるだけでは `pass` にしない | `<pass/defer/rework>` |
| missing materials | ない/取れない/未確認の材料が記録されている | `<pass/defer/rework>` |

## Scope Checks

| Check | Pass Criteria | Result |
|---|---|---|
| scope in | 対象に含めるものが粗く分かる | `<pass/defer/rework>` |
| scope out | 対象外が粗く分かる、または未確認として残っている | `<pass/defer/rework>` |
| undecided scope | 境界が曖昧なものを隠していない | `<pass/defer/rework>` |
| scope creep | 便利だから混ぜたものを別候補として扱えている | `<pass/defer/rework>` |

## Risk Checks

| Check | Pass Criteria | Result |
|---|---|---|
| external impact | 他部署、社外、顧客、共有interface変更候補を確認した | `<pass/defer/rework>` |
| sensitive data | 個人情報、契約情報、機密情報候補を確認した | `<pass/defer/rework>` |
| irreversible action | 外部送信、発注、確定、削除、権限変更候補を確認した | `<pass/defer/rework>` |
| responsibility | 間違えた時の責任者/停止者が不明なら不明として残した | `<pass/defer/rework>` |
| authorization | owner、承認者、送信主体、source利用許可が必要な依頼で、権限不明を隠していない | `<pass/defer/rework/stop>` |
| abuse or deception | なりすまし、隠蔽、承認迂回、同意なし収集の疑いを確認し、実行案を出していない | `<pass/rework/stop>` |
| high-risk domain | finance / HR / legal / procurement / customer / account / approval を扱う場合、未確認事項を `defer` に倒している | `<pass/defer/rework>` |
| pass strictness | external / sensitive / irreversible / authorization / approval が `yes` または `unknown` のまま `pass` にしていない | `<pass/defer/rework/stop>` |

## Defer / Stop Contract Checks

| Check | Pass Criteria | Result |
|---|---|---|
| defer contract | `defer` の場合、`defer_contract_id` と10で検証する未解決事項がある | `<defer>` |
| unresolved policy | `defer` の未解決事項が解けなかった場合の戻し先、停止条件、再確認phaseが明記されている | `<defer>` |
| stop reason type | `stop` の場合、`benign_non_bizcompiler` / `unsafe_or_unauthorized` / `dangerous_scope_unclear` のどれかが明記されている | `<stop>` |

## Phase Boundary Checks

| Check | Pass Criteria | Result |
|---|---|---|
| no 20 work | As-Is詳細分解を00で完了していない | `<pass/rework>` |
| 20 route notes | 20へ渡す入口が `as_is_decompose` / `requirements_candidate` / `business_design_candidate` のどれかとして明記されている | `<pass/defer/rework>` |
| route confirmation | `Route Confirmation` セクションがあり、本人/source holderへの確認質問、回答または根拠、route deltaがある | `<pass/defer>` |
| no 30 work | executor / automation / Skill routingを00で決めていない | `<pass/rework>` |
| no 40+ work | IR、consent、validation、operation設計を00で固定していない | `<pass/rework>` |
| later notes | 後続phaseの話を `later-phase-notes.md` に送っている | `<pass/defer/rework>` |

## Entry Gate Decision

| Field | Value |
|---|---|
| entry_gate_result | `pass` / `defer` / `rework` / `stop` |
| terminality | `terminal` / `non-terminal loop` |
| reason | `<判断理由>` |
| interaction_state | `initial_request_only`、`user_answer_count`、`material_evidence_count`、`asked_question_count` |
| work_unit | `single_business` / `workflow_or_operation` / `business_program` / `unclear` |
| delivery_shape | `single_executor` / `multi_executor_team` / `unknown` |
| source_posture | `first_party` / `source_holder_connected` / `proxy_hearsay` / `mixed` / `unknown` |
| 20_readiness | `as_is_decompose` / `requirements_candidate` / `business_design_candidate` / `do_not_proceed_rework` / `do_not_proceed_stop` |
| route_confirmed_by_requester | `yes` / `partial` / `no` / `not_yet` / `not_applicable` |
| route_delta_after_confirmation | `none` / `existing_to_new` / `new_to_existing` / `single_to_program` / `program_to_single` / `unknown_to_fixed` |
| next_phase | `10-source-intake` / `none` |
| rework_target | `00-entry` / `none` |
| deferred_items | `<10で検証する未確認事項>` |
| defer_contract_id | `<deferの場合はDC-001など。pass/rework/stopならnone>` |
| next_00_questions | `<reworkの場合に00内で次に聞く質問>` |
| stop_reason_type | `benign_non_bizcompiler` / `unsafe_or_unauthorized` / `dangerous_scope_unclear` / `none` |
| stop_reason | `<stopの場合の理由>` |