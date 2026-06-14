# Phase Catalog v0

このファイルは、Biz-compilerの数字phaseが何を決める工程かを一枚で見るためのメタ土台である。

ここには各phase固有の成果物雛形を置かない。成果物雛形、質問票、ledger、schema、script、HTML assetは `template/<数字phase>/` または `template/_shared/` に属する。

## Phase 一覧

| # | Phase | 目的 | 主な入力 | 主な出力 | 完了条件 | Handoff |
|---|---|---|---|---|---|---|
| 00 | `00-entry` | 入口、対象業務、モード、scope、仮ゴールを決める | ユーザーの依頼、現状の問題意識、対象候補 | 業務ID候補、業務名、scope、モード、仮ゴール、初期リスク | 何をコンパイルするか、次に何を読むかが決まる | 10へ。対象が曖昧なら00に留まる |
| 10 | `10-source-intake` | ソースを集め、観測済み事実と未確認を分ける | 00のscope、既存資料、会話ログ、業務痕跡 | source inventory、observed facts、provenance、未確認事項 | 20で分解できるだけの入力と由来が揃う | 20へ。ソース不足なら10継続 |
| 20 | `20-decompose-encrs` | As-IsをIPO/ENCRSで分解し、dispositionを与える | 10のsource inventory、業務説明、観測事実 | As-Is手順、IPO候補、ENCRS候補、disposition、N-interface候補 | As-Is手順に孤児がなく、To-Be候補へ行き先がある | 30へ。分解不能なら10へ戻る |
| 30 | `30-route-executor` | 各責務を human / automation / Skill / orchestrator / external / approval gate に振る | 20のIPO候補、disposition、scope、リスク | executor routing、自律レベル案、gate案、human-only理由、危険組合せ | 各責務に実行者、自律、gate、scope境界が付く | 40へ。危険組合せは30で止める |
| 40 | `40-ir-freeze` | 契約とIRを凍結し、同意と検証の正本を作る | 30のrouting、各ノードの入出力、provenance/confidence | IR draft/freeze、contract、manifest delta、未検証仮説 | 50の同意ビューと60の検証に渡せる契約になる | 50へ。契約不足なら20/30へ戻る |
| 50 | `50-consent` | 人間が契約差分を見て同意・拒否・保留できる形にする | 40のIR/contract、表示用flow | consent packet、flowchart view、approval record、差戻し理由 | 人間が同意、拒否、または保留を明示する | 同意なら60へ。差戻しなら20/30/40へ |
| 60 | `60-validation` | fresh executorや型/構造チェックで、実行可能性を検証する | 40のcontract、50の同意結果、検証観点 | validation plan、検証結果、失敗、rework項目 | pass / defer / rework のどれかが明確になる | passなら70/80へ。reworkなら30/40へ |
| 70 | `70-improvement` | 運用ログ、drift、near-miss、evalから改善案を作る | 80の運用ログ、差戻し、監査、ユーザーの変更要望 | 改善案、eval結果、昇格/降格候補、再コンパイル候補 | 反映する改善案と保留する改善案が分かれる | 80継続、または30/40/50へ戻る |
| 80 | `80-operation` | 業務を運用し、ledger、runbook、監査、エスカレーションを保つ | 60のpass済み成果物、50の承認、運用条件 | runbook、operation ledger、event log、schedule、escalation、audit link | 継続運用、レビュー、停止、改善提案が回る | 70へ定期接続。重大事故は停止/gateへ |

## 共通ルール

- phaseは一本道に見えるが、60/70から30/40/50へ戻ることを前提にする。
- 00は入口であり、業務ID採番やscopeの前提を決める。実業務を作るまでは `output/` 直下にプレースホルダを作らない。
- 10から40までは、観測済み事実、仮説、未確認を混ぜない。
- 50は完成図ではなく、契約凍結に対する同意ビューである。
- 60は「本人が納得したか」ではなく、第三者実行・構造チェック・反例で見る。
- 70/80は飾りではない。drift、near-miss、昇降格、監査、再コンパイルがBiz-compilerの価値の中心である。

## Phase-local成果物の置き場

このcatalogはphaseの意味を定義するだけで、以下は置かない。

| 成果物 | 置き場 |
|---|---|
| phaseごとのREADME、質問票、チェックリスト | `template/<数字phase>/` |
| 業務フォルダへコピーされるschema、validator、runner、script | `template/_shared/` |
| 実業務のphase ledger、artifact、event log | `output/Biz-001-業務名/<数字phase>/` |
| 共通語彙 | `knowledge/docs/lexicon.md` |
| IR/schema/manifestの詳細 | `knowledge/docs/ir/` |
| ENCRSや検証ループの方法論 | `knowledge/docs/method/` |

## 更新ルール

phaseの意味、名前、handoffを変える場合は、このファイル、`knowledge/docs/meta/README.md`、`knowledge/docs/README.md`、`MEMORY.md` を確認する。`template/` の実ディレクトリ構成を変えた場合は、同じターンで `Hello,world.md` をハロワゲートで同期する。