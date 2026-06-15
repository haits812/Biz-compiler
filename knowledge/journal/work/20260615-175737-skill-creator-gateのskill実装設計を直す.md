# Work Card: skill-creator-gateのSkill実装設計を直す

- work_id: 20260615-175737-skill-creator-gateのskill実装設計を直す
- registered_at: 2026-06-15 17:57:37 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

ユーザーのやりたいことを起点に、どの部分をSkill化すべきか整理し、多工程Skillを実装できるcreator/gateとしてskill-creator-gateを直す

## Impact

repo-local Skill作成の入口、既存ops registry、Hello WorldのSkill説明、AGENTSのSkill作成ルールに効く。OpenSquilla runtimeは導入せず、標準skill-creatorの実装作法を下位部品として扱う。

## Touched Files
- AGENTS.md
- Hello-world.md
- knowledge/ops/registry.md
- knowledge/ops/README.md
- knowledge/ops/skills/skill-creator-gate/SKILL.md

## File Locks

Lock state: acquired

Active conflicts before registration:
- None

Other active locks at registration:

## Existing Ops To Check
- registry: knowledge/ops/registry.md
- skill: hello-world-gate (knowledge/ops/skills/hello-world-gate/)
- skill: knowledge-curation (knowledge/ops/skills/knowledge-curation/)
- skill: skill-creator-gate (knowledge/ops/skills/skill-creator-gate/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- orchestrator: knowledge-search (knowledge/ops/orchestrators/knowledge-search/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口

## Markdown Reference Impact

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
- Hello-world.md
  - AGENTS.md:3
  - AGENTS.md:38
  - AGENTS.md:54
  - AGENTS.md:83
  - AGENTS.md:87
  - AGENTS.md:125
  - AGENTS.md:147
  - AGENTS.md:151
  - AGENTS.md:158
  - AGENTS.md:159
  - AGENTS.md:221
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
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:21
  - ... truncated at 25 references
- knowledge/ops/registry.md
  - AGENTS.md:87
  - AGENTS.md:91
  - AGENTS.md:102
  - AGENTS.md:112
  - AGENTS.md:121
  - AGENTS.md:156
  - AGENTS.md:208
  - Hello-world.md:58
  - Hello-world.md:152
  - Hello-world.md:164
  - Hello-world.md:167
  - Hello-world.md:257
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
  - Hello-world.md:164
  - Hello-world.md:166
  - Hello-world.md:168
  - Hello-world.md:176
  - Hello-world.md:181
  - Hello-world.md:183
  - Hello-world.md:185
  - Hello-world.md:211
  - ... truncated at 25 references
- knowledge/ops/skills/skill-creator-gate/SKILL.md
  - AGENTS.md:89
  - AGENTS.md:95
  - AGENTS.md:98
  - AGENTS.md:119
  - AGENTS.md:149
  - Hello-world.md:154
  - Hello-world.md:157
  - Hello-world.md:159
  - Hello-world.md:164
  - Hello-world.md:168
  - Hello-world.md:170
  - Hello-world.md:172
  - Hello-world.md:173
  - Hello-world.md:211
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:14
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:27
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:30
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:16
  - knowledge/docs/decisions/2026-06-15-knowledge-curation-consolidates-pending-workflow.md:22
  - knowledge/docs/meta/artifact-placement.md:45
  - knowledge/docs/requirements/Biz-compiler_要求定義.md:62
  - knowledge/docs/requirements/Biz-compiler_要求定義.md:237
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:26
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:221
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:235
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-175737-skill-creator-gateのskill実装設計を直す.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 18:03:29 +09:00
- status: completed
- result: skill-creator-gateを、gateの役割は維持したまま、ユーザーのやりたいことからSkill化対象を整理し、多工程Skillを標準skill-creator作法で実装する入口として更新した。AGENTS、ops registry、ops READMEも同期した。
- verified: validate-repo-skill.ps1 -SkillName skill-creator-gate と git diff --check が通過。0ベース表現はSkill creator文脈から削除済み。
- residual_risk: OpenSquilla runtimeやMetaSkill形式は導入していない。今後の実作成で不足があればskill-creator-gateを追加改善する。
- released_locks: 5

