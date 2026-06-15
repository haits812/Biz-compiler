# Compass を direction packet とし、詳細知識を read routing で読む

- Status: Accepted
- Date: 2026-06-14

## Context

`COMPASS.md` は当初、業務設計の価値順位、検証原則、IR要求、方法論まで広く含んでいた。

ユーザーの意図では、Compassは網羅的な業務設計論ではない。会話開始時や重ための作業をsubagentへ委譲する時に、作業者へ同じ思考の指向性とpassionを渡すための heading / direction packet である。

そのため、Compassに残すものと、詳細ドキュメントへ逃がすものを分ける必要がある。同時に、逃がした知識をいつ読むかの設計が必要である。

## Decision

`COMPASS.md` は短い direction packet として扱う。

Compassに残すもの:

- 作業者の思考の向き
- 価値順位
- 疑うもの
- 判断に迷った時の倒し方
- やってはいけない判断
- subagentへ必ず渡したいpassion / heading

Compassから逃がすもの:

- 用語定義: `knowledge/docs/lexicon.md`
- IR、contract、schema、manifest: `knowledge/docs/ir/`
- 業務設計手順、phase方法論、検証ループ: `knowledge/docs/method/`
- 判断例、反例、良い/悪い設計例: `knowledge/docs/casebook.md`
- fresh executor、shadow run、eval、受け入れ条件: `knowledge/docs/evaluation.md`
- 決定理由: `knowledge/docs/decisions/`
- 要求本体: `knowledge/docs/requirements/`

`knowledge/docs/README.md` を read routing の入口にする。

## Read Routing

常時読むもの:

1. `AGENTS.md`
2. `Hello-world.md`
3. `SOUL.md`
4. `USER.md`
5. `COMPASS.md`
6. `knowledge/docs/lexicon.md`
7. `MEMORY.md`

要求定義は常時読む対象ではない。要求全体確認、要求変更、要求定義との照合が必要な時だけ `knowledge/docs/requirements/` を追加で読む。

その後、作業種別で追加読み込みする。

| 作業 | 追加で読む場所 |
|---|---|
| 用語・概念境界 | `knowledge/docs/lexicon.md` |
| IR / schema / manifest / contract | `knowledge/docs/ir/` |
| phase設計 / ENCRS / 検証ループ | `knowledge/docs/method/` |
| 判断例・反例が必要 | `knowledge/docs/casebook.md` |
| eval / fresh executor / shadow run | `knowledge/docs/evaluation.md` |
| 背景理由が必要 | `knowledge/docs/decisions/` |
| 要求全体、要求変更、要求定義との照合 | `knowledge/docs/requirements/` |

## Subagent Delegation Rule

subagentや別作業者へ重い作業を渡す時、全量の知識を渡さない。

必ず渡すもの:

- `Hello-world.md`
- `SOUL.md`
- `USER.md`
- `COMPASS.md`
- `knowledge/docs/lexicon.md`
- `MEMORY.md`

追加で渡すもの:

- 作業種別に該当する read routing の対象ディレクトリ
- 対象変更に関係する `knowledge/docs/decisions/`

## Consequences

- Compassは毎回読める短さを目指せる。
- 詳細知識は失われず、必要な時だけ読める。
- subagentへ渡すコンテキストが、情熱・方向性と詳細仕様に分離される。
- 今後 `COMPASS.md` を掃除する時は、削除ではなく適切な逃がし先へ移す。
