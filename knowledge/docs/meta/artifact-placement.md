# Artifact Placement v0

このファイルは、Biz-compilerで新しいファイルやフォルダをどこへ置くかを決めるメタ土台である。

人間が見る主要導線は `template/<数字phase>/` と `output/Biz-001-業務名/<数字phase>/` に寄せる。設計知識と運用メモリは `knowledge/` に寄せる。リポジトリ直下へ用途別フォルダを増やさない。

## 配置判断表

| 置き場 | 置くもの | 置かないもの | 判定規則 |
|---|---|---|---|
| root | 毎回読む入口、repo全体の現在地、作業規約、思考方位 | 個別phase成果物、script集、schema集、samples | 全作業者が最初に読むか、repo全体の入口か |
| `knowledge/docs/` | 確定知識、要求、決定、メタ土台、用語、IR設計、方法論、事例、評価 | 業務実行時にコピーされるasset、個別業務の運用ログ | このrepoを作るための知識か |
| `knowledge/docs/meta/` | 数字工程に入らない本当のメタ土台 | phase-local雛形、個別業務artifact | 全phase、会話、委譲、配置判断にまたがるか |
| `knowledge/docs/lexicon.md` | 用語定義と概念境界 | Compass本体、IR schemaの詳細 | 語の意味や似た語の違いを固定するか |
| `knowledge/docs/ir/` | IR、contract、schema、manifestの概念設計 | phaseごとの質問票、表示HTML | 機械可読契約の意味に関わるか |
| `knowledge/docs/method/` | ENCRS、phase設計、検証ループなどの方法論 | 実行script、業務固有runbook | 進め方や判断手順の知識か |
| `knowledge/docs/casebook.md` | 判断例、反例、比較ケース | 正本schema、運用ログ | 判断に迷う時の事例か |
| `knowledge/docs/evaluation.md` | fresh executor、shadow run、eval、受け入れ条件 | 実業務の検証結果そのもの | 検証の設計・観点か |
| `knowledge/docs/decisions/` | 採用/却下の背景理由 | 常時読む短い現在地 | なぜそう決めたかを残す必要があるか |
| `knowledge/ops/` | repo-local Skill、hook adapter、orchestrator、ops registry、管理コマンド | 業務実行用の個別Skill、直下の野良`.ps1` | このrepoの知識運用や作業前gateを操作するか |
| `template/<数字phase>/` | 業務フォルダへコピーされるphase-local雛形 | 全phase共通の思想や用語本文 | 特定phaseで作業者が使う雛形か |
| `template/_shared/` | 業務フォルダ内から使う横断runner、validator、schema、script、tool | 開発運用メモ、要求定義 | outputへコピーされる横断部品か |
| `output/Biz-001-業務名/` | 実際にコンパイルしている個別業務のartifact、ledger、event log | サンプル、プレースホルダ、compiler repoの知識 | 実業務作成時に採番された成果物か |

## phase-local と本当のメタ土台

| 判定質問 | Yesなら |
|---|---|
| 特定の数字phaseだけで使う質問票・雛形・チェックリストか | `template/<数字phase>/` |
| 業務フォルダへコピーされて、その業務の中で使われるか | `template/<数字phase>/` または `template/_shared/` |
| 全phaseの読み方、状態、配置、brief、完成条件を決めるか | `knowledge/docs/meta/` |
| 用語の意味や境界を決めるだけか | `knowledge/docs/lexicon.md` |
| 個別業務の進行状態、実行ログ、監査ログか | `output/Biz-001-業務名/` |
| このrepoの作業規約や現在地として毎回読む必要があるか | root |

本当のメタ土台は、数字工程の中身ではなく、数字工程をどう読むか、どう委譲するか、どこへ置くか、何を完成と呼ぶかを決める。

## 置き場決定の手順

1. まず、そのartifactが実業務の成果物か、compiler repoの知識かを分ける。
2. 実業務の成果物なら、実業務作成時に `output/Biz-001-業務名/` 配下へ置く。現時点でプレースホルダは作らない。
3. 業務フォルダへコピーして使う原型なら、`template/<phase>/` か `template/_shared/` へ置く。
4. repoを作るための知識なら、`knowledge/docs/` のread routingに従う。
5. knowledgeを操作するSkillなら、`knowledge/ops/skills/<skill-name>/` に `SKILL.md` と同居させる。作業前gateなどの固定手順なら、`knowledge/ops/orchestrators/<orchestrator-name>/` に説明ファイルと同居させる。
6. どれにも当てはまらない場合だけ、rootに置く理由があるか確認する。

## 禁止

- repo直下に `docs/`、`pending/`、`journal/`、`samples/`、`internal/`、`scripts/`、`schemas/`、`runner/`、`tools/`、`validators/`、`phase-packs/` を増やさない。
- `output/` 直下に `example-business-id`、`_business-id`、サンプル業務、プレースホルダ業務フォルダを作らない。
- `knowledge/ops/` 直下に `.ps1` を置かない。
- phase-localな不足物を `knowledge/docs/meta/README.md` のメタ土台台帳へ混ぜない。
- 個別業務のSkill、adapter、workflowをcompiler repo直下へ溜め込まない。

## 更新ルール

新しい置き場を作る場合は、`AGENTS.md`、`Hello,world.md`、`knowledge/ops/registry.md`、`knowledge/docs/README.md`、`knowledge/docs/meta/README.md` のどれへ影響するかを確認する。`MEMORY.md` へ配置情報を写さない。root構成、`template/`、`knowledge/`、`output/` の生成ルールを変えた場合は、同じターンでハロワゲートを通す。
