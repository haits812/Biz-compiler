# 00 Anomaly Rules

00-entry では、入口での違和感を拾う。違和感は即却下ではないが、10へ進める前に扱いを明記する。

違和感を、よくある曖昧さ、低言語化、不正・権限迂回の疑いに分ける。不正・権限迂回の疑いは、単なる情報不足として扱わない。

## Anomaly Table

| Signal | 何が危ないか | 00での扱い |
|---|---|---|
| 「全部自動化したい」だけで対象業務が言えない | scope不在 | 追加質問。業務候補が出なければ `rework` |
| 成果物だけ欲しいが運用が存在しない | Biz-compiler対象ではなく単発作業かもしれない | `stop` または別作業として切り出す |
| 他部署・社外・顧客に影響するが責任者が不明 | N-interface / approval不明 | risk hintに記録し、owner候補を確認 |
| 個人情報・契約情報・外部送信がありそうだがscopeが粗い | sensitive / irreversible risk | `initial-risk-memo.md` に記録し、10でsource確認 |
| 成功条件が「いい感じ」「楽にしたい」だけ | gate不能 | 粗いsuccess guessを追加質問 |
| 既存資料や実例が何もなく、本人説明しかない | evidence不足 | new_workなら仮説扱い。existing_workならsource候補を再確認 |
| 初手で綺麗な既存フロー、手順書、マニュアル、Excelが渡される | 資料が実運用・例外・差戻しを代表しているとは限らない | source候補として扱い、owner、更新日、実担当者、例外、差戻し履歴を確認。資料があるだけで `pass` にしない |
| 実は単発作業で、継続業務ではない | phase化の価値が薄い | `stop` または単発支援へ切り替え |
| いきなりSkillやautomationを作りたがる | 20/30飛ばし | intentに留め、routingは30へ送る |
| すでに解決策が決まっておりAs-Is観測を飛ばそうとする | evidence不在の設計固定 | 10/20で検証する前提に戻す |
| scope外の資料や部署を便利だから混ぜようとする | stealth scope creep | out_of_scope / undecided_scopeに分ける |
| 社外相手への連絡で、名義・権限・承認者を曖昧にする | impersonation / unauthorized external action | 正当なowner、承認者、送信主体、利用可能なsourceを確認。曖昧なままなら `stop` |
| scraping、名簿流用、過去メールから相手を拾って外部送信したい | consent / source boundary不明 | source候補ではなくrisk hintとして扱う。権限と利用許可が出ないなら `stop` |
| 法務、経理、顧客、本人確認、承認gateを迂回したい | approval bypass / irreversible risk | `stop`。効率化要望として薄めず、人間判断待ちにする |
| 「バレないように」「相手に気づかれず」「公式っぽく」などの隠蔽語がある | deceptive intent | 実行案、文面案、運用案を出さない。正規業務として再定義できる場合だけ `rework` |
| 話題が飛び続け、業務候補・owner・sourceを1つに絞れない | 10で集めるsource対象が決まらない | `rework`。候補を列挙して、1つだけ選ばせる |
| 低言語化で、こちらの出力案に合わせて頷きそう | assistant仮説が本人確認済み事実に見える | 出力案は候補として提示し、`confidence = low` で記録する |

## Adversarial / Abuse Handling

不正・権限迂回の疑いがある時は、業務改善の依頼として綺麗に整えない。

00担当は次を行う。

- requester がその業務を依頼する権限を持つか確認する。
- 外部送信、個人情報、契約情報、口座情報、支払情報を扱う場合は、owner、承認者、source利用許可を確認する。
- なりすまし、隠蔽、承認迂回、同意なし収集に見える場合は、実行手順や文面案を出さない。
- 正規業務として扱えるなら、`rework` として owner / source / approval を聞き直す。
- 正規業務として扱えない、または requester が確認を避けるなら `stop` にする。

## Low-Articulation Handling

ユーザーがうまく言語化できない時は、こちらで補助してよい。ただし、補助した仮説を確定事項にしない。

- 候補を出す時は「候補の一つ」「仮説」「違っていたら直す」と明示する。
- 出力案、業務名、success guess、rough IOをこちらが置いた場合は `confidence = low` とする。
- provenance はIR共通値の `hypothesized` にし、細かい由来は `claim_type = hypothesis`、`source_type = assumption`、`source_ref = conversation` のように分ける。
- ユーザーが「それでいい」と答えても、sourceで確認されるまでは観測済み事実に昇格しない。
- 具体sourceとsource holderを確認するまでは、業務候補が見えても `pass` ではなく `defer` にする。
- 低言語化そのものを `stop` 理由にしない。業務候補、owner、source候補が一つも決まらない場合だけ `rework` にする。

## Proxy / Hearsay Handling

代理/伝聞経由の依頼は、本人またはsource holderへ実際に接続するまで `pass` にしない。

- 「本人に確認してよい」は接続許可であり、本人確認済みではない。
- 実担当者名、source holder、owner候補、次に見る資料が揃った場合は `defer` として10へ渡す。
- 実担当者やsource holderへ接続できない場合は `rework`。
- 代理者が確認を避ける、または外部作用やsensitiveを進めようとする場合は `stop` 候補。

## Stop Conditions

次の場合は、10へ進めず `stop` または `rework` にする。

- 業務候補が一文で言えない。
- 既存業務か新規構想か判断できない。
- requester / actor / owner候補が全くない。
- scopeが広すぎて、10でsourceを集める対象を決められない。
- 外部作用やsensitiveが強いのに、人間確認なしで進めようとしている。
- なりすまし、隠蔽、承認迂回、同意なし収集が疑われる。
- 個人情報、契約情報、口座情報、支払情報を扱うのに、正当なownerや承認者が出せない。
- requester が権限、source、承認者の確認を避け続ける。
- Biz-compilerではなく、単発の文章作成・調査・実装依頼として扱うべき。

## Do Not Discard

違和感があっても、ユーザーの話を捨てない。次のいずれかに分類する。

- `unknowns`
- `initial_risk_hints`
- `later_phase_notes`
- `stop_reason`
- `out_of_scope`
- `low_confidence_hypotheses`
