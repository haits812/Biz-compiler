# Work Card: empirical-prompt-tuningをrepo-local Skillへ追加

- work_id: 20260615-184153-empirical-prompt-tuningをrepo-local-skillへ追加
- registered_at: 2026-06-15 18:41:53 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

Skillやagent向け指示を白紙実行者で評価して直すrepo-local Skillを追加する

## Impact

repo-local Skill一覧、ops registry、ops README、Hello World生成器、GitHub反映に効く。既存のskill-creator-gateとは作成入口と修正評価入口で役割を分ける

## Touched Files
- knowledge/ops/skills/empirical-prompt-tuning/SKILL.md
- knowledge/ops/registry.md
- knowledge/ops/README.md
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1

## File Locks

Lock state: acquired

Active conflicts before registration:
- None

Other active locks at registration:

## Existing Ops To Check
- registry: knowledge/ops/registry.md
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
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口
- knowledge/docs/ir/: IR / schema / manifest / contract の設計

## Markdown Reference Impact

- knowledge/ops/skills/empirical-prompt-tuning/SKILL.md
  - AGENTS.md:89
  - AGENTS.md:95
  - AGENTS.md:98
  - AGENTS.md:119
  - AGENTS.md:149
  - Hello-world.md:154
  - Hello-world.md:157
  - Hello-world.md:158
  - Hello-world.md:160
  - Hello-world.md:162
  - Hello-world.md:166
  - Hello-world.md:170
  - Hello-world.md:172
  - Hello-world.md:174
  - Hello-world.md:175
  - Hello-world.md:176
  - Hello-world.md:179
  - Hello-world.md:215
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:14
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:27
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:30
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:16
  - knowledge/docs/decisions/2026-06-15-knowledge-curation-consolidates-pending-workflow.md:22
  - knowledge/docs/meta/artifact-placement.md:45
  - knowledge/docs/requirements/Biz-compiler_要求定義.md:62
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
  - Hello-world.md:166
  - Hello-world.md:169
  - Hello-world.md:265
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
  - Hello-world.md:166
  - Hello-world.md:168
  - Hello-world.md:170
  - Hello-world.md:180
  - Hello-world.md:185
  - Hello-world.md:187
  - Hello-world.md:189
  - Hello-world.md:215
  - ... truncated at 25 references
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - AGENTS.md:125
  - AGENTS.md:150
  - Hello-world.md:19
  - Hello-world.md:25
  - Hello-world.md:28
  - Hello-world.md:153
  - Hello-world.md:173
  - Hello-world.md:219
  - Hello-world.md:239
  - Hello-world.md:267
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:16
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:23
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:28
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:35
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:14
  - knowledge/docs/decisions/2026-06-14-hello-world-gate.md:38
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:8
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:23
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:30
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:31
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:24
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:43
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:25
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:194
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:363
  - ... truncated at 25 references

## Execution Assignment

- executor: codex
- subagent: 必要なら knowledge/docs/meta/subagent-brief.md に従って、タスク用仮ゴールを別で渡す

## Finish Gate
- git diff --check
- hello-world-gate.ps1 で Hello-world.md 同期、検査、commit/push
- knowledge/ops/registry.md と Hello-world.md のops entrypoint同期
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-184153-empirical-prompt-tuningをrepo-local-skillへ追加.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 18:47:00 +09:00
- status: completed
- result: mizchi/skillsのempirical-prompt-tuningをSKILL.md/SKILL-ja.mdともraw原文のままrepo-local Skillへ配置し、registry、ops README、hello-world-gateのOps Entrypoints生成リストを同期した
- verified: validate-repo-skill pass。raw sourceとのSHA256一致。hello-world-gate.ps1 parse ok。git diff --check pass
- residual_risk: 元SKILL.mdのdescriptionは明示呼び出し寄りで、自然発火語が少ない警告が出るが、今回は原文維持を優先して未改変
- released_locks: 4

