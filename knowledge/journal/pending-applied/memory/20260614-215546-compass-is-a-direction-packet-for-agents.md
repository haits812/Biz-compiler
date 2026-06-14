<!--
Status: applied
ResolvedAt: 2026-06-14T22:03:55+09:00
SourceId: approved/memory/20260614-215546-compass-is-a-direction-packet-for-agents.md
Reason: AGENTS.md、MEMORY.md、knowledge/docs/README.md、Decisionへ反映済み
-->

<!--
Status: approved
ResolvedAt: 2026-06-14T22:03:44+09:00
SourceId: memory/20260614-215546-compass-is-a-direction-packet-for-agents.md
Reason: Compassをdirection packetとし、read routingで詳細知識を読む方針を採用
-->

# Compass is a direction packet for agents

## Target
MEMORY.md

## Proposed Change
COMPASS.mdは、Biz-compilerの判断論全体を溜め込む場所ではなく、作業者・subagentにheadingを渡すための短い方向指示として扱う。IR詳細、検証ループ、実装要件、roadmapは必要に応じてLexicon/IR/Decision/Casebook等へ分離する。

## Evidence
ユーザー訂正: Compassは網羅的な業務設計論ではなく、重ための作業やsubagent委譲時に思考の指向性を渡す場所。

## Risk
現状のCOMPASS.mdにはIR要件や経験的業務設計ループなどが混在しており、subagentへ渡すheadingとして重くなっている。
## Follow-up Nuance

- `COMPASS.md` は本セッションの会話開始時にも読むべき思考の指向性である。
- 重ための作業をsubagentや作業担当者へ振る場合も、同じpassion / headingを渡すために使う。
- そのため、Compassに残すべき内容と、Lexicon / IR / Casebook / Evaluation / Decision へ逃がすべき内容を分ける必要がある。


