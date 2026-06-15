# Work Card: review系メタスキルをrepo-local採用

- work_id: 20260615-231232-review系メタスキルをrepo-local採用
- registered_at: 2026-06-15 23:12:32 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

review-agent-essenceとreview-harnessをBiz-compilerのrepo-localメタスキルとして採用し、Claude前提やtrigger不足を軽く修正してregistry/ops READMEへ登録する

## Impact

knowledge/ops/skills配下の2Skill、registry、ops README、Hello-worldのRepo-local Skills一覧に効く。外部hook設定やグローバルSkillには触らない。

## Touched Files
- knowledge/ops/skills/review-agent-essence/SKILL.md
- knowledge/ops/skills/review-harness/SKILL.md
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
- knowledge/docs/decisions/: 背景理由の確認

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
  - Hello-world.md:168
  - Hello-world.md:171
  - Hello-world.md:270
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
  - Hello-world.md:168
  - Hello-world.md:170
  - Hello-world.md:172
  - Hello-world.md:183
  - Hello-world.md:188
  - Hello-world.md:190
  - Hello-world.md:192
  - Hello-world.md:218
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-231232-review系メタスキルをrepo-local採用.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 23:18:54 +09:00
- status: completed
- result: scopeを縮小し、review-agent-essence/review-harnessの明示発火description化とreview-harnessのOGP/SNS投稿フロー削除のみ実施
- verified: validate-repo-skillを2件実行、review-harness配下のOGP assets削除確認、git diff --check対象ファイル確認
- residual_risk: registry/ops README/Hello-worldへの正式登録は未実施。frontmatterのcontext/agent/modelは移植元のまま残している。
- released_locks: 5

