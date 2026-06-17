# Work Card: 00-entry subagent brief dispatch化

- work_id: 20260617-185101-00-entry-subagent-brief-dispatch化
- registered_at: 2026-06-17 18:51:01 +09:00
- kind: template
- state: completed
- executor: codex
- risk: low
- lock_state: released-on-completed

## Intent

template/00-entry/_context/subagent-brief.mdを00専用のdispatch packetとして明確化し、00担当subagentがREADME/contextを読む導線を強める

## Impact

00-entry subagent起動時の必読ファイル注入、README未読開始の防止、low confidence hypothesis/source candidate/entry-gate resultの戻し形式に効く

## Touched Files
- template/00-entry/_context/subagent-brief.md
- template/00-entry/_context/README.md
- template/00-entry/README.md

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

## Code Impact Candidates

> Warnings
> - related file limit reached: 60

### Related Files
- COMPASS.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `COMPASS.md` at line 63
  - confidence: high
  - reason: repo-relative path reference
- Hello-world.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 171
  - confidence: high
  - reason: repo-relative path reference
- README.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `README.md` at line 52
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/lexicon.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `knowledge/docs/lexicon.md` at line 63
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 60
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 58
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 69
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 282
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 37
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-161503-entry-gate-regression-rules-and-upfront-flow-fix.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 120
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-164626-clarify-rework-as-non-terminal-entry-loop.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 20
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-165022-clarify-rework-terminality-in-entry-artifacts.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 35
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-170844-evaluation-fixture-readme-persona�Q�ƍX�V.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 255
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-180337-00-10-handoff-schema����.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 23
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-181730-00-entry�����q�A�����O�O��̐��{��.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-182851-00-entry�q�A�����O�O��\���̒���.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 20
  - confidence: high
  - reason: repo-relative path reference
- template/phase-local-missing.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: path-reference `template/00-entry/README.md` at line 24
  - confidence: high
  - reason: repo-relative path reference
- AGENTS.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 122
  - confidence: medium
  - reason: basename reference
- knowledge/docs/README.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 52
  - confidence: medium
  - reason: basename reference
- knowledge/docs/decisions/2026-06-15-knowledge-docs-flat-single-file-layout.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 8
  - confidence: medium
  - reason: basename reference
- knowledge/docs/decisions/README.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 52
  - confidence: medium
  - reason: basename reference
- knowledge/docs/meta/README.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 41
  - confidence: medium
  - reason: basename reference
- knowledge/docs/method/phase-handoff-and-contract-gate.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 109
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-151815-python�����������O����.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 52
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-200302-�E��ses�Ɩ��ϑ����^�t�@�[��memory�֎c��.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 66
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-200624-ai�l�ޔh����Ѓ��^�t�@�[��memory�֔��f.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 66
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-202309-biz-compiler���^�t�@�[��readme��agents�֔��f.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 125
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-213041-contract-gate������������memory�֎c��.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 67
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-213818-contract-gate��phase���������Ƃ���memory�֒���.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 67
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-224041-recompile-lifecycle�̌�񂵔��f��memory�֋L�^.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 68
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-005419-taint-lite���z��skill-gate�ƌ����֎c��.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 70
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-010415-code-impact�y�ʉi���O���t���j��memory�֎c��.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 69
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-011853-code-impact�y�ʉi���O���t��ǉ�.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 27
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-014503-code-impact����ƃt���[�֎����A�g.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 27
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-020334-code-impact���f��decision�֏���.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 71
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 73
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-024414-00-entry-phase-v0������.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 59
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 155
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-170226-split-shared-evaluation-personas-into-stable-fol.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 114
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-180332-�q�A�����O�����O�񃁃�.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 71
  - confidence: medium
  - reason: basename reference
- knowledge/ops/README.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 38
  - confidence: medium
  - reason: basename reference
- knowledge/ops/registry.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 39
  - confidence: medium
  - reason: basename reference
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `readme.md` at line 275
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/anomaly-rules.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `anomaly-rules.md` at line 56
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/gate-rubric.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `gate-rubric.md` at line 57
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/grill-rules.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `grill-rules.md` at line 54
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/matt-pocock-skills.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `matt-pocock-skills.md` at line 58
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/phase-boundary.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `phase-boundary.md` at line 53
  - confidence: medium
  - reason: basename reference
- template/00-entry/artifacts/entry-packet.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `entry-packet.md` at line 38
  - confidence: medium
  - reason: basename reference
- template/00-entry/artifacts/initial-risk-memo.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `initial-risk-memo.md` at line 40
  - confidence: medium
  - reason: basename reference
- template/00-entry/artifacts/later-phase-notes.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `later-phase-notes.md` at line 42
  - confidence: medium
  - reason: basename reference
- template/00-entry/checks.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `checks.md` at line 68
  - confidence: medium
  - reason: basename reference
- template/00-entry/contract.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `contract.md` at line 43
  - confidence: medium
  - reason: basename reference
- template/00-entry/handoff.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `handoff.md` at line 44
  - confidence: medium
  - reason: basename reference
- template/00-entry/questions.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `questions.md` at line 64
  - confidence: medium
  - reason: basename reference
- template/10-source-intake/checks.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `checks.md` at line 68
  - confidence: medium
  - reason: basename reference
- template/10-source-intake/contract.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `contract.md` at line 43
  - confidence: medium
  - reason: basename reference
- template/10-source-intake/handoff.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `handoff.md` at line 44
  - confidence: medium
  - reason: basename reference
- template/10-source-intake/questions.md
  - depth: 1
  - via: template/00-entry/README.md
  - edge: basename-reference `questions.md` at line 64
  - confidence: medium
  - reason: basename reference

### Symbols And Keys
- `Assert-HelloWorldMatches` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:787
- `Assert-HelloWorldStructure` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:280
- `Assert-JapaneseText` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:718
- `Convert-ToBulletLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:733
- `Convert-ToLf` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:27
- `Format-TreeLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:135
- `Get-AheadCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:688
- `Get-BehindCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:703
- `Get-GitOutput` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:670
- `Get-OpsEntrypointLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:248
- `Get-PendingCounts` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:168
- `Get-RelativePath` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:119
- `Get-RepoLocalSkillLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:205
- `Get-UpstreamBranch` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:680
- `Invoke-CodeImpactRebuild` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:800
- `Invoke-Git` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:661
- `Invoke-HelloWorldGate` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:813
- `New-GateCommitMessage` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:750
- `New-HelloWorldContent` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:371
- `Normalize-Text` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:652
- `Sort-ByPreferredOrder` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:104
- `Write-Utf8LfFile` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:36
- `false` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:2
- `true` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:29
- `true` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:39
- `true` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:107
- `true` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:121
- `true` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:138
- `true` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:654
- `true` (param, define, medium) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:663

### Risk Hints
- Hello-world.md:320 - `external-call:requests.` (medium)
- Hello-world.md:322 - `external-call:requests.` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:88 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:89 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:90 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:91 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:92 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:93 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:432 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:491 - `external-call:requests.` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:492 - `external-call:requests.` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:493 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:494 - `shell:shell` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:495 - `external-call:Invoke-WebRequest` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:496 - `file-write:Set-Content` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:497 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:498 - `shell:shell` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:499 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:500 - `shell:shell` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:501 - `shell:shell` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:502 - `shell:shell` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:503 - `file-write:Set-Content` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:504 - `external-call:Invoke-WebRequest` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:505 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:506 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:507 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:508 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:509 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:510 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md:511 - `shell:shell` (medium)

### Validation Candidates
- `git diff --check`
- `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 status`

### Index Status
- db: knowledge/.index/code-impact.sqlite
- generated_at: 2026-06-17T18:31:11+0900
- generator_version: code-impact-v0.1
- files: 245
- edges: 52799
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-185101-00-entry-subagent-brief-dispatch化.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 18:52:58 +09:00
- status: completed
- result: 00-entry subagent briefを00専用dispatch packetとして明確化し、README/context未読で質問開始しない制約と戻し形式を追加
- verified: rgでbrief雛形が消えdispatch packet表現が残ることを確認、git diff --check、CR文字なし確認、code-impact rebuild
- residual_risk: 機械的なsubagent起動orchestratorは未実装。現時点ではdispatch packet本文を渡す運用制約として固定
- released_locks: 3
