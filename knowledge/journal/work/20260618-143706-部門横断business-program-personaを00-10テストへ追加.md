# Work Card: 部門横断business_program personaを00-10テストへ追加

- work_id: 20260618-143706-部門横断business-program-personaを00-10テストへ追加
- registered_at: 2026-06-18 14:37:06 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

20実装前に、大きめの新規事業/部門横断依頼が00-10でbusiness_programとしてrouteされる回帰パターンを追加する

## Impact

template/_shared/evaluationのpersona matrix、persona index、00-10 smoke runnerに影響。00/10 phase contract自体の意味は変えず、既存route検査を強化する。

## Touched Files
- template/_shared/evaluation/persona-test-matrix.md
- template/_shared/evaluation/personas/README.md
- template/_shared/evaluation/personas/39-cross-functional-business-program/persona.md
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
- knowledge/docs/ir/: IR / schema / manifest / contract の設計
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

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
- template/_shared/evaluation/personas/README.md
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
- template/_shared/evaluation/personas/39-cross-functional-business-program/persona.md
  - Hello-world.md:114
  - Hello-world.md:115
  - Hello-world.md:116
  - Hello-world.md:117
  - Hello-world.md:118
  - Hello-world.md:119
  - Hello-world.md:120
  - Hello-world.md:121
  - Hello-world.md:122
  - Hello-world.md:123
  - Hello-world.md:124
  - Hello-world.md:125
  - Hello-world.md:126
  - Hello-world.md:127
  - Hello-world.md:128
  - Hello-world.md:129
  - Hello-world.md:130
  - Hello-world.md:131
  - Hello-world.md:132
  - Hello-world.md:133
  - Hello-world.md:134
  - Hello-world.md:135
  - Hello-world.md:136
  - Hello-world.md:137
  - Hello-world.md:138
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
  - knowledge/journal/work/20260618-122156-00-10-entry-route-for-new-work-and-business-prog.md:30
  - knowledge/journal/work/20260618-122156-00-10-entry-route-for-new-work-and-business-prog.md:335
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260618-143706-部門横断business-program-personaを00-10テストへ追加.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-18 14:51:49 +09:00
- status: completed
- result: 部門横断新規事業プログラムpersona 39を追加し、00-10 smoke runnerで00/10 handoffのroute fieldsを検査するようにした。
- verified: PowerShell parse ok、control character scan ok、00-10 persona smoke 39/39 passed、10-source-intake regression 6/6 passed。p39 handoffは new_work / business_program / multi_executor_team / business_design_candidate を確認。
- residual_risk: Hello-world-gateはdirty worktree全体をgit add/commitするため未実行。Hello-world.mdのKnown template assets再生成は別途、commit対象を整理してから行う。
- released_locks: 4
