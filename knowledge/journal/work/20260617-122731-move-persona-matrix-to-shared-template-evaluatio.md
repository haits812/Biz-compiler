# Work Card: Move persona matrix to shared template evaluation

- work_id: 20260617-122731-move-persona-matrix-to-shared-template-evaluatio
- registered_at: 2026-06-17 12:27:31 +09:00
- kind: template
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

30ペルソナfixtureを00-entry専用からphase横断のshared evaluation資産へ移す

## Impact

template/_shared/evaluationにphase横断の再テストfixtureを追加し、template/00-entry/_contextから専用配置を外す。Hello-worldのtemplate asset一覧にも効く。既存00-entryルール本文には効かない

## Touched Files
- template/00-entry/_context/persona-test-matrix.md
- template/00-entry/_context/README.md
- template/_shared/evaluation/persona-test-matrix.md
- template/_shared/evaluation/README.md
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

- template/00-entry/_context/persona-test-matrix.md
  - Hello-world.md:106
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:20
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:114
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:117
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:144
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:155
  - template/00-entry/_context/README.md:22
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
  - Hello-world.md:108
  - Hello-world.md:120
  - Hello-world.md:128
  - Hello-world.md:174
  - Hello-world.md:177
  - Hello-world.md:179
  - Hello-world.md:182
  - Hello-world.md:183
  - Hello-world.md:205
  - Hello-world.md:207
  - Hello-world.md:209
  - ... truncated at 25 references
- template/_shared/evaluation/persona-test-matrix.md
  - Hello-world.md:106
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:20
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:114
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:117
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:144
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:155
  - template/00-entry/_context/README.md:22
- template/_shared/evaluation/README.md
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
  - Hello-world.md:108
  - Hello-world.md:120
  - Hello-world.md:128
  - Hello-world.md:174
  - Hello-world.md:177
  - Hello-world.md:179
  - Hello-world.md:182
  - Hello-world.md:183
  - Hello-world.md:205
  - Hello-world.md:207
  - Hello-world.md:209
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
- Retry: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query -Files "template/00-entry/_context/persona-test-matrix.md;template/00-entry/_context/README.md;template/_shared/evaluation/persona-test-matrix.md;template/_shared/evaluation/README.md;Hello-world.md" -Depth 2 -Format markdown`

```text
code-impact: target file(s) not indexed: template/_shared/evaluation/README.md
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 12:30:18 +09:00
- status: completed
- result: 30 persona fixtureを00-entry専用からtemplate/_shared/evaluation/persona-test-matrix.mdへ移動し、shared evaluation README、00-entry context README、Hello-world asset一覧を同期
- verified: 旧00-entry側パス削除、新shared側パス存在、Hello-world asset反映、rg確認、git diff --check、code-impact rebuild/status
- residual_risk: template/_shared/evaluationはphase横断fixture置き場として新設。後で他phaseのテスト手順ができたらREADMEに追記が必要
- released_locks: 5

