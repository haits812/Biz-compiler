# Meta Foundation Ledger

このファイルは、数字工程 `template/<数字phase>/` に入らない、本当のメタ土台を管理するMarkdown台帳である。

メタ土台は急増しない前提で、このMarkdown表を正本にする。JSON台帳は現時点では作らない。

## 目的

メタ土台とは、特定phaseの成果物ではなく、Biz-compilerの全工程・全会話・全委譲にまたがって、成果物の意味、状態、置き場、読み方、進め方を決める上位ルールである。

この台帳で見ること:

- 何がメタ土台か
- 整備済みか、未整備か、一部だけあるか
- 正本はどこか
- これを読む時に併読するものは何か
- これを更新した時に触るものは何か
- 何に依存しているか
- 次に何をすればよいか

## 運用ルール

- メタ土台を整備・追加・分割・廃止したら、この台帳を同じターンで更新する。
- 状態は `整備済み`、`一部あり`、`未整備`、`廃止` のどれかにする。状態語彙は `state-model.md` に従う。
- `併読` は、その項目を読む時に一緒に見た方がよいものを書く。
- `更新時に触る` は、その項目を変えた時に同期確認するファイルを書く。
- `依存` は、その項目を整備する前提になるメタ土台を書く。
- 数字工程に入る不足物はここへ混ぜず、`template/phase-local-missing.md` へ置く。
- JSON台帳化は当面しない。Markdown表で読める範囲を超えた時だけ再検討する。

## 台帳

| ID | メタ土台 | 役割 | 状態 | 正本/置き場 | 併読 | 更新時に触る | 依存 | 次アクション |
|---|---|---|---|---|---|---|---|---|
| hello-world | 現在地モデル | repoの現在地を返す | 整備済み | `Hello,world.md` | `AGENTS.md`, `MEMORY.md` | `Hello,world.md` | なし | gate運用で維持 |
| compass | 判断方位 | 作業者の思考prior、疑うもの、価値順位 | 整備済み | `COMPASS.md` | `SOUL.md`, `USER.md`, `knowledge/docs/README.md` | `COMPASS.md`, `knowledge/docs/README.md`, `MEMORY.md` | なし | 必要時だけ圧縮更新 |
| soul | 対話姿勢 | agentの振る舞い、聞き取り姿勢、避ける失敗 | 整備済み | `SOUL.md` | `USER.md`, `COMPASS.md` | `SOUL.md`, `MEMORY.md` | なし | 維持 |
| user-model | ユーザー作業モデル | 主利用者の進め方、嫌う混同、会話前提 | 整備済み | `USER.md` | `SOUL.md`, `COMPASS.md` | `USER.md`, `MEMORY.md` | なし | 維持 |
| memory | 開発運用メモリ | 常時効く決定済み事項と現在構成 | 整備済み | `MEMORY.md` | `knowledge/docs/meta/README.md`, `knowledge/ops/skills/knowledge-curation/` | `MEMORY.md`, 必要なら `knowledge/docs/decisions/` | なし | 肥大化時にdocsへ退避 |
| read-routing | Read routing | 作業種別ごとの追加読み込み先 | 整備済み | `knowledge/docs/README.md` | `COMPASS.md`, `AGENTS.md` | `knowledge/docs/README.md`, `AGENTS.md`, `MEMORY.md` | compass | 新しい知識区分追加時に更新 |
| gate-workflow | Gate workflow | Hello World更新、commit/push、対象なし判定 | 整備済み | `knowledge/ops/skills/hello-world-gate/` | `Hello,world.md`, `MEMORY.md` | `Hello,world.md`, `AGENTS.md`, `MEMORY.md` | hello-world | 維持 |
| phase-catalog | Phase catalog | 00〜80が何の工程で、何を決めるか | 整備済み | `knowledge/docs/meta/phase-catalog.md` | `template/phase-local-missing.md`, `knowledge/docs/requirements/Biz-compiler_要求定義.md` | `knowledge/docs/meta/README.md`, `knowledge/docs/README.md`, `MEMORY.md` | read-routing | phase-local README作成時に参照 |
| state-model | State model | 整備状態、主張状態、pending運用状態を分ける | 整備済み | `knowledge/docs/meta/state-model.md` | `MEMORY.md`, `knowledge/ops/skills/pending-memory/` | `knowledge/docs/meta/README.md`, `MEMORY.md` | なし | 台帳/Memory/pending運用で維持 |
| lexicon-v0 | Lexicon v0 | 全工程共通語彙の意味と境界 | 整備済み | `knowledge/docs/lexicon.md` | `COMPASS.md`, `knowledge/docs/requirements/Biz-compiler_要求定義.md`, `state-model.md` | `knowledge/docs/meta/README.md`, `knowledge/docs/README.md`, `MEMORY.md` | state-model | 用語追加時に更新 |
| session-brief | Session brief型 | 今回の仮ゴール、scope、読むもの、完了条件 | 整備済み | `knowledge/docs/meta/session-brief.md` | `Hello,world.md`, `COMPASS.md`, `USER.md` | `knowledge/docs/meta/README.md`, `AGENTS.md`, `MEMORY.md` | state-model | 通常作業の開始時に使う |
| subagent-brief | Subagent brief型 | 委譲先の仮ゴール、Compass、必要資料、成果物契約 | 整備済み | `knowledge/docs/meta/subagent-brief.md` | `COMPASS.md`, `knowledge/docs/README.md`, `session-brief.md` | `knowledge/docs/meta/README.md`, `AGENTS.md`, `MEMORY.md` | session-brief, read-routing | 委譲時に使う |
| completion-criteria | Meta completion criteria | メタ土台が一旦使えると言える条件 | 整備済み | `knowledge/docs/meta/completion-criteria.md` | `phase-catalog.md`, `state-model.md`, `knowledge/docs/lexicon.md` | `knowledge/docs/meta/README.md`, `MEMORY.md` | phase-catalog, state-model, lexicon-v0 | メタ土台評価時に使う |
| artifact-placement | Artifact placement rule整理版 | root、template、_shared、knowledge、outputの配置判断 | 整備済み | `knowledge/docs/meta/artifact-placement.md` | `AGENTS.md`, `MEMORY.md`, `template/phase-local-missing.md` | `knowledge/docs/meta/README.md`, `AGENTS.md`, `MEMORY.md`, `Hello,world.md` | phase-catalog | 新規ファイル追加時に参照 |

## ここに含めるもの

- 全工程で使う状態や語彙のルール
- phaseより上位の目次、分類、配置判断
- 会話やsubagent委譲の進め方
- メタ土台そのものの完成/未完成の棚卸し
- 数字工程に入れるかどうかを判断するための基準
- 併読、更新時に触るもの、依存などの台帳情報

## ここに含めないもの

| 入れないもの | 置き場 |
|---|---|
| 各phaseの質問、成果物雛形、phase-local README | `template/<数字phase>/` |
| phase-localな未整備項目メモ | `template/phase-local-missing.md` |
| 業務フォルダへコピーされる共通schema、validator、runner、script | `template/_shared/` |
| 用語定義の本文 | `knowledge/docs/lexicon.md` |
| IR、contract、schema、manifestの詳細 | `knowledge/docs/ir/` |
| 方法論、ENCRS、検証ループの詳細 | `knowledge/docs/method/` |
| 判断例、反例、比較ケース | `knowledge/docs/casebook.md` |
| eval、fresh executor、shadow run | `knowledge/docs/evaluation.md` |
| 決定の背景理由 | `knowledge/docs/decisions/` |
| 知識候補の格上げ/保留/退避/廃棄の運用手順 | `knowledge/ops/skills/knowledge-curation/` |
| 実際にコンパイルしている個別業務の状態 | `output/Biz-001-業務名/` |

## Markdown正本で進める理由

現時点では、メタ土台はこの表で十分に読める量であり、JSON台帳やvalidatorを先に作る必要はない。

- メタ土台はphase-local成果物ほど増えない。
- 人間が直接読んで直せることを優先する。
- 台帳生成やvalidatorは、更新漏れや機械処理の需要が実害として出てから検討する。
- `registry-management` は独立メタ土台ではなく、このMarkdown正本を維持する運用判断として扱う。

## 現時点の次候補

1. `template/<数字phase>/` 側のphase-local README v0を整える。
2. `knowledge/docs/ir/` で同意ビューJSONと実行IRの関係を固定する。
3. `knowledge/docs/evaluation.md` でfresh executor / shadow run / evalのv0観点を作る。
4. `knowledge/docs/casebook.md` で良い判断/悪い判断の比較例を作る。
