# Work Card: upfront existing material test fixtures

- work_id: 20260617-162137-upfront-existing-material-test-fixtures
- registered_at: 2026-06-17 16:21:37 +09:00
- kind: template
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

00-entryの初手資料持ち込みペルソナ31-35で使う既存フロー/手順書/Excel風fixtureを作る

## Impact

template/_shared/evaluationの回帰テスト材料に効く。00-entryの判定ロジック自体は変えず、後続テストで回答側personaに渡せる疑似資料を追加する

## Touched Files
- template/_shared/evaluation/README.md
- template/_shared/evaluation/persona-test-matrix.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/README.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p31-onboarding-flow.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p32-invoice-payment-procedure.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-register.csv
- template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-notes.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p34-cs-refund-complaint-manual.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p35-order-processing-flow-proxy.md

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
  - COMPASS.md:102
  - Hello-world.md:58
  - Hello-world.md:69
  - Hello-world.md:103
  - Hello-world.md:109
  - Hello-world.md:121
  - Hello-world.md:129
  - Hello-world.md:175
  - Hello-world.md:178
  - Hello-world.md:180
  - Hello-world.md:183
  - Hello-world.md:184
  - Hello-world.md:206
  - Hello-world.md:208
  - ... truncated at 25 references
- template/_shared/evaluation/persona-test-matrix.md
  - Hello-world.md:102
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:20
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:114
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:117
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:144
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:155
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:20
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:22
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:56
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:58
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:59
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:60
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:61
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:62
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:91
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:93
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:94
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:95
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:96
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:97
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:159
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:200
  - knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md:21
  - knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md:81
  - knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md:83
  - ... truncated at 25 references
- template/_shared/evaluation/fixtures/upfront-existing-materials/README.md
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
  - COMPASS.md:102
  - Hello-world.md:58
  - Hello-world.md:69
  - Hello-world.md:103
  - Hello-world.md:109
  - Hello-world.md:121
  - Hello-world.md:129
  - Hello-world.md:175
  - Hello-world.md:178
  - Hello-world.md:180
  - Hello-world.md:183
  - Hello-world.md:184
  - Hello-world.md:206
  - Hello-world.md:208
  - ... truncated at 25 references

## Code Impact Candidates

- Warning: code-impact query failed. Work card creation continues.
- Exit code: 2
- Rebuild: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 rebuild`
- Retry: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query -Files "template/_shared/evaluation/README.md;template/_shared/evaluation/persona-test-matrix.md;template/_shared/evaluation/fixtures/upfront-existing-materials/README.md;template/_shared/evaluation/fixtures/upfront-existing-materials/p31-onboarding-flow.md;template/_shared/evaluation/fixtures/upfront-existing-materials/p32-invoice-payment-procedure.md;template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-register.csv;template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-notes.md;template/_shared/evaluation/fixtures/upfront-existing-materials/p34-cs-refund-complaint-manual.md;template/_shared/evaluation/fixtures/upfront-existing-materials/p35-order-processing-flow-proxy.md" -Depth 2 -Format markdown`

```text
code-impact: target file(s) not indexed: template/_shared/evaluation/fixtures/upfront-existing-materials/README.md, template/_shared/evaluation/fixtures/upfront-existing-materials/p31-onboarding-flow.md, template/_shared/evaluation/fixtures/upfront-existing-materials/p32-invoice-payment-procedure.md, template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-register.csv, template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-notes.md, template/_shared/evaluation/fixtures/upfront-existing-materials/p34-cs-refund-complaint-manual.md, template/_shared/evaluation/fixtures/upfront-existing-materials/p35-order-processing-flow-proxy.md
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-162137-upfront-existing-material-test-fixtures.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 16:29:31 +09:00
- status: completed
- result: template/_shared/evaluation/fixtures/upfront-existing-materials/ にpersona31-35向けの既存フロー/手順書/Excel風台帳/古いマニュアル/代理フローfixtureを追加し、評価READMEとpersona matrixから参照できるようにした。追加fixtureを使って31-35のpaired subagent testを実施。
- verified: rgでfixture参照とp31-p35の反映を確認。paired subagent testで31-34はdefer、35はrework。git diff --checkはCRLF/LF警告のみ。code-impact rebuild/status成功、stale no。
- residual_risk: Hello-world.mdのKnown template assetsは今回未同期。hello-world-gateはcommit/pushまで進む設計のため、ユーザーのcommit/push依頼なしでは未実行。
- released_locks: 9

