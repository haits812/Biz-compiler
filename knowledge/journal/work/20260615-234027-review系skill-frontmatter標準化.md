# Work Card: review系Skill frontmatter標準化

- work_id: 20260615-234027-review系skill-frontmatter標準化
- registered_at: 2026-06-15 23:40:27 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

review-agent-essence と review-harness のfrontmatterをrepo-local Skill標準へ合わせる

## Impact

repo-local Skillのfrontmatter読み取り、skill-creator-gate作成ルール、将来のSkill一覧生成に効く。本文の挙動は変えない

## Touched Files
- knowledge/ops/skills/review-agent-essence/SKILL.md
- knowledge/ops/skills/review-harness/SKILL.md

## File Locks

Lock state: acquired

Active conflicts before registration:
- None

Other active locks at registration:
- Hello-world.md locked by 20260615-233938-review系repo-local-skillの正式同期 (codex, 2026-06-15 23:39:38 +09:00)
- knowledge/ops/README.md locked by 20260615-233938-review系repo-local-skillの正式同期 (codex, 2026-06-15 23:39:38 +09:00)
- knowledge/ops/registry.md locked by 20260615-233938-review系repo-local-skillの正式同期 (codex, 2026-06-15 23:39:38 +09:00)

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
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口

## Markdown Reference Impact

- knowledge/ops/skills/review-agent-essence/SKILL.md
  - AGENTS.md:111
  - AGENTS.md:117
  - AGENTS.md:120
  - AGENTS.md:141
  - AGENTS.md:171
  - Hello-world.md:154
  - Hello-world.md:156
  - Hello-world.md:159
  - Hello-world.md:160
  - Hello-world.md:162
  - Hello-world.md:164
  - Hello-world.md:168
  - Hello-world.md:172
  - Hello-world.md:174
  - Hello-world.md:176
  - Hello-world.md:177
  - Hello-world.md:178
  - Hello-world.md:179
  - Hello-world.md:182
  - Hello-world.md:218
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:14
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:27
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:30
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:16
  - knowledge/docs/decisions/2026-06-15-knowledge-curation-consolidates-pending-workflow.md:22
  - ... truncated at 25 references
- knowledge/ops/skills/review-harness/SKILL.md
  - AGENTS.md:111
  - AGENTS.md:117
  - AGENTS.md:120
  - AGENTS.md:141
  - AGENTS.md:171
  - Hello-world.md:154
  - Hello-world.md:156
  - Hello-world.md:159
  - Hello-world.md:160
  - Hello-world.md:162
  - Hello-world.md:164
  - Hello-world.md:168
  - Hello-world.md:172
  - Hello-world.md:174
  - Hello-world.md:176
  - Hello-world.md:177
  - Hello-world.md:178
  - Hello-world.md:179
  - Hello-world.md:182
  - Hello-world.md:218
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:14
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:27
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:30
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:16
  - knowledge/docs/decisions/2026-06-15-knowledge-curation-consolidates-pending-workflow.md:22
  - ... truncated at 25 references

## Execution Assignment

- executor: codex
- subagent: 必要なら knowledge/docs/meta/subagent-brief.md に従って、タスク用仮ゴールを別で渡す

## Finish Gate
- git diff --check
- hello-world-gate.ps1 で Hello-world.md 同期、検査、commit/push
- knowledge/ops/registry.md と Hello-world.md のops entrypoint同期
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-234027-review系skill-frontmatter標準化.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 23:42:10 +09:00
- status: completed
- result: review-agent-essence と review-harness のfrontmatterをrepo-local Skill標準の name / description のみに統一した
- verified: validate-repo-skill.ps1 -SkillName review-agent-essence; validate-repo-skill.ps1 -SkillName review-harness
- residual_risk: validatorはfrontmatter追加フィールドを直接警告しないため、今後必要ならvalidator側へ検査を追加する
- released_locks: 2

