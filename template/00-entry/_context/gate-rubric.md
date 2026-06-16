# 00 Gate Rubric

00-entry gate は、10-source-intakeへ進めるかを判定する。

## Result Values

| result | 意味 |
|---|---|
| `pass` | 10へ進める入口情報が揃っている |
| `defer` | 不明点はあるが、10でsource確認すれば検証できる |
| `rework` | 00で追加質問しないと10の対象が決まらない |
| `stop` | Biz-compiler対象外、人間判断待ち、または危険なscope不明 |

## Gate Checks

| Check | Pass | Defer | Rework / Stop |
|---|---|---|---|
| entry type | `existing_work` / `new_work` が切れている | どちら寄りか仮説がある | `unclear` のまま |
| target statement | 業務候補を一文で言える | 名称は仮だが対象は見える | 何を扱うか分からない |
| material path | 既存型は現物候補、新規型は構想/参考候補がある | 候補は薄いが10で探せる | 何を確認すればよいか不明 |
| actor / owner | requester / user / owner候補がある | 候補は仮説 | 誰の業務か不明 |
| rough IO | 入力/出力の粗い見立てがある | 片方だけ見えている | 入出力が全く見えない |
| scope | in/out/undecidedが粗く分かれる | undecidedが多いが切り口はある | scopeが広すぎる |
| risk hints | 初期risk確認済み | risk未確認だが10で確認可能 | high riskを無視している |
| phase boundary | 20以降の話を決め切っていない | later noteとして保存済み | 00で設計を固定している |

## Subagent Self-Check

00担当subagentは、mainへ返す前に次を確認する。

- `COMPASS.md` のValue Prioritiesに反していないか。
- 本人説明を観測済み事実として扱っていないか。
- 00で聞くべき質問と、後続phaseへ送るべき話を分けたか。
- `entry_type`、`intent`、`scope`、`source_candidates`、`initial_risk_hints` が埋まっているか。
- `unknowns` と `later_phase_notes` が空でも確認済みになっているか。
- 10-source-intakeが次に何を読むべきか分かるか。

## Main Review

main agentは、subagent成果物を会話文脈込みで確認する。

| Review Lens | 見ること |
|---|---|
| Context fit | ユーザーの本意とズレていないか |
| Boundary | 00が後続phaseを食っていないか |
| Evidence | 観測済みと本人説明を混ぜていないか |
| Risk | external / sensitive / irreversibleの初期hintが落ちていないか |
| Handoff | 10がsourceを集められるか |
| Stop | 止めるべきものを無理にpassしていないか |