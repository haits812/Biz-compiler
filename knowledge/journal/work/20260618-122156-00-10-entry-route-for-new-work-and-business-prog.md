# Work Card: 00-10 entry route for new work and business program

- work_id: 20260618-122156-00-10-entry-route-for-new-work-and-business-prog
- registered_at: 2026-06-18 12:21:56 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

00-entryで既存業務/新規業務に加えて個別業務・新運用・新規事業プログラムの粒度と代理伝聞姿勢を切り、10から20へreadinessとして渡せるようにする

## Impact

00-entry contract/questions/checks/handoff/reviewer、10-source-intake contract/checks/handoff/reviewer、00-10 persona smoke runner/evaluation expectationsに影響。IPC/settings/securityは影響なし。

## Touched Files
- template/00-entry/contract.md
- template/00-entry/questions.md
- template/00-entry/checks.md
- template/00-entry/handoff.md
- template/00-entry/phase-orchestrator.ps1
- template/10-source-intake/contract.md
- template/10-source-intake/checks.md
- template/10-source-intake/handoff.md
- template/10-source-intake/phase-orchestrator.ps1
- template/_shared/evaluation/persona-test-matrix.md
- template/_shared/internal/runner/replay/run-00-10-persona-smoke.ps1

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
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口
- knowledge/docs/ir/: IR / schema / manifest / contract の設計
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- template/00-entry/contract.md
  - Hello-world.md:169
  - Hello-world.md:178
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:21
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:89
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:76
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:219
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:231
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:234
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:232
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:235
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:250
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:253
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:22
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:83
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:99
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:102
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:136
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:137
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:142
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:143
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:154
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:155
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:160
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:161
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:166
  - ... truncated at 25 references
- template/00-entry/questions.md
  - Hello-world.md:172
  - Hello-world.md:180
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:22
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:91
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:180
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:186
  - knowledge/journal/work/20260617-161503-entry-gate-regression-rules-and-upfront-flow-fix.md:487
  - knowledge/journal/work/20260617-161503-entry-gate-regression-rules-and-upfront-flow-fix.md:493
  - knowledge/journal/work/20260617-164626-clarify-rework-as-non-terminal-entry-loop.md:531
  - knowledge/journal/work/20260617-164626-clarify-rework-as-non-terminal-entry-loop.md:534
  - knowledge/journal/work/20260617-164626-clarify-rework-as-non-terminal-entry-loop.md:555
  - knowledge/journal/work/20260617-164626-clarify-rework-as-non-terminal-entry-loop.md:558
  - knowledge/journal/work/20260617-180337-00-10-handoff-schema整合.md:760
  - knowledge/journal/work/20260617-180337-00-10-handoff-schema整合.md:763
  - knowledge/journal/work/20260617-180337-00-10-handoff-schema整合.md:766
  - knowledge/journal/work/20260617-180337-00-10-handoff-schema整合.md:769
  - knowledge/journal/work/20260617-182851-00-entryヒアリング前提表現の調整.md:448
  - knowledge/journal/work/20260617-182851-00-entryヒアリング前提表現の調整.md:451
  - knowledge/journal/work/20260617-182851-00-entryヒアリング前提表現の調整.md:472
  - knowledge/journal/work/20260617-182851-00-entryヒアリング前提表現の調整.md:475
  - knowledge/journal/work/20260617-185101-00-entry-subagent-brief-dispatch化.md:473
  - knowledge/journal/work/20260617-185101-00-entry-subagent-brief-dispatch化.md:476
  - knowledge/journal/work/20260617-185101-00-entry-subagent-brief-dispatch化.md:497
  - knowledge/journal/work/20260617-185101-00-entry-subagent-brief-dispatch化.md:500
  - knowledge/journal/work/20260617-214623-00-entry完成度98-へ向けたgateとtest整備.md:21
  - ... truncated at 25 references
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
- template/00-entry/handoff.md
  - Hello-world.md:170
  - Hello-world.md:179
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:24
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:95
  - knowledge/journal/work/20260617-021127-matt-pocock-skillsのphase対応をmemoryへ保存.md:433
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:23
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:77
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:81
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:149
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:150
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:155
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:156
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:161
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:162
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:191
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:197
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:203
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:209
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:227
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:228
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:233
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:21
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:68
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:71
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:107
  - ... truncated at 25 references
- template/00-entry/phase-orchestrator.ps1
  - Hello-world.md:171
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:20
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:172
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:175
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:214
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:17
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:20
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:56
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:493
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:494
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:495
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:496
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:497
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:498
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:499
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:500
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:501
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:502
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:503
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:504
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:505
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:506
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:507
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:508
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:509
  - ... truncated at 25 references
- template/10-source-intake/contract.md
  - Hello-world.md:169
  - Hello-world.md:178
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:21
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:89
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:76
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:219
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:231
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:234
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:232
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:235
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:250
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:253
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:22
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:83
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:99
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:102
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:136
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:137
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:142
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:143
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:154
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:155
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:160
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:161
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:166
  - ... truncated at 25 references
- template/10-source-intake/checks.md
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
- template/10-source-intake/handoff.md
  - Hello-world.md:170
  - Hello-world.md:179
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:24
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:95
  - knowledge/journal/work/20260617-021127-matt-pocock-skillsのphase対応をmemoryへ保存.md:433
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:23
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:77
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:81
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:149
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:150
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:155
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:156
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:161
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:162
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:191
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:197
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:203
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:209
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:227
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:228
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:233
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:21
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:68
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:71
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:107
  - ... truncated at 25 references
- template/10-source-intake/phase-orchestrator.ps1
  - Hello-world.md:171
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:20
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:172
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:175
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:214
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:17
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:20
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:56
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:493
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:494
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:495
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:496
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:497
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:498
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:499
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:500
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:501
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:502
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:503
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:504
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:505
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:506
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:507
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:508
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:509
  - ... truncated at 25 references
- template/_shared/evaluation/persona-test-matrix.md
  - Hello-world.md:113
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
- template/_shared/internal/runner/replay/run-00-10-persona-smoke.ps1
  - knowledge/journal/work/20260617-231012-00-10-persona-smoke-runner.md:20
  - knowledge/journal/work/20260617-231012-00-10-persona-smoke-runner.md:176
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:29
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:307
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:694
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:700
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:701
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:702
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:703
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:711
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:719
  - knowledge/journal/work/20260618-103146-10-source-intake自然会話品質98点化.md:761
  - template/_shared/evaluation/README.md:45

## Execution Assignment

- executor: codex
- subagent: 必要なら knowledge/docs/meta/subagent-brief.md に従って、タスク用仮ゴールを別で渡す

## Finish Gate
- git diff --check
- hello-world-gate.ps1 で Hello-world.md 同期、検査、commit/push
- 対象PowerShellのスモークテスト
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260618-122156-00-10-entry-route-for-new-work-and-business-prog.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-18 12:57:29 +09:00
- status: completed
- result: 00/10 route dimensions for existing_work/new_work/business_program were added to phase contracts, handoff validation, docs, and replay fixtures.
- verified: PowerShell parser OK; control character scan OK; git diff --check OK except existing CRLF warnings; 00-10 persona smoke 38/38 passed; 10-source-intake regression 6/6 passed.
- residual_risk: 20-decompose implementation still needs to consume 20_readiness/business_design_candidate explicitly; verification-gate Node harness is not present in this repo.
- released_locks: 11
