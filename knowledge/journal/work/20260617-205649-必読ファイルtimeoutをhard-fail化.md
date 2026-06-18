# Work Card: 必読ファイルtimeoutをhard fail化

- work_id: 20260617-205649-必読ファイルtimeoutをhard-fail化
- registered_at: 2026-06-17 20:56:49 +09:00
- kind: docs
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

必読ファイルのtimeoutを読了扱いにしないルールをAGENTSと00-entry dispatch/reviewに固定する

## Impact

AGENTS.mdの常時読み込み規約、00-entry subagent dispatch、phase-orchestrator review判定に効く。新規セッションで必読未読のまま入口応答へ進む事故を止める

## Touched Files
- AGENTS.md
- template/00-entry/_context/dispatch-packet.md
- template/00-entry/_context/dispatch-checks.md
- template/00-entry/phase-orchestrator.ps1

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
- orchestrator: code-impact (knowledge/ops/orchestrators/code-impact/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- orchestrator: knowledge-search (knowledge/ops/orchestrators/knowledge-search/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- AGENTS.md
  - AGENTS.md:1
  - AGENTS.md:63
  - AGENTS.md:150
  - AGENTS.md:259
  - AGENTS.md:265
  - COMPASS.md:18
  - Hello-world.md:44
  - Hello-world.md:74
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:43
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:18
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md:39
  - knowledge/docs/decisions/2026-06-14-soul-user-context.md:14
  - knowledge/docs/decisions/2026-06-14-soul-user-context.md:18
  - knowledge/docs/decisions/2026-06-15-ai-outsourcing-metaphor.md:26
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
  - ... truncated at 25 references
- template/00-entry/_context/dispatch-packet.md
  - Hello-world.md:156
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:21
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:200
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:203
  - template/00-entry/_context/dispatch-checks.md:3
  - template/00-entry/_context/README.md:9
  - template/00-entry/_context/README.md:13
  - template/00-entry/README.md:60
  - template/phase-local-missing.md:42
- template/00-entry/_context/dispatch-checks.md
  - Hello-world.md:155
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:22
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:200
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:203
  - template/00-entry/_context/dispatch-packet.md:11
  - template/00-entry/_context/README.md:23
  - template/00-entry/README.md:61
  - template/phase-local-missing.md:43
- template/00-entry/phase-orchestrator.ps1
  - Hello-world.md:171
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:20
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:172
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:175
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:214
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:17
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:20
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:56
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:493
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:494
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:495
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:496
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:497
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:498
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:499
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:500
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:501
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:502
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:503
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:504
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:505
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:506
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:507
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:508
  - knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md:509
  - ... truncated at 25 references

## Execution Assignment

- executor: codex
- subagent: 必要なら knowledge/docs/meta/subagent-brief.md に従って、タスク用仮ゴールを別で渡す

## Finish Gate
- git diff --check
- hello-world-gate.ps1 で Hello-world.md 同期、検査、commit/push
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 21:08:48 +09:00
- status: completed
- result: AGENTSと00-entry dispatch/reviewへ、必読ファイルtimeout hard fail、グローバルSkill汚染禁止、初回発話だけのpass/defer terminal禁止を反映した。phase-orchestrator reviewでtimeout/未読と質問0terminalをfailにするよう更新した
- verified: PowerShell parse ok、dispatch bundle生成でRead Failure/First-turn/interaction_stateが出ること、timeoutしたが進める返答がread-confirmation failになること、質問0deferがzero-question-terminal failになること、git diff --check
- residual_risk: 新規チャットが必ずrepo-local phase-orchestratorを通る接続は別途未実装
- released_locks: 4
