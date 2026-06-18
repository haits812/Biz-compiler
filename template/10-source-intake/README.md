# 10-source-intake

## Purpose

10-source-intake は、業務を分解する前に source を集め、観測済み事実、本人説明、推測、未確認を分けるphaseである。

ここでは業務をまだ設計しない。As-Is手順を確定したり、To-Be案を決めたり、automation候補を選んだりしない。20-decompose-encrs が分解できるだけの入力と由来を揃える。

## Position

| From | This phase | To |
|---|---|---|
| 00-entry | sourceを集め、事実と未確認を分ける | 20-decompose-encrs |

## Inputs

| Input | 内容 |
|---|---|
| 00 scope | 対象業務、仮ゴール、scope内/外、初期リスク |
| source candidates | 資料、画面、ログ、会話、メール、既存ファイル、手順書、会議メモ |
| user explanation | 本人説明、困りごと、例外、判断軸の仮説 |
| observed traces | 実ファイル、操作痕跡、出力物、差戻し、運用ログ |

## Outputs

| Output | 置き場 | 内容 |
|---|---|---|
| source inventory | `artifacts/source-inventory.md` | 入力資料と観測対象の一覧 |
| intake log | `artifacts/intake-log.md` | ヒアリング/観測の時系列ログ |
| fact register | `artifacts/fact-register.md` | 事実、本人説明、推測、未確認を分けた主張台帳 |
| phase contract | `contract.md` | このphaseが凍結するsource intake契約 |
| handoff packet | `handoff.md` | 20へ渡す最小情報 |

## Workflow

1. 00-entry から対象業務、scope、仮ゴールを受け取る。
2. source候補を `artifacts/source-inventory.md` に登録する。00の `provided` は `collected` + 未reviewとして正規化し、10のstatusへ `provided` を残さない。
3. 10担当がsource確認として何を聞いたか、何を読んだか、source holderへ接続できたかを `source_intake_interaction` として残す。資料確認もsource holder接続もないterminal resultは不可。`pass` には少なくとも1つの実資料/ログ/画面/観測source確認が必要。
4. ヒアリング、観測、資料確認のログを `artifacts/intake-log.md` に残す。
5. 主張を `artifacts/fact-register.md` に移し、`observed_fact` / `person_explanation` / `hypothesis` / `unconfirmed` を分ける。
6. 各主張に `source_id`、`provenance`、`confidence`、`counter_evidence` を付ける。`person_explanation` / `hypothesis` / `unconfirmed` は主張内容を `observed` に昇格しない。
7. `checks.md` で、由来不明・推測混入・scope混入・source不足を確認する。
8. completion reviewer subagent が、20へ渡してよいかを別視点で検査する。
9. `handoff.md` を埋め、20-decompose-encrs へ渡す。


## Phase Orchestrator

10-source-intake の実行入口は `phase-orchestrator.ps1` である。

| Command | 役割 |
|---|---|
| `start` | 00 handoff、materials、必読ファイル状態、dispatch promptを1つのbundleにする |
| `review` | 10担当subagentの返答を deterministic に検査し、`accept_pass` / `accept_defer` / `ask_rework` / `accept_stop` / `preflight_retry` に分類する |
| `status` | phase-localファイルと最近のwork fileを確認する |

`preflight_retry` は10のgate resultではない。必読ファイルを読了するまで10を開始しないための実行前リトライである。
## Contract Gate

10の出口では、次を満たす必要がある。

| Check | 通す条件 |
|---|---|
| source | 20で分解するための主要sourceが列挙され、00由来statusが10正規statusへ変換されている |
| interaction | `source_intake_interaction` があり、質問回数、資料確認数、source holder接続数が見える。資料確認もsource holder接続もないterminal resultは不可 |
| provenance | 重要な主張に由来がある |
| separation | 事実、本人説明、推測、未確認が混ざっていない |
| confidence | 低confidenceを確定扱いにしていない |
| scope | scope外、external、sensitiveの可能性が見える |
| rework | source不足の場合に、何を追加観測するか分かる |
| reviewer | completion reviewer subagent が、一次情報化できているかを確認している |

結果は `pass` / `defer` / `rework` / `stop` のいずれかにする。`defer` の場合は、未確認事項と次に検証するphaseを明記する。

## Completion Reviewer

10-source-intake の最後では、実行担当とは別のcompletion reviewer subagentが `checks.md` を使って確認する。

reviewer は、sourceを集めた量ではなく、20へ渡す主張が一次情報化できているかを見る。

特に次を確認する。

- source inventory があるか。
- 各claimに `primary` / `secondary` / `hearsay` / `assumption` のsource class、またはそれに相当する provenance が付いているか。
- 実担当者、source holder、owner、承認者が分かれているか。
- 権限、閲覧範囲、利用許可が未確認のまま進んでいないか。
- 最終成果物だけを見て、作業実態を逆算していないか。
- 本人断定、新任者の「普通は」、権限者の説明、代理依頼、善意の説明を観測済み事実へ昇格していないか。
- `defer` のまま20へ送ってよいものと、10または00へ差し戻すものを分けたか。

## Do Not

- 本人説明を観測済み事実として扱わない。
- source target を live-verified source として扱わない。
- 10の時点でexecutorやautomation案を決め切らない。
- 20で分解する前にAs-Is手順を確定しない。
- 出所のない判断軸を高confidenceにしない。
- scope外の情報を便利だから混ぜない。
