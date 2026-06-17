# Work Card: 00-entry persona test matrix

- work_id: 20260617-115131-00-entry-persona-test-matrix
- registered_at: 2026-06-17 11:51:31 +09:00
- kind: template
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

00-entry再テスト用の30ペルソナ一覧をphase-local contextとして保存する

## Impact

template/00-entry/_contextに効く。00-entryの経験的テスト、subagentシミュレーション、gate-rubric検証に使うfixtureを追加する。template直下の構成やops資産には効かないが、Hello-worldのtemplate asset一覧は同期対象

## Touched Files
- template/00-entry/_context/persona-test-matrix.md
- template/00-entry/_context/README.md
- Hello-world.md

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
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- template/00-entry/_context/README.md
  - AGENTS.md:96
  - AGENTS.md:122
  - AGENTS.md:123
  - AGENTS.md:124
  - AGENTS.md:126
  - AGENTS.md:128
  - AGENTS.md:150
  - AGENTS.md:234
  - AGENTS.md:247
  - AGENTS.md:314
  - COMPASS.md:18
  - COMPASS.md:96
  - Hello-world.md:58
  - Hello-world.md:69
  - Hello-world.md:107
  - Hello-world.md:119
  - Hello-world.md:127
  - Hello-world.md:173
  - Hello-world.md:176
  - Hello-world.md:178
  - Hello-world.md:181
  - Hello-world.md:182
  - Hello-world.md:204
  - Hello-world.md:206
  - Hello-world.md:208
  - ... truncated at 25 references
- Hello-world.md
  - AGENTS.md:3
  - AGENTS.md:15
  - AGENTS.md:64
  - AGENTS.md:80
  - AGENTS.md:109
  - AGENTS.md:113
  - AGENTS.md:151
  - AGENTS.md:173
  - AGENTS.md:177
  - AGENTS.md:184
  - AGENTS.md:185
  - AGENTS.md:247
  - COMPASS.md:18
  - Hello-world.md:45
  - Hello-world.md:73
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:44
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:71
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:29
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:25
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:8
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:8
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:16
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:20
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:21
  - ... truncated at 25 references

## Code Impact Candidates

- Warning: code-impact query failed. Work card creation continues.
- Exit code: 2
- Rebuild: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 rebuild`
- Retry: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query -Files "template/00-entry/_context/persona-test-matrix.md;template/00-entry/_context/README.md;Hello-world.md" -Depth 2 -Format markdown`

```text
code-impact: target file(s) not indexed: template/00-entry/_context/persona-test-matrix.md
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 11:55:50 +09:00
- status: completed
- result: 00-entry再テスト用の30 persona fixtureをtemplate/00-entry/_context/persona-test-matrix.mdとして追加し、_context/README.mdとHello-world.mdへ導線を同期
- verified: Get-Content確認、persona-test-matrix trailing whitespace確認、git diff --check、Hello-world.md asset反映確認、code-impact rebuild/status
- residual_risk: hello-world-gate本体はcommitを作るため未実行。Hello-world.mdは生成関数を使ってcommitなしで同期
- released_locks: 3

