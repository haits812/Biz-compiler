# 2026-06-15: 要求定義を初期読み込みから外す

## Status
Accepted

## Context

要求定義はBiz-compilerの現時点の要求本体だが、通常作業のたびに読むには大きすぎる。

通常作業やsubagent委譲の入口で必要なのは、現在地、対話姿勢、ユーザーモデル、思考の指向性、用語境界、常時効く運用メモリである。要求定義全体は、要求変更、要求全体確認、要求定義との照合を行う時にだけ必要になる。

## Decision

初期読み込みは次の7ファイルに固定する。

1. `AGENTS.md`
2. `Hello-world.md`
3. `SOUL.md`
4. `USER.md`
5. `COMPASS.md`
6. `knowledge/docs/lexicon.md`
7. `MEMORY.md`

`knowledge/docs/requirements/` は初期読み込みに含めない。要求全体確認、要求変更、要求定義との照合が必要な時だけ追加で読む。

subagent基本セットにも要求定義は含めない。対象作業が要求定義に直接触る、または要求定義との照合を必要とする場合だけ、briefの追加read routingで渡す。

## Consequences

- 初期読み込みトークンを大きく下げられる。
- 要求定義を読ませる場面が明確になり、通常作業や委譲の入口が軽くなる。
- 要求定義を変更する時は、引き続きCompass、IR、同意ビュー、運用ループへの影響を確認する。