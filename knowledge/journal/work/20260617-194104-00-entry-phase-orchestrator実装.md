# Work Card: 00-entry phase orchestrator実装

- work_id: 20260617-194104-00-entry-phase-orchestrator実装
- registered_at: 2026-06-17 19:41:04 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

00-entryをdispatch packet作成、subagent返答review、entry-gate判定まで進めるphase-local orchestratorを追加する

## Impact

template/00-entryの実行導線、業務フォルダへコピーされるphase runner、Hello-worldのtemplate asset一覧、phase-local-missingに効く

## Touched Files
- template/00-entry/phase-orchestrator.ps1
- template/00-entry/README.md
- template/00-entry/_context/README.md
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
- knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し
- knowledge/ops/README.md: ops配置とコマンドの入口
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

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
  - Hello-world.md:161
  - Hello-world.md:172
  - Hello-world.md:180
  - Hello-world.md:226
  - Hello-world.md:229
  - Hello-world.md:231
  - Hello-world.md:234
  - Hello-world.md:235
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
  - Hello-world.md:161
  - Hello-world.md:172
  - Hello-world.md:180
  - Hello-world.md:226
  - Hello-world.md:229
  - Hello-world.md:231
  - Hello-world.md:234
  - Hello-world.md:235
  - ... truncated at 25 references
- template/phase-local-missing.md
  - Hello-world.md:182
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
- Retry: `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query -Files "template/00-entry/phase-orchestrator.ps1;template/00-entry/README.md;template/00-entry/_context/README.md;template/phase-local-missing.md;Hello-world.md" -Depth 2 -Format markdown`

```text
code-impact: target file(s) not indexed: template/00-entry/phase-orchestrator.ps1
```

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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 19:55:12 +09:00
- status: completed
- result: 00-entryにphase-orchestrator.ps1を追加し、start/status/reviewでdispatch bundle作成、subagent返答review、entry-gate判定を行えるようにした。READMEと_context README、phase-local-missingを同期した。
- verified: PowerShell parser、phase-orchestrator status/start/review JSON、temp OutDir write、template _work書き込み拒否、git diff --check、CR/trailing whitespaceなし、code-impact rebuild/status stale no
- residual_risk: AI/subagent呼び出し自体は外部実行者に委ねる。v0は返答形とgate resultの保守的reviewであり、業務正しさの証明ではない。
- released_locks: 5
