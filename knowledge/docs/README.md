# Knowledge Docs Read Routing

`knowledge/docs/` は、`COMPASS.md` から逃がした詳細を置く場所である。

`COMPASS.md` は、会話開始時やsubagent委譲時に必ず渡す heading packet として短く保つ。詳細はこの階層へ分け、作業種別に応じて必要なものだけ読む。

## Always Read

通常作業の入口では、次を読む。

1. `AGENTS.md`
2. `Hello,world.md`
3. `SOUL.md`
4. `USER.md`
5. `COMPASS.md`
6. `MEMORY.md`
7. `knowledge/docs/requirements/Biz-compiler_要求定義.md`

## Conditional Read Routing

| 読むタイミング | 読む場所 | 用途 |
|---|---|---|
| メタ土台の棚卸し、配置判断、session/subagent brief、状態分類、phase catalog、completion criteriaを扱う時 | `knowledge/docs/meta/` | 数字工程に入らない上位ルール、整備済み/未整備台帳、状態モデル、配置判断、brief型 |
| 用語の意味・語彙境界を決める時 | `knowledge/docs/lexicon.md` | `provenance`、`confidence`、`gate`、`approval`、`validation`、`N-interface` などの定義 |
| IR、contract、schema、manifest、同意ビューJSONを触る時 | `knowledge/docs/ir/` | 契約データと機械可読仕様の読み方 |
| phase設計、業務設計手順、検証ループ、ENCRS運用を考える時 | `knowledge/docs/method/` | 業務をどう読んで進めるかの方法論 |
| 判断に迷う時、良い/悪い設計例を見たい時 | `knowledge/docs/casebook.md` | 判断例、反例、比較ケース |
| fresh executor、shadow run、eval、検証条件を作る時 | `knowledge/docs/evaluation.md` | 評価シナリオ、受け入れ条件、検証観点 |
| 過去の決定理由が必要な時 | `knowledge/docs/decisions/` | 採用/却下の背景、設計判断の履歴 |
| 現時点の要求全体を確認する時 | `knowledge/docs/requirements/` | 要求定義本体 |

## Subagent Delegation

重ための作業をsubagentや別作業者へ渡す時は、全量の `knowledge/docs/` を読ませない。

必ず渡すもの:

- `Hello,world.md`
- `SOUL.md`
- `USER.md`
- `COMPASS.md`
- `MEMORY.md`

追加で渡すもの:

- 作業種別に該当する Conditional Read Routing の該当ファイル/ディレクトリ
- 対象ファイルに関係する `knowledge/docs/decisions/`
- 委譲時は `knowledge/docs/meta/subagent-brief.md` の型

## Boundary

`COMPASS.md` に残すものは、作業者の思考の向き、価値順位、疑うもの、判断の倒し方である。

`knowledge/docs/` に逃がすものは、メタ土台の棚卸し、用語定義、IR詳細、方法論、事例、評価条件、決定理由である。