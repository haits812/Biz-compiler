# 00 Entry Gate

`entry-gate` は、00-entry の出口で使う入口検査である。

目的は「安全判定を完了すること」ではない。業務候補を Biz-compiler の対象として扱えるか、次に実物確認へ進めるか、00内で追加質問するか、停止するかを決める。

## Result Values

| result | terminality | 意味 | 次の動き |
|---|---|---|---|
| `pass` | terminal | 対象業務、owner/actor候補、scope、初期risk、読むsource候補が十分安定している | 00完了。通常のsource確認へ進める |
| `defer` | terminal | 対象業務は見えているが、本人断定、権限、閲覧範囲、sensitive、不可逆操作、代理/伝聞などをsource確認で検証する必要がある | 00完了。未確認事項を10-source-intakeへ渡す |
| `rework` | non-terminal loop | この初期状態なら00内で追加質問が必要。対象業務、owner、source holder、scope、確認すべきsourceがまだ決まらない | 00未完了。追加質問し、再判定する |
| `stop` | terminal | Biz-compiler対象外、単発支援、不正/なりすまし/承認迂回/同意なし収集、または危険なscope不明で止める | 00完了。停止理由を残して進めない |

`source候補がある` だけでは `pass` にしない。source候補があり、かつ大きな未確認リスクを `10-source-intake` で検証できる状態なら、多くは `defer` である。`rework` は終端ではないため、会話可能な実運用では `rework` で00を閉じず、追加質問で `pass` / `defer` / `stop` のterminal resultへ近づける。

低言語化ユーザーから出た候補は、具体sourceとsource holderを確認するまで `pass` 禁止。代理/伝聞経由の候補は、本人またはsource holderへ実際に接続するまで `pass` 禁止。「確認してよい」は `defer` であり、接続済みではない。

## Decision Table

| 状態 | gate result | 理由 |
|---|---|---|
| 初回発話だけ、質問0、追加回答なし、資料実物なし | `rework` | 業務候補らしさがあっても00をterminal完了にしない |
| 対象業務、owner/source holder候補、scope、読むsourceが見え、high-riskが `no` または低く、通常の実物確認で足りる | `pass` | 10で通常source確認へ進める |
| 対象業務と読むsourceは見えるが、external / sensitive / irreversible / authorization / proxy / hearsay / low articulation / source正本性のいずれかが `yes` または `unknown` | `defer` | 10で検証しないと安全・権限・scopeの扱いが変わる |
| 対象業務、owner、source holder、scope、読むsourceのどれかが切れない | `rework` | 10へ渡す前に00内で追加質問が必要 |
| 単発支援、Biz-compiler対象外、または不正/なりすまし/承認迂回/同意なし収集/権限不明の危険な外部作用 | `stop` | 進めると業務コンパイルではなく事故になる |

## Pass / Defer Boundary

`pass` は「リスクがない」という意味ではない。00で扱える範囲の初期riskを見たうえで、10-source-intakeが通常のsource確認として進められる状態を指す。

`defer` は「未確認のまま進めてよい」という意味ではない。10-source-intakeで検証しないと、scope、権限、承認、外部作用、sensitive、不可逆操作、proxy/hearsayの扱いが変わる未確認事項を持ったterminal handoffである。

external / sensitive / irreversible / authorization が `yes` または `unknown` の場合、00で安全側に確定できない限り `pass` ではなく `defer` または `stop` に倒す。

## Entry Gate Lenses

| Lens | 見ること | gateへの倒し方 |
|---|---|---|
| continuity | 継続業務か、単発支援か | 単発なら原則 `stop` または別作業 |
| target unit | 1つの業務候補として切れているか | 複数業務が混ざるなら `rework` |
| actor / owner | requester、実作業者、owner候補が分かるか | 誰の業務か不明なら `rework` |
| source holder | 実物sourceを持つ人/場所へ接続できるか | 接続不能なら `rework`、接続候補ありなら `defer` |
| authority vs observation | 役職や権限を現場理解の証拠にしていないか | 権限だけなら `defer` |
| first-party vs proxy | 代理説明、伝聞、最終資料だけで判断していないか | 実担当者未接続なら `rework` または `defer` |
| overconfidence | 「普通は」「見れば分かる」「だいたい決まっている」をsource扱いしていないか | source確認まで `defer` |
| material path | 実物、ログ、手順、画面、成果物、構想材料があるか | 何を見ればよいか不明なら `rework` |
| upfront flow/material | 初手で既存フロー、手順書、マニュアル、Excelが渡された時に正本性・鮮度・例外・差戻し履歴・実担当者を確認しているか | 資料があるだけなら `defer`。何の業務か切れないなら `rework` |
| rough IO | 入力/出力が粗く見えるか | 全く見えないなら `rework` |
| scope | in/out/undecidedが粗く分かるか | 広すぎるなら `rework` |
| sensitive | finance / HR / legal / procurement / customer / account / contract / personal data があるか | source候補があっても原則 `defer` |
| irreversible | 外部送信、発注、確定、削除、権限変更、請求、支払に近いか | 実行案へ進めず `defer` または `stop` |
| authorization | owner、承認者、送信主体、閲覧範囲、source利用許可が必要か | 未確認なら `defer`、迂回なら `stop` |
| abuse | なりすまし、隠蔽、同意なし収集、承認迂回、不正な外部作用があるか | 実行手順を出さず `stop` |
| low articulation | assistantが補った業務名や出力案を確定していないか | 補完は `confidence = low` で `defer` |
| phase boundary | 20以降の設計を00で決めていないか | 決めていたら `rework` |

## Pass / Defer / Rework Rules

### `pass` にしてよい

- 対象業務が1つに切れている。
- 実作業者、owner候補、source holder候補が見えている。
- 読むsource候補が具体的で、次のsource確認で通常処理できる。
- external / sensitive / irreversible / authorization / approval の初期riskが `no` または低く、10で通常確認すれば足りる。
- high-risk領域でも、00時点でowner、承認者、source holder、確認sourceが明確で、実行判断ではなくsource確認だけへ進める場合に限る。
- 低言語化または代理/伝聞経由の場合は、実担当者またはsource holderへ実際に接続済みである。
- 初手で既存フローや手順書が渡された場合は、その資料のowner、鮮度、対象scope、例外/差戻しの有無を次工程で確認できる。
- 00で後続phaseの設計を固定していない。

### 原則 `defer`

- 本人断定をsource確認していない。
- 権限、承認者、閲覧範囲、利用許可が未確認。
- finance / HR / legal / procurement / customer / account / approval を扱う。
- external / sensitive / irreversible / authorization / approval が `yes` または `unknown`。
- 外部送信、確定、削除、権限変更、請求、発注に近い。
- 新任者、一担当者、権限者、ベテラン、善意の担当者の説明が中心で、一次sourceが未確認。
- 最終成果物や週次/月次資料から作業実態を逆算している。
- source候補はあるが、正本性、網羅性、鮮度、差戻し例、例外が未確認。
- 低言語化ユーザーに対して、業務名、出力案、対象scopeをこちらが補っている。
- 代理/伝聞経由で、本人またはsource holderへの接続許可だけがある。
- 初手で既存フロー、手順書、マニュアル、Excelが渡されたが、実運用との差分、owner、更新日、例外、差戻し履歴が未確認。

### 原則 `rework`（non-terminal loop）

- 対象業務が複数混ざっている。
- 実担当者、owner、source holderが特定できない。
- 代理/伝聞だけで、実担当者やsource holderへ接続できない。
- 「AIで全部」「SaaSで全部」「いい感じに全部」など、入口単位が切れていない。
- 入力/出力、scope、読むsource候補が見えない。

`rework` になった場合、00担当はここで終了報告しない。追加質問で対象、owner、source holder、scope、source候補を絞り、再度 `entry-gate` を判定する。テストで質問回数を制限する場合だけ、その時点の `rework` を「初回状態なら追加質問が必要」という検出結果として扱う。

### 原則 `stop`

- 単発文面作成など、Biz-compilerの業務コンパイル対象ではない。
- なりすまし、隠蔽、同意なし収集、承認迂回、権限不明の外部作用がある。
- 口座情報、個人情報、顧客情報、契約情報などを、正当なownerや承認なしに集めようとしている。
- 危険な依頼に対して、正規業務へ戻す材料がない。

## User-Facing Language

ユーザーへの質問では、内部語彙をそのまま出さない。

| Internal | User-facing |
|---|---|
| `10-source-intake` | 次に実物確認する工程 |
| `source candidate` | 確認できる資料、画面、ログ、実例 |
| `entry-gate` | 入口確認 |
| `defer` | 実物確認で検証する前提で進める |
| `rework` | もう少し対象を絞るため、ここで追加で聞きます |

内部artifactやhandoffでは `10-source-intake`、`source candidate`、`entry-gate` を使ってよい。

## Subagent Self-Check

00担当subagentは、mainへ返す前に次を確認する。

- `COMPASS.md` のValue Prioritiesに反していないか。
- 本人説明を観測済み事実として扱っていないか。
- 役職、権限、経験、善意、自信を evidence として扱っていないか。
- 代理説明、伝聞、最終成果物からの逆算を一次情報として扱っていないか。
- 00で聞くべき質問と、後続phaseへ送るべき話を分けたか。
- 後続phaseの話を、source確認が必要なものと不要なものに分けたか。
- source確認が必要な話に `first_check_phase = 10-source-intake` を付けたか。
- 不正、なりすまし、隠蔽、承認迂回、同意なし収集に見える依頼へ、実行手順や文面案を出していないか。
- 低言語化ユーザーに対して、こちらの業務名、出力案、success guessを断定していないか。
- assistant仮説を `confidence = low` として記録したか。
- ユーザーの「それでいい」を、source確認済みやowner承認済みに昇格させていないか。
- 低言語化経由の候補を、具体sourceとsource holder確認前に `pass` にしていないか。
- 代理/伝聞経由の候補を、本人またはsource holderへの実接続前に `pass` にしていないか。
- 「確認してよい」を、本人確認済みやsource holder接続済みへ昇格させていないか。
- 初手で渡された既存フローや手順書を、実運用確認済みのAs-Isとして扱っていないか。
- `source候補がある` だけで `pass` にしていないか。
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
| Authority | 権限、役職、経験を現場理解の証拠にしていないか |
| Proxy | 代理/伝聞/最終資料だけで通していないか |
| Risk | external / sensitive / irreversibleの初期hintが落ちていないか |
| Authorization | owner、承認者、送信主体、source利用許可が必要な依頼を薄めていないか |
| Abuse | なりすまし、隠蔽、承認迂回、同意なし収集を単なる曖昧さとして扱っていないか |
| Low-language | assistant仮説がlow confidenceの候補として残り、source holder確認前にpassしていないか |
| Upfront material | 初手で渡された既存フローや手順書を、正本性・鮮度・例外未確認のsource候補として扱っているか |
| Handoff | 10がsourceを集められるか |
| Source-first | source確認前に20以降の判断へ直行していないか |
| Gate strictness | `pass` / `defer` / `stop` で閉じてよいか、`rework` を終端扱いしていないか |
| Stop | 止めるべきものを無理にpassしていないか |