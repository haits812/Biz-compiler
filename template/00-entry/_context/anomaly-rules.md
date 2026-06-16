# 00 Anomaly Rules

00-entry では、入口での違和感を拾う。違和感は即却下ではないが、10へ進める前に扱いを明記する。

## Anomaly Table

| Signal | 何が危ないか | 00での扱い |
|---|---|---|
| 「全部自動化したい」だけで対象業務が言えない | scope不在 | 追加質問。業務候補が出なければ `rework` |
| 成果物だけ欲しいが運用が存在しない | Biz-compiler対象ではなく単発作業かもしれない | `stop` または別作業として切り出す |
| 他部署・社外・顧客に影響するが責任者が不明 | N-interface / approval不明 | risk hintに記録し、owner候補を確認 |
| 個人情報・契約情報・外部送信がありそうだがscopeが粗い | sensitive / irreversible risk | `initial-risk-memo.md` に記録し、10でsource確認 |
| 成功条件が「いい感じ」「楽にしたい」だけ | gate不能 | 粗いsuccess guessを追加質問 |
| 既存資料や実例が何もなく、本人説明しかない | evidence不足 | new_workなら仮説扱い。existing_workならsource候補を再確認 |
| 実は単発作業で、継続業務ではない | phase化の価値が薄い | `stop` または単発支援へ切り替え |
| いきなりSkillやautomationを作りたがる | 20/30飛ばし | intentに留め、routingは30へ送る |
| すでに解決策が決まっておりAs-Is観測を飛ばそうとする | evidence不在の設計固定 | 10/20で検証する前提に戻す |
| scope外の資料や部署を便利だから混ぜようとする | stealth scope creep | out_of_scope / undecided_scopeに分ける |

## Stop Conditions

次の場合は、10へ進めず `stop` または `rework` にする。

- 業務候補が一文で言えない。
- 既存業務か新規構想か判断できない。
- requester / actor / owner候補が全くない。
- scopeが広すぎて、10でsourceを集める対象を決められない。
- 外部作用やsensitiveが強いのに、人間確認なしで進めようとしている。
- Biz-compilerではなく、単発の文章作成・調査・実装依頼として扱うべき。

## Do Not Discard

違和感があっても、ユーザーの話を捨てない。次のいずれかに分類する。

- `unknowns`
- `initial_risk_hints`
- `later_phase_notes`
- `stop_reason`
- `out_of_scope`