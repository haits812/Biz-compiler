# Work Card: taint-lite発想をSkill gateと検収へ残す

- work_id: 20260617-005419-taint-lite発想をskill-gateと検収へ残す
- registered_at: 2026-06-17 00:54:19 +09:00
- kind: memory
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

GitNexus/PDG由来のtaint発想を、実装前の重い解析ではなくSkill gateや検収の品質チェック観点として残す

## Impact

MEMORY.mdの未整理メモに今後の設計候補として追加する。コード、ops入口、Hello-world構成は変更しない

## Touched Files
- MEMORY.md

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
- skill: review-agent-essence (knowledge/ops/skills/review-agent-essence/)
- skill: review-harness (knowledge/ops/skills/review-harness/)
- skill: skill-creator-gate (knowledge/ops/skills/skill-creator-gate/)
- skill: web-research-to-report (knowledge/ops/skills/web-research-to-report/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- orchestrator: knowledge-search (knowledge/ops/orchestrators/knowledge-search/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口

## Markdown Reference Impact

- MEMORY.md
  - AGENTS.md:3
  - AGENTS.md:69
  - AGENTS.md:86
  - AGENTS.md:92
  - AGENTS.md:109
  - AGENTS.md:242
  - AGENTS.md:247
  - AGENTS.md:253
  - AGENTS.md:261
  - AGENTS.md:265
  - AGENTS.md:271
  - AGENTS.md:282
  - AGENTS.md:315
  - COMPASS.md:94
  - Hello-world.md:50
  - Hello-world.md:75
  - Hello-world.md:240
  - knowledge/.index/README.md:5
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:49
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:76
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:12
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:20
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:29
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:32
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-005419-taint-lite発想をskill-gateと検収へ残す.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 00:55:31 +09:00
- status: completed
- result: PDG / taint analysisをtaint-liteとしてskill-creator-gateや検収/validation gateへ残す候補をMEMORY.mdに追記
- verified: git diff --check -- MEMORY.md
- residual_risk: 未整理メモのため、正式反映先は後でknowledge-curationで判断
- released_locks: 1

