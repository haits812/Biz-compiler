# Work Card: empirical-prompt-tuning発火条件整理

- work_id: 20260615-234715-empirical-prompt-tuning発火条件整理
- registered_at: 2026-06-15 23:47:15 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

skills棚卸しの1件目として empirical-prompt-tuning を明示起動専用に揃え、validate-repo-skill警告を消す

## Impact

repo-local Skillのfrontmatter description、ops owner docs、registry説明、Hello-world.mdのSkill一覧に効く。Skill本文の評価手順やtemplate/outputには影響しない

## Touched Files
- knowledge/ops/skills/empirical-prompt-tuning/SKILL.md
- knowledge/ops/skills/empirical-prompt-tuning/SKILL-ja.md
- knowledge/ops/registry.md
- knowledge/ops/README.md
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
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口
- knowledge/docs/ir/: IR / schema / manifest / contract の設計
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- knowledge/ops/skills/empirical-prompt-tuning/SKILL.md
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
  - Hello-world.md:165
  - Hello-world.md:167
  - Hello-world.md:169
  - Hello-world.md:173
  - Hello-world.md:177
  - Hello-world.md:179
  - Hello-world.md:181
  - Hello-world.md:182
  - Hello-world.md:183
  - Hello-world.md:184
  - Hello-world.md:187
  - Hello-world.md:223
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:14
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:27
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:30
  - ... truncated at 25 references
- knowledge/ops/skills/empirical-prompt-tuning/SKILL-ja.md
  - Hello-world.md:153
  - knowledge/journal/work/20260615-184153-empirical-prompt-tuningをrepo-local-skillへ追加.md:199
  - knowledge/ops/README.md:88
- knowledge/ops/registry.md
  - AGENTS.md:109
  - AGENTS.md:113
  - AGENTS.md:124
  - AGENTS.md:134
  - AGENTS.md:143
  - AGENTS.md:178
  - AGENTS.md:230
  - Hello-world.md:58
  - Hello-world.md:152
  - Hello-world.md:173
  - Hello-world.md:176
  - Hello-world.md:279
  - knowledge/docs/decisions/2026-06-15-mergegate-hooks-lock-completion.md:9
  - knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md:17
  - knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md:27
  - knowledge/docs/meta/artifact-placement.md:46
  - knowledge/docs/meta/artifact-placement.md:60
  - knowledge/docs/meta/README.md:36
  - knowledge/docs/meta/README.md:41
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:20
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:25
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:33
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:44
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:27
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:43
  - ... truncated at 25 references
- knowledge/ops/README.md
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-234715-empirical-prompt-tuning発火条件整理.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 23:48:18 +09:00
- status: completed
- result: empirical-prompt-tuningのSKILL.md/SKILL-ja.md descriptionとops導線を明示起動専用に揃えた
- verified: validate-repo-skill.ps1 -SkillName empirical-prompt-tuning; git diff --check
- residual_risk: 本文は移植元ベースを維持しており、dispatch unavailable時の運用は今後の実利用で確認する
- released_locks: 5

