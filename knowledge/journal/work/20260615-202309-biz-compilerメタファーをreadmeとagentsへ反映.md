# Work Card: Biz-compilerメタファーをREADMEとAGENTSへ反映

- work_id: 20260615-202309-biz-compilerメタファーをreadmeとagentsへ反映
- registered_at: 2026-06-15 20:23:09 +09:00
- kind: docs
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

AI業務委託の契約・検収・稼働管理、およびAI人材派遣会社メタファーをREADME/AGENTSに会話補助として追加する

## Impact

READMEの人間向け説明、AGENTSのagent向け会話補助、MEMORYの未整理メモ掃除、Decisionの背景理由に効く。COMPASS/lexiconの正本語彙には入れない

## Touched Files
- README.md
- AGENTS.md
- MEMORY.md
- knowledge/docs/decisions/2026-06-15-ai-outsourcing-metaphor.md

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
- knowledge/docs/meta/: メタ土台、配置判断、brief、完成条件
- knowledge/docs/lexicon.md: 用語境界
- knowledge/docs/decisions/: 背景理由の確認

## Markdown Reference Impact

- README.md
  - AGENTS.md:70
  - AGENTS.md:96
  - AGENTS.md:97
  - AGENTS.md:98
  - AGENTS.md:100
  - AGENTS.md:102
  - AGENTS.md:124
  - AGENTS.md:208
  - AGENTS.md:221
  - AGENTS.md:288
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
- AGENTS.md
  - AGENTS.md:1
  - AGENTS.md:37
  - AGENTS.md:112
  - AGENTS.md:221
  - AGENTS.md:227
  - Hello-world.md:44
  - Hello-world.md:70
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:43
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:18
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:39
  - knowledge/docs/decisions/2026-06-14-soul-user-context.md:14
  - knowledge/docs/decisions/2026-06-14-soul-user-context.md:18
  - knowledge/docs/decisions/2026-06-15-lexicon-initial-read-order.md:18
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:24
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:26
  - knowledge/docs/decisions/2026-06-15-requirements-conditional-read-order.md:16
  - knowledge/docs/meta/artifact-placement.md:60
  - knowledge/docs/meta/README.md:35
  - knowledge/docs/meta/README.md:36
  - knowledge/docs/meta/README.md:40
  - knowledge/docs/meta/README.md:41
  - knowledge/docs/meta/README.md:42
  - knowledge/docs/meta/README.md:43
  - ... truncated at 25 references
- MEMORY.md
  - AGENTS.md:3
  - AGENTS.md:43
  - AGENTS.md:60
  - AGENTS.md:66
  - AGENTS.md:83
  - AGENTS.md:216
  - AGENTS.md:221
  - AGENTS.md:227
  - AGENTS.md:235
  - AGENTS.md:239
  - AGENTS.md:245
  - AGENTS.md:256
  - AGENTS.md:289
  - COMPASS.md:94
  - Hello-world.md:50
  - Hello-world.md:73
  - knowledge/.index/README.md:5
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:49
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:76
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:12
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:20
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:29
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:32
  - knowledge/docs/decisions/2026-06-14-immediate-memory-capture.md:14
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-202309-biz-compilerメタファーをreadmeとagentsへ反映.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 20:26:43 +09:00
- status: completed
- result: AI業務委託の契約・検収・稼働管理、およびAI人材派遣会社メタファーをREADME/AGENTSへ反映し、Decisionへ採用理由を残し、MEMORYの未整理メモを掃除した
- verified: git diff --checkを確認済み。README/AGENTS/MEMORY/Decisionの反映をrgで確認済み
- residual_risk: 比喩は会話補助であり、phase/IRの実装判断ではcontract/manifest/gate/executor/ledger/validationへ戻す必要がある
- released_locks: 4

