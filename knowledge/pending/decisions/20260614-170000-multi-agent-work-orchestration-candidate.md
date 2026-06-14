# multi-agent work orchestration 候補

## Target
future output repo runtime / phase 30 routing / phase 60-80 execution loop

## Proposed Change
Hermesの重要な価値は、単一AIとの会話だけでなく、複数のAI/profile/workerを束ねて仕事を並列・分担・回収する点にある。Biz-compilerでも、業務を1つずつ自動化していく過程で、独立ノードの実装、検証、調査、レビュー、改善案作成が並列に走る可能性が高い。

Biz-compilerでは次の2層を分ける。

1. Phase orchestration: 10-80の数字フェーズ。HITL停止点、成果物凍結、Phase Ledger、Event Logを扱う。
2. Work orchestration: 各phaseまたはoutput repo内で発生する具体作業のDAG。複数agent/worker/profileに割り当て、依存、block、complete、parent results参照、監査ログを扱う。

Hermesから借りる候補:

- `delegate_task`: 短命・同期的なsubagent並列。親が待つ。壊れても長期状態は残らない。
- Kanban: durableなmulti-profile/multi-worker work queue。依存リンク、parent results、comment/event log、block/unblock、dispatcher、failure-limitがある。
- `decompose`: triageタスクを子タスクグラフへ分解し、専門profileへ割り当てる発想。
- board/tenant isolation: output repoや業務単位で作業キューを隔離する発想。

Biz-compilerでは、自由なmulti-agent会話にしない。30でexecutor割当を行い、契約・IR・artifact・acceptance criteriaを持つwork itemとしてworkerへ渡す。workerの成果はPhase Ledger / Event Log / artifactへ戻す。

## Evidence
ユーザー発話: Hermesの価値は複数のAIを束ねることだったのではないか。仕事はどうせ並列で動くことがあるはずで、その辺を含めていたか確認したい。

## Risk
multi-agentを先に出しすぎると、Biz-compiler本体が自由なagent会話基盤へ引っ張られる。借りる対象は「複数workerを安全に束ねる作業キュー/依存/監査」の構造であり、phase contractやIRより前に自律agent群を走らせない。
