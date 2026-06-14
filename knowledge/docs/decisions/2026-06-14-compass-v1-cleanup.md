# COMPASS.md を v1 direction packet へ掃除する

- Status: Accepted
- Date: 2026-06-14

## Context

`COMPASS.md` は、作業者やsubagentへ思考の指向性を渡す heading / direction packet として扱う方針になった。

しかし旧版の `COMPASS.md` には、方法論、prompt tuning由来の説明、IR最小属性、次に作るものまで含まれており、毎回読むheadingとして重かった。

## Decision

`COMPASS.md` を v1 direction packet として圧縮する。

残すもの:

- Core prior
- L1/L2/L3の読み込み規律
- 価値順位
- 業務を見る順番
- 疑うもの
- 禁止する判断
- subagent委譲時の使い方
- 詳細の逃がし先
- Compassを小さく保つルール

逃がしたもの:

- 経験的業務設計ループとprompt tuning由来の方法論: `knowledge/docs/method/empirical-business-design-loop.md`
- IR最小属性と観測済み契約/未検証仮説の分離ルール: `knowledge/docs/ir/minimum-ir-attributes.md`

## Consequences

- `COMPASS.md` は会話開始時やsubagent委譲時に読みやすくなる。
- 詳細は削除されず、read routingに従って必要な時だけ読む。
- 今後Compassへ長い方法論やschema詳細を戻さない。
- Compassを掃除する時は、削除ではなく適切な `knowledge/docs/` へ退避する。
