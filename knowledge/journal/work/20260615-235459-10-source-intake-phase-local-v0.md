# Work Card: 10-source-intake phase-local v0

- work_id: 20260615-235459-10-source-intake-phase-local-v0
- registered_at: 2026-06-15 23:54:59 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

数字phaseの本題として、10-source-intakeでsource inventory、観測事実、本人説明、未確認、provenanceを分けて20へ渡せる最小雛形を作る

## Impact

template/10-source-intake配下のphase-local README、contract、questions、checks、handoff、artifactsに効く。phase-catalog、phase-handoff、evidence-confidenceの既存方針に沿う。output業務フォルダ、IR schema、_shared runnerにはまだ触らない

## Touched Files
- template/10-source-intake/README.md
- template/10-source-intake/contract.md
- template/10-source-intake/questions.md
- template/10-source-intake/checks.md
- template/10-source-intake/handoff.md
- template/10-source-intake/artifacts/source-inventory.md
- template/10-source-intake/artifacts/intake-log.md
- template/10-source-intake/artifacts/fact-register.md
- template/phase-local-missing.md
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
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- orchestrator: knowledge-search (knowledge/ops/orchestrators/knowledge-search/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/docs/ir/: IR / schema / manifest / contract の設計
- knowledge/docs/meta/: メタ土台、配置判断、brief、完成条件
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- template/10-source-intake/README.md
  - AGENTS.md:92
  - AGENTS.md:118
  - AGENTS.md:119
  - AGENTS.md:120
  - AGENTS.md:122
  - AGENTS.md:124
  - AGENTS.md:146
  - AGENTS.md:230
  - AGENTS.md:243
  - AGENTS.md:310
  - COMPASS.md:96
  - Hello-world.md:58
  - Hello-world.md:67
  - Hello-world.md:145
  - Hello-world.md:147
  - Hello-world.md:150
  - Hello-world.md:151
  - Hello-world.md:173
  - Hello-world.md:175
  - Hello-world.md:177
  - Hello-world.md:188
  - Hello-world.md:193
  - Hello-world.md:195
  - Hello-world.md:197
  - Hello-world.md:223
  - ... truncated at 25 references
- template/10-source-intake/contract.md
  - template/phase-local-missing.md:12
- template/10-source-intake/questions.md
  - template/phase-local-missing.md:13
- template/10-source-intake/checks.md
  - template/phase-local-missing.md:15
- template/10-source-intake/handoff.md
  - template/phase-local-missing.md:16
- template/phase-local-missing.md
  - Hello-world.md:101
  - knowledge/docs/meta/completion-criteria.md:37
  - knowledge/docs/meta/README.md:28
  - knowledge/docs/meta/README.md:44
  - knowledge/docs/meta/README.md:50
  - knowledge/docs/meta/README.md:69
  - knowledge/ops/skills/knowledge-curation/SKILL.md:115
- Hello-world.md
  - AGENTS.md:3
  - AGENTS.md:15
  - AGENTS.md:60
  - AGENTS.md:76
  - AGENTS.md:105
  - AGENTS.md:109
  - AGENTS.md:147
  - AGENTS.md:169
  - AGENTS.md:173
  - AGENTS.md:180
  - AGENTS.md:181
  - AGENTS.md:243
  - COMPASS.md:7
  - COMPASS.md:89
  - Hello-world.md:45
  - Hello-world.md:71
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:44
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:71
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:29
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:25
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:8
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:8
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:16
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:20
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 23:58:05 +09:00
- status: completed
- result: template/10-source-intake にREADME、contract、questions、checks、handoff、artifacts/source-inventory、intake-log、fact-registerのv0雛形を作成し、phase-local-missingの10番台をv0作成済みに更新した
- verified: git diff --check; template/10-source-intake配下のファイル存在確認; README/handoff内容確認
- residual_risk: schema化、完了判定validator、phase runnerは今後の候補として残した
- released_locks: 10

