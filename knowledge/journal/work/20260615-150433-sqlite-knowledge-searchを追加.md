# Work Card: SQLite knowledge searchを追加

- work_id: 20260615-150433-sqlite-knowledge-searchを追加
- registered_at: 2026-06-15 15:04:33 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

Markdown正本をSQLite FTS5へindexし、過去会話・作業メモ・決定・設定を検索できるrepo-local orchestratorを追加する

## Impact

knowledge/.index生成物、knowledge/ops registry、Hello-worldのops asset、AGENTSの運用ルール、検索導線に影響

## Touched Files
- AGENTS.md
- Hello-world.md
- knowledge/ops/registry.md
- knowledge/ops/README.md
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge/ops/skills/hello-world-gate/SKILL.md
- knowledge/docs/meta/artifact-placement.md
- .gitignore

## File Locks

Lock state: acquired

Active conflicts before registration:
- None

Other active locks at registration:

## Existing Ops To Check
- registry: knowledge/ops/registry.md
- skill: hello-world-gate (knowledge/ops/skills/hello-world-gate/)
- skill: knowledge-curation (knowledge/ops/skills/knowledge-curation/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口
- knowledge/docs/meta/: メタ土台、配置判断、brief、完成条件

## Markdown Reference Impact

- AGENTS.md
  - AGENTS.md:1
  - AGENTS.md:37
  - AGENTS.md:95
  - AGENTS.md:200
  - AGENTS.md:206
  - Hello-world.md:44
  - Hello-world.md:62
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
  - knowledge/docs/meta/artifact-placement.md:57
  - knowledge/docs/meta/README.md:35
  - knowledge/docs/meta/README.md:39
  - knowledge/docs/meta/README.md:40
  - knowledge/docs/meta/README.md:41
  - knowledge/docs/meta/README.md:45
  - knowledge/docs/meta/README.md:46
  - ... truncated at 25 references
- Hello-world.md
  - AGENTS.md:3
  - AGENTS.md:38
  - AGENTS.md:53
  - AGENTS.md:81
  - AGENTS.md:85
  - AGENTS.md:107
  - AGENTS.md:129
  - AGENTS.md:133
  - AGENTS.md:140
  - AGENTS.md:141
  - AGENTS.md:200
  - COMPASS.md:7
  - COMPASS.md:89
  - Hello-world.md:45
  - Hello-world.md:63
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
  - AGENTS.md:85
  - AGENTS.md:95
  - AGENTS.md:104
  - AGENTS.md:138
  - Hello-world.md:140
  - Hello-world.md:149
  - Hello-world.md:151
  - Hello-world.md:206
  - knowledge/docs/decisions/2026-06-15-mergegate-hooks-lock-completion.md:9
  - knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md:17
  - knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md:27
  - knowledge/docs/meta/artifact-placement.md:57
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:20
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:25
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:33
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:44
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:27
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:43
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:51
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:218
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:219
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:236
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:353
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:354
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:364
  - ... truncated at 25 references
- knowledge/ops/README.md
  - AGENTS.md:68
  - AGENTS.md:106
  - AGENTS.md:200
  - AGENTS.md:267
  - COMPASS.md:96
  - Hello-world.md:61
  - Hello-world.md:136
  - Hello-world.md:138
  - Hello-world.md:139
  - Hello-world.md:152
  - Hello-world.md:164
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:37
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:24
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:14
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:24
  - knowledge/docs/decisions/2026-06-15-knowledge-docs-flat-single-file-layout.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:24
  - knowledge/docs/lexicon.md:73
  - knowledge/docs/meta/artifact-placement.md:52
  - knowledge/docs/meta/artifact-placement.md:57
  - knowledge/docs/meta/completion-criteria.md:17
  - knowledge/docs/meta/completion-criteria.md:18
  - knowledge/docs/meta/completion-criteria.md:33
  - ... truncated at 25 references
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - AGENTS.md:107
  - AGENTS.md:132
  - Hello-world.md:19
  - Hello-world.md:25
  - Hello-world.md:28
  - Hello-world.md:141
  - Hello-world.md:168
  - Hello-world.md:181
  - Hello-world.md:207
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
  - knowledge/ops/README.md:29
  - ... truncated at 25 references
- knowledge/ops/skills/hello-world-gate/SKILL.md
  - AGENTS.md:102
  - AGENTS.md:131
  - Hello-world.md:142
  - Hello-world.md:145
  - Hello-world.md:164
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md:14
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:27
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:30
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:16
  - knowledge/docs/decisions/2026-06-15-knowledge-curation-consolidates-pending-workflow.md:22
  - knowledge/docs/meta/artifact-placement.md:44
  - knowledge/docs/requirements/Biz-compiler_要求定義.md:62
  - knowledge/docs/requirements/Biz-compiler_要求定義.md:237
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:26
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:221
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:235
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:260
  - knowledge/ops/skills/hello-world-gate/SKILL.md:121
- knowledge/docs/meta/artifact-placement.md
  - knowledge/docs/meta/completion-criteria.md:13
  - knowledge/docs/meta/README.md:48
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:105
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:134
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:135
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:192
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:232
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:248
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:282
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:283
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:309
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:310
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:336
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:337

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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 15:16:40 +09:00
- status: completed
- result: Markdown正本をSQLite FTS5へindex/searchするknowledge-search orchestratorを追加
- verified: Python py_compile。PowerShell AST parse。knowledge-search rebuild/status/search。SQLite DBが.gitignore対象であること。git diff --check。
- residual_risk: rebuild中の同時search、session resume/export専用コマンド、embedding/vector search、HTML/JSON/artifact構造検索は未実装。
- released_locks: 8
