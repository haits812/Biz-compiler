# Work Card: repo-local ops READMEの読み導線を固定する

- work_id: 20260615-161029-repo-local-ops-readmeの読み導線を固定する
- registered_at: 2026-06-15 16:10:29 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

impact-orchestrator READMEを含め、repo-local Skill/hook/orchestrator/commandの説明ファイルを書いたのに読まれない状態を防ぐ読み導線を固定する

## Impact

AGENTS、Hello-world生成、ops registry、ops README、impact-orchestrator README、hello-world-gateに影響

## Touched Files
- AGENTS.md
- Hello-world.md
- knowledge/ops/registry.md
- knowledge/ops/README.md
- knowledge/ops/orchestrators/impact-orchestrator/README.md
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge/ops/skills/hello-world-gate/SKILL.md

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
  - AGENTS.md:101
  - AGENTS.md:209
  - AGENTS.md:215
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
  - AGENTS.md:113
  - AGENTS.md:135
  - AGENTS.md:139
  - AGENTS.md:146
  - AGENTS.md:147
  - AGENTS.md:209
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
  - AGENTS.md:101
  - AGENTS.md:110
  - AGENTS.md:144
  - AGENTS.md:196
  - Hello-world.md:58
  - Hello-world.md:152
  - Hello-world.md:161
  - Hello-world.md:163
  - Hello-world.md:240
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
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:51
  - ... truncated at 25 references
- knowledge/ops/README.md
  - AGENTS.md:70
  - AGENTS.md:91
  - AGENTS.md:112
  - AGENTS.md:196
  - AGENTS.md:209
  - AGENTS.md:276
  - COMPASS.md:96
  - Hello-world.md:58
  - Hello-world.md:67
  - Hello-world.md:145
  - Hello-world.md:147
  - Hello-world.md:150
  - Hello-world.md:151
  - Hello-world.md:164
  - Hello-world.md:171
  - Hello-world.md:197
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:37
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:24
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:14
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:24
  - knowledge/docs/decisions/2026-06-15-knowledge-docs-flat-single-file-layout.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:24
  - knowledge/docs/lexicon.md:73
  - ... truncated at 25 references
- knowledge/ops/orchestrators/impact-orchestrator/README.md
  - AGENTS.md:70
  - AGENTS.md:91
  - AGENTS.md:112
  - AGENTS.md:196
  - AGENTS.md:209
  - AGENTS.md:276
  - COMPASS.md:96
  - Hello-world.md:58
  - Hello-world.md:67
  - Hello-world.md:145
  - Hello-world.md:147
  - Hello-world.md:150
  - Hello-world.md:151
  - Hello-world.md:164
  - Hello-world.md:171
  - Hello-world.md:197
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:37
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:24
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:14
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:24
  - knowledge/docs/decisions/2026-06-15-knowledge-docs-flat-single-file-layout.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:24
  - knowledge/docs/lexicon.md:73
  - ... truncated at 25 references
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - AGENTS.md:113
  - AGENTS.md:138
  - Hello-world.md:19
  - Hello-world.md:25
  - Hello-world.md:28
  - Hello-world.md:153
  - Hello-world.md:201
  - Hello-world.md:214
  - Hello-world.md:241
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
  - knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md:24
  - ... truncated at 25 references
- knowledge/ops/skills/hello-world-gate/SKILL.md
  - AGENTS.md:108
  - AGENTS.md:137
  - Hello-world.md:154
  - Hello-world.md:157
  - Hello-world.md:197
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
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:260
  - knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md:25
  - knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md:188
  - knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md:206
  - knowledge/journal/work/20260615-151815-python生成物を除外する.md:23
  - knowledge/journal/work/20260615-153858-setup-mdを追加する.md:25
  - knowledge/journal/work/20260615-153858-setup-mdを追加する.md:161
  - knowledge/journal/work/20260615-153858-setup-mdを追加する.md:183
  - knowledge/ops/skills/hello-world-gate/SKILL.md:121
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-161029-repo-local-ops-readmeの読み導線を固定する.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 16:16:52 +09:00
- status: completed
- result: repo-local ops資産を使う/変更する時にregistryからowner README/SKILLへ読む導線を固定し、impact-orchestrator READMEにImpact記入観点を追加した。
- verified: PowerShell AST parse。git diff --check。rgでowner README/SKILL読み導線と古いregistryのみ導線を確認。
- residual_risk: branch/PR state trackingは引き続き未実装。環境側hook接続は各環境で設定する。
- released_locks: 7
