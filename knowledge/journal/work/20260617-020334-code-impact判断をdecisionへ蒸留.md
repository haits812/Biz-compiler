# Work Card: code-impact判断をdecisionへ蒸留

- work_id: 20260617-020334-code-impact判断をdecisionへ蒸留
- registered_at: 2026-06-17 02:03:34 +09:00
- kind: docs
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

MEMORY.mdのcode-impact採用メモをdecisionへ昇格し、未整理メモから外す

## Impact

MEMORY.mdの未整理メモとknowledge/docs/decisionsの判断履歴に効く。ops実装やHello-worldの一覧は変更しない

## Touched Files
- MEMORY.md
- knowledge/docs/decisions/2026-06-17-code-impact-lightweight-persistent-graph.md

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
- orchestrator: code-impact (knowledge/ops/orchestrators/code-impact/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- orchestrator: knowledge-search (knowledge/ops/orchestrators/knowledge-search/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/docs/decisions/: 背景理由の確認

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
  - Hello-world.md:245
  - knowledge/.index/README.md:5
  - knowledge/.index/README.md:16
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:49
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:76
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:12
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:20
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:29
  - ... truncated at 25 references

## Code Impact Candidates

- Warning: code-impact query failed. Work card creation continues.
- Exit code: 2
- Rebuild: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 rebuild`
- Retry: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query -Files "MEMORY.md;knowledge/docs/decisions/2026-06-17-code-impact-lightweight-persistent-graph.md" -Depth 2 -Format markdown`

```text
code-impact: target file(s) not indexed: knowledge/docs/decisions/2026-06-17-code-impact-lightweight-persistent-graph.md
```

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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-020334-code-impact判断をdecisionへ蒸留.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 02:05:07 +09:00
- status: completed
- result: code-impact採用判断をdecision recordへ昇格し、MEMORY.mdから未整理メモを削除
- verified: decision本文確認、MEMORY.md確認、git diff --check
- residual_risk: 残りのContract Gate、Revision/Recompile、taint-liteメモはユーザー意向により未整理メモとして保持
- released_locks: 2

