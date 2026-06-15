# Work Card: MergeGate型opsをhooks-lock-completionまで拡張

- registered_at: 2026-06-15 11:41:27 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: medium

## Intent

hook adapter、file lock、Markdown参照impact、completion trackingを追加する

## Impact

knowledge/ops, knowledge/journal/work, Hello World, AGENTS.md

## Touched Files
- AGENTS.md
- Hello,world.md
- knowledge/ops/registry.md
- knowledge/ops/hooks/README.md
- knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1

## Existing Ops To Check
- registry: knowledge/ops/registry.md
- skill: hello-world-gate (knowledge/ops/skills/hello-world-gate/)
- skill: knowledge-curation (knowledge/ops/skills/knowledge-curation/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello,world.md: 作業規約と現在地
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口

## Execution Assignment

- executor: codex
- subagent: 必要なら knowledge/docs/meta/subagent-brief.md に従って、タスク用仮ゴールを別で渡す

## Finish Gate
- git diff --check
- hello-world-gate.ps1 で Hello,world.md 同期、検査、commit/push
- knowledge/ops/registry.md と Hello,world.md のops entrypoint同期
- 対象PowerShellのスモークテスト

## MergeGate Mapping

| 作法 | このwork cardでの対応 |
|---|---|
| register work | このファイルを作る |
| record impact | Impact と Touched Files に残す |
| assign execution | Execution Assignment に残す |
| verify completion | Finish Gate に残す |

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-15 12:06:56 +09:00
- status: completed
- result: hook adapter、file lock、Markdown参照impact、completion trackingを追加
- verified: PowerShell AST parse。impact-orchestratorのNoWrite。hook adapter NoWrite。file lockの作成、衝突検知、complete解放。git diff --check。
- residual_risk: branch/PR state trackingは未実装。Codex/Claude Codeの外部hook設定は未接続。
- released_locks: 0

