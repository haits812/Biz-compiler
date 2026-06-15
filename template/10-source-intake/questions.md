# 10 Source Intake Questions

この質問票は、sourceを集めるための入口である。すべてを聞き切る必要はない。20で分解できるだけのsourceと由来を集める。

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
