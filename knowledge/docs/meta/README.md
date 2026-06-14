# Meta Foundation Inventory

このディレクトリは、数字工程 `template/<数字phase>/` に入らない、本当のメタ土台を棚卸しする場所である。

メタ土台とは、特定phaseの成果物ではなく、Biz-compilerの全工程・全会話・全委譲にまたがって、成果物の意味、状態、置き場、読み方、進め方を決める上位ルールである。

## 更新ルール

メタ土台を整備・追加・分割・廃止したら、この表を同じターンで更新する。

更新時に見ること:

- その項目は数字工程に入るものか、全工程横断の土台か
- 既にあるファイルで足りるか、新しいファイルを作るか
- 状態を `整備済み`、`一部あり`、`未整備`、`廃止` のどれにするか
- `knowledge/docs/README.md` のread routingに足す必要があるか
- `MEMORY.md` に常時参照レベルで残す必要があるか

## Inventory

| メタ土台 | 役割 | 状態 | 正本/置き場 | 備考 |
|---|---|---|---|---|
| 現在地モデル | repoの現在地を返す | 整備済み | `Hello,world.md` | position。嘘をつかない invariant |
| 判断方位 | 作業者の思考prior、疑うもの、価値順位 | 整備済み | `COMPASS.md` | heading。subagentにも渡す |
| 対話姿勢 | agentの振る舞い、聞き取り姿勢、避ける失敗 | 整備済み | `SOUL.md` | 汎用人格ではなくこのrepo用 |
| ユーザー作業モデル | 主利用者の進め方、嫌う混同、会話前提 | 整備済み | `USER.md` | 個人プロフィールではない |
| 開発運用メモリ | 常時効く決定済み事項と現在構成 | 整備済み | `MEMORY.md` | 肥大化させず詳細はdocsへ逃がす |
| Read routing | 作業種別ごとの追加読み込み先 | 整備済み | `knowledge/docs/README.md` | Compassから逃がした詳細の入口 |
| Decision workflow | 決定理由を残す場所と粒度 | 一部あり | `knowledge/docs/decisions/` | ADR相当。運用はあるが雛形は未整理 |
| Memory workflow | pending、approved、appliedの運用 | 一部あり | `MEMORY.md`, `knowledge/ops/skills/pending-memory/` | 実行コマンドあり。状態モデルとはまだ分離不足 |
| Gate workflow | Hello World更新、commit/push、対象なし判定 | 整備済み | `knowledge/ops/skills/hello-world-gate/` | repo運用の出口 |
| Phase catalog | 00〜80が何の工程で、何を決めるか | 未整備 | `knowledge/docs/meta/phase-catalog.md` | 各phase READMEより上位の目次 |
| State model | 決定済み、仮説、未検証、pending、accepted、applied等の状態区分 | 未整備 | `knowledge/docs/meta/state-model.md` | IRや記憶で仮説と確定を混ぜないため |
| Lexicon v0 | 全工程共通語彙の意味と境界 | 未整備 | `knowledge/docs/lexicon/README.md` | `gate`, `IR`, `contract`, `manifest`, `provenance` など |
| Session brief型 | 今回の仮ゴール、scope、読むもの、完了条件 | 未整備 | `knowledge/docs/meta/session-brief.md` | 会話単位の目的地宣言。Compassとは別 |
| Subagent brief型 | 委譲先の仮ゴール、Compass、必要資料、成果物契約 | 未整備 | `knowledge/docs/meta/subagent-brief.md` | subagentごとに北極星を別に渡すため |
| Meta completion criteria | メタ土台が一旦使えると言える条件 | 未整備 | `knowledge/docs/meta/completion-criteria.md` | IR/schema実装へ進む判定に使う |
| Artifact placement rule整理版 | root、template、_shared、knowledge、outputの配置判断 | 未整備 | `knowledge/docs/meta/artifact-placement.md` | AGENTS/MEMORYに散っている配置ルールを整理する |

## ここに含めるもの

- 全工程で使う状態や語彙のルール
- phaseより上位の目次、分類、配置判断
- 会話やsubagent委譲の進め方
- メタ土台そのものの完成/未完成の棚卸し
- 数字工程に入れるかどうかを判断するための基準

## ここに含めないもの

| 入れないもの | 置き場 |
|---|---|
| 各phaseの目的、入力、出力、完了条件、質問、成果物雛形 | `template/<数字phase>/` |
| phase-localな未整備項目メモ | `template/phase-local-missing.md` |
| 業務フォルダへコピーされる共通schema、validator、runner、script | `template/_shared/` |
| 用語定義の本文 | `knowledge/docs/lexicon/` |
| IR、contract、schema、manifestの詳細 | `knowledge/docs/ir/` |
| 方法論、ENCRS、検証ループの詳細 | `knowledge/docs/method/` |
| 判断例、反例、比較ケース | `knowledge/docs/casebook/` |
| eval、fresh executor、shadow run | `knowledge/docs/evaluation/` |
| 決定の背景理由 | `knowledge/docs/decisions/` |
| 実際にコンパイルしている個別業務の状態 | `output/Biz-001-業務名/` |

## 現時点の次候補

メタ土台として次に詰める候補:

1. `phase-catalog.md`
2. `state-model.md`
3. `knowledge/docs/lexicon/README.md`
4. `session-brief.md`
5. `subagent-brief.md`
6. `completion-criteria.md`
7. `artifact-placement.md`
