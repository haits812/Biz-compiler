<!--
Status: applied
ResolvedAt: 2026-06-15T01:48:03+09:00
SourceId: approved/memory/20260614-210630-ontology-world-model-layer-as-biz-compiler-map.md
Reason: Ontology/mapという固定ファイルではなく、Hello World・Compass・read routing・meta docsで自己記述レイヤーとして整理済み。
-->

<!--
Status: approved
ResolvedAt: 2026-06-15T01:48:03+09:00
SourceId: memory/20260614-210630-ontology-world-model-layer-as-biz-compiler-map.md
Reason: Ontology/mapという固定ファイルではなく、Hello World・Compass・read routing・meta docsで自己記述レイヤーとして整理済み。
-->

# Ontology world model layer as Biz-compiler map

## Target
MEMORY.md

## Proposed Change
Biz-compilerの次に整える候補として、Ontology / World Model を検討する。これはCompassへ直接詰め込むのではなく、L1 Compass、L2 Lexicon/Framework、IR schemaの間に置く業務世界の概念地図として設計する可能性がある。検討時は、何を分け、何を束ね、何を区別するか自体が判断priorを含む点を明示する。

## Evidence
会話で、Compassの延長線上にontology/world modelがあるのではないか、業務設計OSならAIが参照すべき業務の地図が必要ではないか、という論点が出た。

## Risk
Ontologyを早く固定しすぎると業務を型にはめるL3化が起きる。逆に置かないと、AIがIPO、gate、scope、provenanceなどを場当たり的に解釈し、Compassの判断priorがIRへ安定して伝わらない。


