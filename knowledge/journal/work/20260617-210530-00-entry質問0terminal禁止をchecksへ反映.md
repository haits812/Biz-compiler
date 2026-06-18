# Work Card: 00-entry質問0terminal禁止をchecksへ反映

- work_id: 20260617-210530-00-entry質問0terminal禁止をchecksへ反映
- registered_at: 2026-06-17 21:05:30 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

00-entryの出口正本checksに、初回発話だけでpass/defer terminalにしない規則を追加する

## Impact

template/00-entry/checks.md のentry gate判定に効く。dispatch/reviewだけでなくphase出口条件として質問0完了を拒否する

## Touched Files
- template/00-entry/checks.md

## File Locks

Lock state: acquired

Active conflicts before registration:
- None

Other active locks at registration:
- AGENTS.md locked by 20260617-205649-必読ファイルtimeoutをhard-fail化 (codex, 2026-06-17 20:56:49 +09:00)
- template/00-entry/_context/dispatch-checks.md locked by 20260617-205649-必読ファイルtimeoutをhard-fail化 (codex, 2026-06-17 20:56:49 +09:00)
- template/00-entry/_context/dispatch-packet.md locked by 20260617-205649-必読ファイルtimeoutをhard-fail化 (codex, 2026-06-17 20:56:49 +09:00)
- template/00-entry/phase-orchestrator.ps1 locked by 20260617-205649-必読ファイルtimeoutをhard-fail化 (codex, 2026-06-17 20:56:49 +09:00)

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
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- template/00-entry/checks.md
  - Hello-world.md:155
  - Hello-world.md:168
  - Hello-world.md:177
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:23
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:93
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:75
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:213
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:23
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:110
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:168
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:169
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:174
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:175
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:216
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:240
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:241
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:244
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:247
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:24
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:26
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:171
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:225
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:36
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:38
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:70
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-210530-00-entry質問0terminal禁止をchecksへ反映.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 21:08:48 +09:00
- status: completed
- result: template/00-entry/checks.md のEntry ChecksとEntry Gate Decisionへ、first-turn terminal guardとinteraction_stateを追加した
- verified: checks.mdを全体書き直しで復旧、git diff --check、phase-orchestrator reviewで質問0deferがfailになること
- residual_risk: 実際の新規セッション応答がこのrunnerを経由しない場合、外側の接続修正が必要
- released_locks: 1
