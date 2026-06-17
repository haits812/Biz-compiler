# Work Card: 00-entry dispatch packet化

- work_id: 20260617-192520-00-entry-dispatch-packet化
- registered_at: 2026-06-17 19:25:20 +09:00
- kind: template
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

00-entryのsubagent-briefをdispatch-packetへ改名し、main reviewer用dispatch-checksを追加して、phase実行入力契約として扱う

## Impact

00-entry phase-local context、Hello-worldのtemplate asset一覧、phase-local-missing、00担当subagentの読み導線とmain reviewに効く

## Touched Files
- template/00-entry/_context/subagent-brief.md
- template/00-entry/_context/dispatch-packet.md
- template/00-entry/_context/dispatch-checks.md
- template/00-entry/_context/README.md
- template/00-entry/README.md
- template/phase-local-missing.md
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
- orchestrator: code-impact (knowledge/ops/orchestrators/code-impact/)
- orchestrator: impact-orchestrator (knowledge/ops/orchestrators/impact-orchestrator/)
- orchestrator: knowledge-search (knowledge/ops/orchestrators/knowledge-search/)
- hooks: knowledge/ops/hooks/

## Read Routing
- AGENTS.md / Hello-world.md: 作業規約と現在地
- knowledge/docs/meta/: メタ土台、配置判断、brief、完成条件
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- template/00-entry/_context/subagent-brief.md
  - COMPASS.md:18
  - Hello-world.md:161
  - knowledge/docs/meta/completion-criteria.md:16
  - knowledge/docs/meta/README.md:48
  - knowledge/docs/meta/session-brief.md:79
  - knowledge/docs/README.md:5
  - knowledge/docs/README.md:62
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:39
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:359
  - knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md:226
  - knowledge/journal/work/20260615-151815-python生成物を除外する.md:89
  - knowledge/journal/work/20260615-152307-knowledge-search自然言語トリガーを明記する.md:191
  - knowledge/journal/work/20260615-153858-setup-mdを追加する.md:215
  - knowledge/journal/work/20260615-161029-repo-local-ops-readmeの読み導線を固定する.md:245
  - knowledge/journal/work/20260615-173024-skill-creator-gateを作成する.md:321
  - knowledge/journal/work/20260615-175737-skill-creator-gateのskill実装設計を直す.md:190
  - knowledge/journal/work/20260615-182040-opensquilla由来のwriting-research-skillを追加.md:193
  - knowledge/journal/work/20260615-184153-empirical-prompt-tuningをrepo-local-skillへ追加.md:165
  - knowledge/journal/work/20260615-200302-職場ses業務委託メタファーをmemoryへ残す.md:80
  - knowledge/journal/work/20260615-200624-ai人材派遣会社メタファーをmemoryへ反映.md:80
  - knowledge/journal/work/20260615-202309-biz-compilerメタファーをreadmeとagentsへ反映.md:139
  - knowledge/journal/work/20260615-213041-contract-gate未整備メモをmemoryへ残す.md:81
  - knowledge/journal/work/20260615-213818-contract-gateをphase末尾処理としてmemoryへ訂正.md:81
  - knowledge/journal/work/20260615-214043-readme先頭へai派遣会社インフォグラフィックを追加.md:80
  - knowledge/journal/work/20260615-224041-recompile-lifecycleの後回し判断をmemoryへ記録.md:82
  - ... truncated at 25 references
- template/00-entry/_context/README.md
  - AGENTS.md:96
  - AGENTS.md:122
  - AGENTS.md:123
  - AGENTS.md:124
  - AGENTS.md:126
  - AGENTS.md:128
  - AGENTS.md:150
  - AGENTS.md:234
  - AGENTS.md:247
  - AGENTS.md:314
  - COMPASS.md:18
  - COMPASS.md:102
  - Hello-world.md:58
  - Hello-world.md:69
  - Hello-world.md:112
  - Hello-world.md:152
  - Hello-world.md:153
  - Hello-world.md:159
  - Hello-world.md:171
  - Hello-world.md:179
  - Hello-world.md:225
  - Hello-world.md:228
  - Hello-world.md:230
  - Hello-world.md:233
  - Hello-world.md:234
  - ... truncated at 25 references
- template/00-entry/README.md
  - AGENTS.md:96
  - AGENTS.md:122
  - AGENTS.md:123
  - AGENTS.md:124
  - AGENTS.md:126
  - AGENTS.md:128
  - AGENTS.md:150
  - AGENTS.md:234
  - AGENTS.md:247
  - AGENTS.md:314
  - COMPASS.md:18
  - COMPASS.md:102
  - Hello-world.md:58
  - Hello-world.md:69
  - Hello-world.md:112
  - Hello-world.md:152
  - Hello-world.md:153
  - Hello-world.md:159
  - Hello-world.md:171
  - Hello-world.md:179
  - Hello-world.md:225
  - Hello-world.md:228
  - Hello-world.md:230
  - Hello-world.md:233
  - Hello-world.md:234
  - ... truncated at 25 references
- template/phase-local-missing.md
  - Hello-world.md:181
  - knowledge/docs/meta/completion-criteria.md:37
  - knowledge/docs/meta/README.md:28
  - knowledge/docs/meta/README.md:44
  - knowledge/docs/meta/README.md:50
  - knowledge/docs/meta/README.md:69
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:28
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:90
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:92
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:94
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:96
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:97
  - knowledge/journal/work/20260617-024414-00-entry-phase-v0を実装.md:21
  - knowledge/journal/work/20260617-024414-00-entry-phase-v0を実装.md:81
  - knowledge/journal/work/20260617-024414-00-entry-phase-v0を実装.md:128
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:61
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:69
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:80
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:93
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:94
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:95
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:129
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:59
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:65
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:91
  - ... truncated at 25 references
- Hello-world.md
  - AGENTS.md:3
  - AGENTS.md:15
  - AGENTS.md:64
  - AGENTS.md:80
  - AGENTS.md:109
  - AGENTS.md:113
  - AGENTS.md:151
  - AGENTS.md:173
  - AGENTS.md:177
  - AGENTS.md:184
  - AGENTS.md:185
  - AGENTS.md:247
  - COMPASS.md:18
  - Hello-world.md:45
  - Hello-world.md:75
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

## Code Impact Candidates

- Warning: code-impact query failed. Work card creation continues.
- Exit code: 2
- Rebuild: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 rebuild`
- Retry: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query -Files "template/00-entry/_context/subagent-brief.md;template/00-entry/_context/dispatch-packet.md;template/00-entry/_context/dispatch-checks.md;template/00-entry/_context/README.md;template/00-entry/README.md;template/phase-local-missing.md;Hello-world.md" -Depth 2 -Format markdown`

```text
code-impact: target file(s) not indexed: template/00-entry/_context/dispatch-packet.md, template/00-entry/_context/dispatch-checks.md
```

## Execution Assignment

- executor: codex
- subagent: 必要なら knowledge/docs/meta/subagent-brief.md に従って、タスク用仮ゴールを別で渡す

## Finish Gate
- git diff --check
- hello-world-gate.ps1 で Hello-world.md 同期、検査、commit/push
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-192520-00-entry-dispatch-packet化.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 19:30:09 +09:00
- status: completed
- result: 00-entryのsubagent-briefをdispatch-packetへrenameし、subagent返答後にmain agentが確認するdispatch-checksを追加。READMEとphase-local-missingの参照を更新した。
- verified: git diff --check、CR文字なし確認、code-impact rebuild/status stale no
- residual_risk: phase orchestrator本体は未実装。現時点では00-entry phase-localのdispatch入力契約とmain review観点として固定。
- released_locks: 7
