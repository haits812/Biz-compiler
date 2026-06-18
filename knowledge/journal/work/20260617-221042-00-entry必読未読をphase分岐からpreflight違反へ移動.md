# Work Card: 00-entry必読未読をphase分岐からpreflight違反へ移動

- work_id: 20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動
- registered_at: 2026-06-17 22:10:42 +09:00
- kind: template
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

必読ファイル未読/timeoutを00-entryの業務フロー分岐として扱わず、開始前提の不成立として扱う

## Impact

00-entry dispatch契約、main review結果、phase-orchestrator deterministic review

## Touched Files
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

- template/00-entry/_context/dispatch-packet.md
  - Hello-world.md:156
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:21
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:200
  - knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md:203
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:21
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:84
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:99
  - knowledge/journal/work/20260617-210530-00-entry質問0terminal禁止をchecksへ反映.md:32
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:22
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:99
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:103
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:153
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
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:22
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:89
  - knowledge/journal/work/20260617-205649-必読ファイルtimeoutをhard-fail化.md:94
  - knowledge/journal/work/20260617-210530-00-entry質問0terminal禁止をchecksへ反映.md:31
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:21
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:90
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:112
  - knowledge/journal/work/20260617-220117-00-entry-checksへdefer契約とstop理由を同期.md:153
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-221042-00-entry必読未読をphase分岐からpreflight違反へ移動.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 22:15:24 +09:00
- status: completed
- result: 必読ファイル未読/timeoutを00-entryの分岐や終了状態にせず、読了までpreflight_retryする契約へ修正した
- verified: PowerShell parser parse-ok、timeout入力がpreflight_retryになること、正常rework/deferが維持されること、git diff --checkを確認した
- residual_risk: CRLF正規化warningのみ。preflight_retry自体はreviewer保険であり、本来はsubagentが読了まで返答しない契約
- released_locks: 3
