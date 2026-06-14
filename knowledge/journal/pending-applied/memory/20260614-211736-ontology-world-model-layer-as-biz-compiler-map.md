<!--
Status: applied
ResolvedAt: 2026-06-15T01:48:03+09:00
SourceId: approved/memory/20260614-211736-ontology-world-model-layer-as-biz-compiler-map.md
Reason: 自己記述レイヤーは Hello,world.md、MEMORY.md、knowledge/docs/README.md、meta docs の組み合わせとしてv0整備済み。
-->

<!--
Status: approved
ResolvedAt: 2026-06-15T01:48:03+09:00
SourceId: memory/20260614-211736-ontology-world-model-layer-as-biz-compiler-map.md
Reason: 自己記述レイヤーは Hello,world.md、MEMORY.md、knowledge/docs/README.md、meta docs の組み合わせとしてv0整備済み。
-->

# Biz-compiler self-description layer / world model candidate

## Target
MEMORY.md / future self-description index / operational state design

## Proposed Change
Biz-compilerには、固定ファイルとしての `ONTOLOGY.md` や `map.md` を必ず作るというより、業務設計OSとしてAIが参照できる自己記述レイヤーが必要になる候補がある。

ここで必要なのは、業務世界をどう概念に分けるかだけではない。Biz-compiler自身が、現在どのphase、template、contract、validator、knowledge、decision、pendingを持ち、AIがどこから読めばよいかを、最新状態として説明し続ける仕組みである。

ファイル名は未固定。DeckPilotの `docs/architecture.md` のような自動生成インデックスでも、phase commandから出るindexでもよい。重要なのは、AIに毎回全量探索させず、最新の運用状態へ入るための地図を保つこと。

## Evidence
ユーザー発話: Compassの延長線上にオントロジーがあるのでは、業務設計OSならAIが参照すべき業務の地図・世界モデルが必要ではないか、という話から、さらに訂正として「`ONTOLOGY.md` や `map.md` はなくてもいい。そのうえで、最新の運用状態（実際にコンパイルしている業務は含まない）を保ち続ける設計がいるのでは」と整理した。

## Risk
`ONTOLOGY.md` や `map.md` のようなファイル名を先に固定すると、実際に必要な更新機構ではなくドキュメント作成が目的化する。逆に自動生成インデックスだけに寄せると、概念の区別や判断priorが薄くなる。まずは「何を最新状態として保つべきか」と「どの情報は実業務outputに含めないか」を分けて設計する必要がある。


