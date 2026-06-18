# 10 Source Intake Questions

この質問票は、sourceを集めるための入口である。すべてを聞き切る必要はない。20で分解できるだけのsourceと由来を集める。

## Natural Conversation Source Intake

10担当は、00から渡された候補をそのまま成果物化しない。最初のsource確認では、最大3問までで次を揃える。

| # | Question | Required Output |
|---|---|---|
| 1 | まず実物として見られる資料、画面、ログ、サンプルはどれか | `material_evidence_count` と source_id |
| 2 | そのsourceを持つ人、利用許可を出せる人、現場の実担当者は誰か | `source_contact_attempt_count` と actor separation |
| 3 | 差戻し、例外、最近の失敗、古い資料との差分はどこで確認できるか | counter_evidence / near-miss |

資料確認もsource holder接続もない場合、10は `pass` / `defer` terminalにしない。10内で追加観測するか、対象やownerが崩れた場合は00へ戻す。
## Route Flag Recheck

10担当は、00のroute flagをそのまま写して終えない。source確認の入口で、次を最大2問で確認する。

| # | Question | Required Output |
|---|---|---|
| 1 | 00で切った「既存業務 / 新規業務 / 新規事業program」の見立ては、資料やsource holderの説明と矛盾しないか | `route_rechecked_in_10` / `route_delta_from_00` |
| 2 | 複数部署・複数役割が必要な構想なら、20では既存As-Is分解ではなく設計候補整理として扱うべきか | `20_input_contract` / `as_is_observed` |

routeが揺れる場合は、20へ送らず10で追加sourceを取るか00へ戻す。

## Scope Confirmation
| # | Question | Notes |
|---|---|---|
| 1 | 今回扱う業務は何か。どこからどこまでを対象にするか | 00-entryと矛盾する場合は00へ戻す |
| 2 | 対象外にしたい作業、部署、顧客、システムはあるか | out-of-scopeを明示する |
| 3 | 他部署、社外、個人情報、契約情報に触れるか | N-interface / sensitive候補 |

## Source Discovery

| # | Question | Source Type |
|---|---|---|
| 1 | この業務を説明する資料、手順書、テンプレートはあるか | file / document |
| 2 | 実際の入力例と出力例はあるか | file / sample |
| 3 | 差戻し、失敗、near-missの記録はあるか | log / issue / mail |
| 4 | いつ、誰が、何を見て判断しているか | interview / observation |
| 5 | 判断に使う画面、管理表、メール、チャット、会議メモはあるか | system / mail / meeting |
| 6 | 最後にこの業務を実行した実例はあるか | observation / log |

## Separation Questions

| # | Question | Classification Hint |
|---|---|---|
| 1 | 実際に観測できたことは何か | `observed_fact` |
| 2 | 本人が説明しているが、まだ観測できていないことは何か | `person_explanation` |
| 3 | 作業者が推測していることは何か | `hypothesis` |
| 4 | まだ確認していないが重要そうなことは何か | `unconfirmed` |
| 5 | 説明と実例が矛盾している箇所はあるか | `counter_evidence` |

## Provenance / Confidence

| # | Question | Notes |
|---|---|---|
| 1 | その主張はどのsource_idで支えられるか | evidenceがない主張はlow |
| 2 | そのsourceはいつ確認したか | last_checkedを残す |
| 3 | sourceは一次情報か、二次情報か、本人説明か | source_typeに反映する |
| 4 | 同じ主張を支えるsourceは複数あるか | confidence上げ候補 |
| 5 | 反例や例外はあるか | confidence下げ候補 |

## Stop / Rework Questions

| # | Question | Action |
|---|---|---|
| 1 | sourceが足りず、20でAs-Isを分解できないか | 10継続またはrework |
| 2 | 対象業務やscopeが違って見えてきたか | 00へ戻す |
| 3 | scope外やsensitiveを扱う必要が出たか | gate policy notesへ記録 |
| 4 | 本人説明しかなく、観測根拠がない主要判断があるか | low confidenceのままhandoffまたは追加観測 |
