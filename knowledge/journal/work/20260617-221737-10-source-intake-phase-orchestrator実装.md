# Work Card: 10-source-intake phase orchestrator実装

- work_id: 20260617-221737-10-source-intake-phase-orchestrator実装
- registered_at: 2026-06-17 22:17:37 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

10-source-intakeにrepo-local dispatch/review実行入口を追加し、source intakeの完了判定を機械的に落とせるようにする

## Impact

template/10-source-intakeのphase実行、00->10->20 handoff、source/provenance/confidence検査

## Touched Files
- template/10-source-intake/phase-orchestrator.ps1
- template/10-source-intake/_context/dispatch-packet.md
- template/10-source-intake/_context/dispatch-checks.md
- template/10-source-intake/README.md
- template/10-source-intake/checks.md
- template/10-source-intake/contract.md
- template/10-source-intake/handoff.md

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
- template/10-source-intake/_context/dispatch-packet.md
  - Hello-world.md:156
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:21
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:200
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:203
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:21
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:84
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:99
  - knowledge/journal/work/20260617-210530-00-entry質問0terminal禁止をchecksへ反映.md:32
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:22
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:99
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:103
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:153
  - knowledge/journal/work/20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動.md:20
  - knowledge/journal/work/20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動.md:56
  - knowledge/journal/work/20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動.md:87
  - template/00-entry/_context/dispatch-checks.md:3
  - template/00-entry/_context/README.md:9
  - template/00-entry/_context/README.md:13
  - template/00-entry/README.md:60
  - template/phase-local-missing.md:42
- template/10-source-intake/_context/dispatch-checks.md
  - Hello-world.md:155
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:22
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:200
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:203
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:22
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:89
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:94
  - knowledge/journal/work/20260617-210530-00-entry質問0terminal禁止をchecksへ反映.md:31
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:21
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:90
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:112
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:153
  - knowledge/journal/work/20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動.md:21
  - knowledge/journal/work/20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動.md:69
  - knowledge/journal/work/20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動.md:74
  - template/00-entry/_context/dispatch-packet.md:11
  - template/00-entry/_context/README.md:23
  - template/00-entry/README.md:61
  - template/phase-local-missing.md:43
- template/10-source-intake/README.md
  - AGENTS.md:101
  - AGENTS.md:141
  - AGENTS.md:142
  - AGENTS.md:143
  - AGENTS.md:145
  - AGENTS.md:147
  - AGENTS.md:169
  - AGENTS.md:253
  - AGENTS.md:266
  - AGENTS.md:333
  - COMPASS.md:18
  - COMPASS.md:102
  - Hello-world.md:58
  - Hello-world.md:69
  - Hello-world.md:112
  - Hello-world.md:152
  - Hello-world.md:153
  - Hello-world.md:161
  - Hello-world.md:173
  - Hello-world.md:181
  - Hello-world.md:227
  - Hello-world.md:230
  - Hello-world.md:232
  - Hello-world.md:235
  - Hello-world.md:236
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-221737-10-source-intake-phase-orchestrator実装.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 22:27:13 +09:00
- status: completed
- result: 10-source-intakeにdispatch packet、dispatch checks、phase-orchestrator.ps1を追加し、README/checks/contract/handoffをreviewer契約へ同期した
- verified: PowerShell parser parse-ok、phase-orchestrator start -NoWrite、status、review代表5ケース、git diff --checkを確認した
- residual_risk: CRLF正規化warningのみ。deterministic reviewは保守的で、実source内容の妥当性そのものはcompletion reviewer/main判断が必要
- released_locks: 7
