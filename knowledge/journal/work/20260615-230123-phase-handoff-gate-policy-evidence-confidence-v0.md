# Work Card: phase handoff gate policy evidence confidence v0を追加

- work_id: 20260615-230123-phase-handoff-gate-policy-evidence-confidence-v0
- registered_at: 2026-06-15 23:01:23 +09:00
- kind: docs
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

phase実装前に必要な3つの薄いメタ土台を追加し、IR/methodの読み導線とmeta台帳を同期する

## Impact

IR配下にgate policyとevidence/confidence、method配下にphase handoff/contract gateを追加する。30-route、40-ir-freeze、50-consent、60-validationの判断前提に効く。Hello-worldの構成説明とops registryには直接影響しない。

## Touched Files
- knowledge/docs/ir/gate-policy-matrix.md
- knowledge/docs/ir/evidence-confidence-model.md
- knowledge/docs/method/phase-handoff-and-contract-gate.md
- knowledge/docs/ir/README.md
- knowledge/docs/method/README.md
- knowledge/docs/meta/README.md

## File Locks

Lock state: acquired

Active conflicts before registration:
- None

Other active locks at registration:

## Existing Ops To Check
- registry: knowledge/ops/registry.md
- skill: empirical-prompt-tuning (knowledge/ops/skills/empirical-prompt-tuning/)
- skill: hello-world-gate (knowledge/ops/skills/hello-world-gate/)
- skill: knowledge-curation (knowledge/ops/skills/knowledge-curation/)
- skill: paper-write (knowledge/ops/skills/paper-write/)
- skill: skill-creator-gate (knowledge/ops/skills/skill-creator-gate/)
- skill: web-research-to-report (knowledge/ops/skills/web-research-to-report/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- orchestrator: knowledge-search (knowledge/ops/orchestrators/knowledge-search/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口
- knowledge/docs/ir/: IR / schema / manifest / contract の設計
- knowledge/docs/meta/: メタ土台、配置判断、brief、完成条件
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形
- knowledge/docs/decisions/: 背景理由の確認

## Markdown Reference Impact

- knowledge/docs/ir/README.md
  - AGENTS.md:92
  - AGENTS.md:118
  - AGENTS.md:119
  - AGENTS.md:120
  - AGENTS.md:122
  - AGENTS.md:124
  - AGENTS.md:146
  - AGENTS.md:230
  - AGENTS.md:243
  - AGENTS.md:310
  - COMPASS.md:96
  - Hello-world.md:58
  - Hello-world.md:67
  - Hello-world.md:145
  - Hello-world.md:147
  - Hello-world.md:150
  - Hello-world.md:151
  - Hello-world.md:168
  - Hello-world.md:170
  - Hello-world.md:172
  - Hello-world.md:183
  - Hello-world.md:188
  - Hello-world.md:190
  - Hello-world.md:192
  - Hello-world.md:218
  - ... truncated at 25 references
- knowledge/docs/method/README.md
  - AGENTS.md:92
  - AGENTS.md:118
  - AGENTS.md:119
  - AGENTS.md:120
  - AGENTS.md:122
  - AGENTS.md:124
  - AGENTS.md:146
  - AGENTS.md:230
  - AGENTS.md:243
  - AGENTS.md:310
  - COMPASS.md:96
  - Hello-world.md:58
  - Hello-world.md:67
  - Hello-world.md:145
  - Hello-world.md:147
  - Hello-world.md:150
  - Hello-world.md:151
  - Hello-world.md:168
  - Hello-world.md:170
  - Hello-world.md:172
  - Hello-world.md:183
  - Hello-world.md:188
  - Hello-world.md:190
  - Hello-world.md:192
  - Hello-world.md:218
  - ... truncated at 25 references
- knowledge/docs/meta/README.md
  - AGENTS.md:92
  - AGENTS.md:118
  - AGENTS.md:119
  - AGENTS.md:120
  - AGENTS.md:122
  - AGENTS.md:124
  - AGENTS.md:146
  - AGENTS.md:230
  - AGENTS.md:243
  - AGENTS.md:310
  - COMPASS.md:96
  - Hello-world.md:58
  - Hello-world.md:67
  - Hello-world.md:145
  - Hello-world.md:147
  - Hello-world.md:150
  - Hello-world.md:151
  - Hello-world.md:168
  - Hello-world.md:170
  - Hello-world.md:172
  - Hello-world.md:183
  - Hello-world.md:188
  - Hello-world.md:190
  - Hello-world.md:192
  - Hello-world.md:218
  - ... truncated at 25 references

## Execution Assignment

- executor: codex
- subagent: 必要なら knowledge/docs/meta/subagent-brief.md に従って、タスク用仮ゴールを別で渡す

## Finish Gate
- git diff --check
- hello-world-gate.ps1 で Hello-world.md 同期、検査、commit/push
- 作業完了時に impact-orchestrator -Complete でwork cardを閉じ、lockを解放

## MergeGate Mapping

| 作法 | このwork cardでの対応 |
|---|---|
| register work | このファイルを作る |
| record impact | Impact、Touched Files、Markdown Reference Impact に残す |
| lock files | knowledge/journal/work/locks.json にactive lockを持つ |
| assign execution | Execution Assignment に残す |
| verify completion | impact-orchestrator -Complete でこのwork cardを閉じる |
| track branch / PR state | 未実装。GitHub運用が固まってから判断する |

## Completion

- status: pending
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-230123-phase-handoff-gate-policy-evidence-confidence-v0.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 23:04:52 +09:00
- status: completed
- result: gate policy matrix、evidence/confidence model、phase handoff/contract gate v0を追加し、IR/method READMEとmeta台帳を同期
- verified: git diff --check、各新規docの読み戻し、README/meta台帳の参照確認
- residual_risk: schema化、validator化、phase-local READMEへの具体反映は未実施。Revision/Recompile Modelは70/80到達後に整備する方針のまま。
- released_locks: 6

