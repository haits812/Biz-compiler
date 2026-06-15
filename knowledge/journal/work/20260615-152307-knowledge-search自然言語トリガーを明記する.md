# Work Card: knowledge-search自然言語トリガーを明記する

- work_id: 20260615-152307-knowledge-search自然言語トリガーを明記する
- registered_at: 2026-06-15 15:23:07 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

前にこんな会話しなかったっけ等の自然言語依頼でknowledge-searchを使うルールをHello-worldと運用文書に固定する

## Impact

Hello-world初期読み込み、AGENTSの作業規約、knowledge/docs read routing、knowledge-search README、ops registry、hello-world-gate生成内容に影響

## Touched Files
- Hello-world.md
- AGENTS.md
- knowledge/ops/registry.md
- knowledge/ops/orchestrators/knowledge-search/README.md
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge/docs/README.md

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

- Hello-world.md
  - AGENTS.md:3
  - AGENTS.md:38
  - AGENTS.md:53
  - AGENTS.md:81
  - AGENTS.md:85
  - AGENTS.md:109
  - AGENTS.md:131
  - AGENTS.md:135
  - AGENTS.md:142
  - AGENTS.md:143
  - AGENTS.md:204
  - COMPASS.md:7
  - COMPASS.md:89
  - Hello-world.md:45
  - Hello-world.md:64
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
- AGENTS.md
  - AGENTS.md:1
  - AGENTS.md:37
  - AGENTS.md:97
  - AGENTS.md:204
  - AGENTS.md:210
  - Hello-world.md:44
  - Hello-world.md:63
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
  - knowledge/docs/meta/artifact-placement.md:59
  - knowledge/docs/meta/README.md:35
  - knowledge/docs/meta/README.md:39
  - knowledge/docs/meta/README.md:40
  - knowledge/docs/meta/README.md:41
  - knowledge/docs/meta/README.md:42
  - knowledge/docs/meta/README.md:46
  - ... truncated at 25 references
- knowledge/ops/registry.md
  - AGENTS.md:85
  - AGENTS.md:97
  - AGENTS.md:106
  - AGENTS.md:140
  - Hello-world.md:145
  - Hello-world.md:154
  - Hello-world.md:156
  - Hello-world.md:213
  - knowledge/docs/decisions/2026-06-15-mergegate-hooks-lock-completion.md:9
  - knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md:17
  - knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md:27
  - knowledge/docs/meta/artifact-placement.md:59
  - knowledge/docs/meta/README.md:40
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
  - ... truncated at 25 references
- knowledge/ops/orchestrators/knowledge-search/README.md
  - AGENTS.md:68
  - AGENTS.md:108
  - AGENTS.md:204
  - AGENTS.md:271
  - COMPASS.md:96
  - Hello-world.md:61
  - Hello-world.md:138
  - Hello-world.md:140
  - Hello-world.md:143
  - Hello-world.md:144
  - Hello-world.md:157
  - Hello-world.md:164
  - Hello-world.md:171
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:37
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md:24
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:14
  - knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md:24
  - knowledge/docs/decisions/2026-06-15-knowledge-docs-flat-single-file-layout.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:8
  - knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md:24
  - knowledge/docs/lexicon.md:73
  - knowledge/docs/meta/artifact-placement.md:54
  - knowledge/docs/meta/artifact-placement.md:59
  - knowledge/docs/meta/completion-criteria.md:17
  - ... truncated at 25 references
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge/docs/README.md
  - AGENTS.md:109
  - AGENTS.md:134
  - Hello-world.md:19
  - Hello-world.md:25
  - Hello-world.md:28
  - Hello-world.md:146
  - Hello-world.md:175
  - Hello-world.md:188
  - Hello-world.md:214
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260615-152307-knowledge-search自然言語トリガーを明記する.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 15:25:10 +09:00
- status: completed
- result: knowledge-searchを『前にこんな会話しなかったっけ？』系の自然言語で発火する運用としてAGENTS、read routing、registry、README、Hello-world生成元に明記した
- verified: PowerShell AST parse。rgで自然言語トリガー記載を確認。knowledge-search searchが動作。git diff --check。
- residual_risk: 現在のHello-world.mdへの反映はhello-world-gate実行で同期する。SQLite indexは生成物なのでcommitしない。
- released_locks: 5

