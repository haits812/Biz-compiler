# Work Card: Matt Pocock skillsのphase対応をMEMORYへ保存

- work_id: 20260617-021127-matt-pocock-skillsのphase対応をmemoryへ保存
- registered_at: 2026-06-17 02:11:27 +09:00
- kind: docs
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

数字phase実装に流用できるMatt Pocock skills対応表と置換ルールをMEMORY.mdへ短期実装メモとして残す

## Impact

MEMORY.mdの未整理メモに効く。phase-local実装方針の短期参照用で、正本化は後続のphase実装またはskill化時に判断する

## Touched Files
- MEMORY.md

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
- knowledge/docs/decisions/: 背景理由の確認

## Markdown Reference Impact

- MEMORY.md
  - AGENTS.md:3
  - AGENTS.md:69
  - AGENTS.md:86
  - AGENTS.md:92
  - AGENTS.md:109
  - AGENTS.md:242
  - AGENTS.md:247
  - AGENTS.md:253
  - AGENTS.md:261
  - AGENTS.md:265
  - AGENTS.md:271
  - AGENTS.md:282
  - AGENTS.md:315
  - COMPASS.md:94
  - Hello-world.md:50
  - Hello-world.md:75
  - Hello-world.md:245
  - knowledge/.index/README.md:5
  - knowledge/.index/README.md:16
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:49
  - knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md:76
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:12
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:20
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:25
  - knowledge/docs/decisions/2026-06-14-development-memory-layout.md:29
  - ... truncated at 25 references

## Code Impact Candidates

> Note: code-impact index was rebuilt automatically before query.

> Warnings
> - weak token fanout skipped: Gate (148 edges)
> - weak token fanout skipped: memory (201 edges)
> - weak token fanout skipped: agents (985 edges)
> - weak token fanout skipped: compass (222 edges)
> - weak token fanout skipped: contract (112 edges)
> - weak token fanout skipped: user (58 edges)
> - related file limit reached: 60

### Related Files
- AGENTS.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `AGENTS.md` at line 27
  - confidence: high
  - reason: repo-relative path reference
- COMPASS.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `COMPASS.md` at line 30
  - confidence: high
  - reason: repo-relative path reference
- Hello-world.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 50
  - confidence: high
  - reason: repo-relative path reference
- README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 35
  - confidence: high
  - reason: repo-relative path reference
- SOUL.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 18
  - confidence: high
  - reason: repo-relative path reference
- USER.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `USER.md` at line 28
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 49
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-development-memory-layout.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 12
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-immediate-memory-capture.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 14
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-pending-approval-workflow.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-soul-user-context.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 24
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-ai-outsourcing-metaphor.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 34
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-knowledge-curation-consolidates-pending-workflow.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 10
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-knowledge-search-sqlite-index.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 5
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-lexicon-initial-read-order.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 24
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 1
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-requirements-conditional-read-order.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 22
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 40
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/artifact-placement.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 60
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/completion-criteria.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 36
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/phase-catalog.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 45
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/session-brief.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 23
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/state-model.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 92
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/subagent-brief.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 12
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/decisions/20260614-163000-conversation-phase-navigation-candidate.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 5
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/memory/20260614-210630-ontology-world-model-layer-as-biz-compiler-map.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 18
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/memory/20260614-210853-deckpilot-as-reference-case-for-ai-readable-worl.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 18
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/memory/20260614-211736-ontology-world-model-layer-as-biz-compiler-map.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 5
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/memory/20260614-215546-compass-is-a-direction-packet-for-agents.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 5
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-rejected/memory/20260614-161717-phase���ʕ��̈ˑ��O���t.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 11
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200302-�E��ses�Ɩ��ϑ����^�t�@�[��memory�֎c��.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200624-ai�l�ޔh����Ѓ��^�t�@�[��memory�֔��f.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-202309-biz-compiler���^�t�@�[��readme��agents�֔��f.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 22
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213041-contract-gate������������memory�֎c��.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213818-contract-gate��phase���������Ƃ���memory�֒���.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-224041-recompile-lifecycle�̌�񂵔��f��memory�֋L�^.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-005419-taint-lite���z��skill-gate�ƌ����֎c��.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-010415-code-impact�y�ʉi���O���t���j��memory�֎c��.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-020334-code-impact���f��decision�֏���.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 13
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 26
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/orchestrators/code-impact/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 19
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/orchestrators/code-impact/code_impact.py
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 18
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 189
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/registry.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 66
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/skills/hello-world-gate/SKILL.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 28
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 41
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/skills/knowledge-curation/SKILL.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 3
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/skills/knowledge-curation/new-pending-update.ps1
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 6
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/skills/review-harness/SKILL.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 31
  - confidence: high
  - reason: repo-relative path reference
- knowledge/pending/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 7
  - confidence: high
  - reason: repo-relative path reference
- knowledge/pending/approved/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 9
  - confidence: high
  - reason: repo-relative path reference
- knowledge/pending/memory/README.md
  - depth: 1
  - via: MEMORY.md
  - edge: path-reference `MEMORY.md` at line 3
  - confidence: high
  - reason: repo-relative path reference
- template/50-consent/pipeline-flowchart/pipeline-flowchart.html
  - depth: 1
  - via: MEMORY.md
  - edge: key-reference `scope` at line 15
  - confidence: low
  - reason: key token reference
- template/10-source-intake/handoff.md
  - depth: 1
  - via: MEMORY.md
  - edge: stem-reference `handoff` at line 17
  - confidence: low
  - reason: word-to-stem reference
- knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 39
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-114127-mergegate�^ops��hooks-lock-completion�܂Ŋg��.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 15
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-145631-hello-world�t�@�C�������n�C�t���֕ύX.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 21
  - confidence: high
  - reason: repo-relative path reference

### Symbols And Keys
- `Add-AutoRebuildNote` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:302
- `Add-Unique` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:157
- `Assert-HelloWorldMatches` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:765
- `Assert-HelloWorldStructure` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:258
- `Assert-JapaneseText` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:696
- `Convert-ToBulletLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:711
- `Edge` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:63
- `Ensure-LockFile` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:121
- `FileRecord` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:44
- `Format-LockLines` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:149
- `Format-TreeLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:113
- `Get-ActiveLocks` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:145
- `Get-AheadCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:666
- `Get-BehindCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:681
- `Get-CodeImpactLines` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:261
- `Get-FinishHints` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:184
- `Get-GitOutput` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:648
- `Get-MarkdownReferenceImpact` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:219
- `Get-OpsEntrypointLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:226
- `Get-OpsInventoryLines` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:199
- `Get-PendingCounts` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:146
- `Get-RelativePath` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:80
- `Get-RelativePath` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:97
- `Get-RepoLocalSkillLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:183
- `Get-RoutingHints` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:167
- `Get-UpstreamBranch` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:658
- `Invoke-CodeImpactQueryLocal` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:280
- `Invoke-CodeImpactRebuild` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:778
- `Invoke-CodeImpactRebuildLocal` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:291
- `Invoke-CompleteWork` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:465

### Risk Hints
- Hello-world.md:250 - `external-call:requests.` (medium)
- Hello-world.md:252 - `external-call:requests.` (medium)
- MEMORY.md:19 - `secret-env:secret` (medium)
- MEMORY.md:19 - `shell:shell` (medium)
- knowledge/ops/orchestrators/code-impact/README.md:42 - `external-call:Invoke-WebRequest` (medium)
- knowledge/ops/orchestrators/code-impact/README.md:42 - `file-write:Set-Content` (medium)
- knowledge/ops/orchestrators/code-impact/README.md:42 - `secret-env:secret` (medium)
- knowledge/ops/orchestrators/code-impact/README.md:42 - `shell:shell` (medium)
- knowledge/ops/orchestrators/code-impact/README.md:112 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:17 - `shell:cmd` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:22 - `shell:cmd` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:36 - `shell:shell` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:37 - `file-write:Set-Content` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:38 - `external-call:Invoke-WebRequest` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:39 - `secret-env:secret` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:67 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:169 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:176 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:183 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:185 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:197 - `shell:cmd` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:314 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:331 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:366 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:427 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:428 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:433 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:436 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:452 - `secret-env:token` (medium)
- knowledge/ops/orchestrators/code-impact/code_impact.py:453 - `secret-env:token` (medium)

### Validation Candidates
- `git diff --check`
- `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 status`

### Index Status
- db: knowledge/.index/code-impact.sqlite
- generated_at: 2026-06-17T02:11:29+0900
- generator_version: code-impact-v0.1
- files: 153
- edges: 18324
- stale: no

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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-021127-matt-pocock-skillsのphase対応をmemoryへ保存.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 02:13:10 +09:00
- status: completed
- result: Matt Pocock skillsの数字phase対応表、置換ルール、phase-implementation-gate実装候補をMEMORY.mdへ追加
- verified: MEMORY.md内容確認、git diff --check
- residual_risk: 短期実装メモとしてMEMORY.mdに保持。正本化やrepo-local Skill化は後続のphase実装時に判断。hello-world-gate本体はcommit/pushを伴うため未実行
- released_locks: 1

