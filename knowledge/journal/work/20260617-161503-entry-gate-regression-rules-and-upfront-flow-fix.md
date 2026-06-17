# Work Card: entry-gate regression rules and upfront-flow fixture

- work_id: 20260617-161503-entry-gate-regression-rules-and-upfront-flow-fix
- registered_at: 2026-06-17 16:15:03 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

00-entryで低言語化・代理伝聞を甘くpassしない規則を追加し、初手で既存フローを渡す評価ケースをfixtureへ残す

## Impact

template/00-entryのentry-gate判定とtemplate/_shared/evaluationの回帰観点に効く。後続10-source-intakeへ渡すsource候補の扱いにも影響するが、phase構成やops入口は変えない

## Touched Files
- template/00-entry/_context/gate-rubric.md
- template/00-entry/checks.md
- template/00-entry/_context/grill-rules.md
- template/00-entry/_context/anomaly-rules.md
- template/_shared/evaluation/README.md
- template/_shared/evaluation/persona-test-matrix.md

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
- knowledge/docs/method/ と template/<phase>/: phase設計と雛形

## Markdown Reference Impact

- template/00-entry/_context/gate-rubric.md
  - Hello-world.md:105
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:21
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:62
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:113
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:119
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:120
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:125
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:126
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:131
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:132
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:137
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:143
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:167
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:168
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:173
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:174
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:179
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:180
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:239
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:22
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:66
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:110
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:122
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:123
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:140
  - ... truncated at 25 references
- template/00-entry/checks.md
  - Hello-world.md:117
  - Hello-world.md:125
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:23
  - knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md:93
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:75
  - knowledge/journal/work/20260617-025846-00-entry-source-first-routingを補強して再テスト.md:213
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:23
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:110
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:168
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:169
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:174
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:175
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:216
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:240
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:241
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:244
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:247
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:24
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:26
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:171
  - knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md:225
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:36
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:38
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:70
  - knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md:200
  - ... truncated at 25 references
- template/00-entry/_context/grill-rules.md
  - Hello-world.md:106
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:21
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:60
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:182
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:188
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:35
  - template/00-entry/_context/README.md:15
  - template/00-entry/_context/subagent-brief.md:29
  - template/00-entry/README.md:46
  - template/phase-local-missing.md:36
- template/00-entry/_context/anomaly-rules.md
  - Hello-world.md:104
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:20
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:54
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:116
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:117
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:128
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:129
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:134
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:135
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:152
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:153
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:158
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:159
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:170
  - knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md:176
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:33
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:104
  - knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md:190
  - template/00-entry/_context/README.md:17
  - template/00-entry/_context/subagent-brief.md:31
  - template/00-entry/README.md:48
  - template/phase-local-missing.md:38
- template/_shared/evaluation/README.md
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
  - Hello-world.md:103
  - Hello-world.md:109
  - Hello-world.md:121
  - Hello-world.md:129
  - Hello-world.md:175
  - Hello-world.md:178
  - Hello-world.md:180
  - Hello-world.md:183
  - Hello-world.md:184
  - Hello-world.md:206
  - Hello-world.md:208
  - ... truncated at 25 references
- template/_shared/evaluation/persona-test-matrix.md
  - Hello-world.md:102
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:20
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:114
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:117
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:144
  - knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md:155
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:20
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:22
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:56
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:58
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:59
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:60
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:61
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:62
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:91
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:93
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:94
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:95
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:96
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:97
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:159
  - knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md:200
  - knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md:21
  - knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md:81
  - knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md:83
  - ... truncated at 25 references

## Code Impact Candidates

> Note: code-impact index was rebuilt automatically before query.

> Warnings
> - weak token fanout skipped: scope (87 edges)
> - weak token fanout skipped: Gate (184 edges)
> - weak token fanout skipped: compass (683 edges)
> - weak token fanout skipped: contract (352 edges)
> - weak token fanout skipped: handoff (184 edges)
> - weak token fanout skipped: executor (177 edges)
> - weak token fanout skipped: checks (119 edges)
> - weak token fanout skipped: skill (4574 edges)
> - weak token fanout skipped: evaluation (92 edges)
> - related file limit reached: 60

### Related Files
- COMPASS.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: path-reference `COMPASS.md` at line 92
  - confidence: high
  - reason: repo-relative path reference
- Hello-world.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: path-reference `template/00-entry/_context/anomaly-rules.md` at line 104
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: path-reference `template/00-entry/_context/gate-rubric.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: path-reference `template/00-entry/_context/anomaly-rules.md` at line 20
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: path-reference `template/00-entry/_context/anomaly-rules.md` at line 33
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: path-reference `template/_shared/evaluation/README.md` at line 23
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: path-reference `template/00-entry/_context/gate-rubric.md` at line 300
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: path-reference `template/00-entry/_context/gate-rubric.md` at line 22
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: path-reference `template/00-entry/_context/gate-rubric.md` at line 34
  - confidence: high
  - reason: repo-relative path reference
- template/00-entry/_context/README.md
  - depth: 1
  - via: template/_shared/evaluation/persona-test-matrix.md
  - edge: path-reference `template/_shared/evaluation/persona-test-matrix.md` at line 22
  - confidence: high
  - reason: repo-relative path reference
- template/00-entry/_context/subagent-brief.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: path-reference `template/00-entry/_context/anomaly-rules.md` at line 31
  - confidence: high
  - reason: repo-relative path reference
- template/phase-local-missing.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: path-reference `template/00-entry/_context/anomaly-rules.md` at line 38
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/orchestrators/code-impact/code_impact.py
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: symbol-reference `Main` at line 108
  - confidence: medium
  - reason: symbol token reference
- knowledge/ops/orchestrators/knowledge-search/knowledge_search.py
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: symbol-reference `Main` at line 108
  - confidence: medium
  - reason: symbol token reference
- AGENTS.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 122
  - confidence: medium
  - reason: basename reference
- MEMORY.md
  - depth: 1
  - via: template/00-entry/checks.md
  - edge: basename-reference `checks.md` at line 55
  - confidence: medium
  - reason: basename reference
- knowledge/docs/decisions/2026-06-15-knowledge-docs-flat-single-file-layout.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 8
  - confidence: medium
  - reason: basename reference
- knowledge/docs/meta/README.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 41
  - confidence: medium
  - reason: basename reference
- knowledge/docs/method/phase-handoff-and-contract-gate.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 109
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-151815-python�����������O����.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 52
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-200302-�E��ses�Ɩ��ϑ����^�t�@�[��memory�֎c��.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 66
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-200624-ai�l�ޔh����Ѓ��^�t�@�[��memory�֔��f.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 66
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-202309-biz-compiler���^�t�@�[��readme��agents�֔��f.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 125
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-213041-contract-gate������������memory�֎c��.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 67
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-213818-contract-gate��phase���������Ƃ���memory�֒���.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 67
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-224041-recompile-lifecycle�̌�񂵔��f��memory�֋L�^.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 68
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md
  - depth: 1
  - via: template/00-entry/checks.md
  - edge: basename-reference `checks.md` at line 23
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-005419-taint-lite���z��skill-gate�ƌ����֎c��.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 70
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-010415-code-impact�y�ʉi���O���t���j��memory�֎c��.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 69
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-011853-code-impact�y�ʉi���O���t��ǉ�.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 27
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-014503-code-impact����ƃt���[�֎����A�g.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 27
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-020334-code-impact���f��decision�֏���.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 71
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 73
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-024414-00-entry-phase-v0������.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 59
  - confidence: medium
  - reason: basename reference
- knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 155
  - confidence: medium
  - reason: basename reference
- knowledge/ops/README.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 38
  - confidence: medium
  - reason: basename reference
- knowledge/ops/registry.md
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 39
  - confidence: medium
  - reason: basename reference
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - depth: 1
  - via: template/_shared/evaluation/README.md
  - edge: basename-reference `readme.md` at line 253
  - confidence: medium
  - reason: basename reference
- template/00-entry/README.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: basename-reference `anomaly-rules.md` at line 48
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/matt-pocock-skills.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: basename-reference `gate-rubric.md` at line 47
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/sorting-rules.md
  - depth: 1
  - via: template/00-entry/checks.md
  - edge: basename-reference `checks.md` at line 51
  - confidence: medium
  - reason: basename reference
- template/00-entry/artifacts/initial-risk-memo.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: basename-reference `initial-risk-memo.md` at line 14
  - confidence: medium
  - reason: basename reference
- template/00-entry/artifacts/later-phase-notes.md
  - depth: 1
  - via: template/00-entry/checks.md
  - edge: basename-reference `later-phase-notes.md` at line 54
  - confidence: medium
  - reason: basename reference
- template/10-source-intake/README.md
  - depth: 1
  - via: template/00-entry/checks.md
  - edge: basename-reference `checks.md` at line 41
  - confidence: medium
  - reason: basename reference
- template/50-consent/pipeline-flowchart/pipeline-flowchart.html
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: key-reference `actor` at line 56
  - confidence: low
  - reason: key token reference
- template/00-entry/questions.md
  - depth: 1
  - via: template/00-entry/_context/grill-rules.md
  - edge: stem-reference `questions` at line 21
  - confidence: low
  - reason: word-to-stem reference
- template/10-source-intake/questions.md
  - depth: 1
  - via: template/00-entry/_context/grill-rules.md
  - edge: stem-reference `questions` at line 21
  - confidence: low
  - reason: word-to-stem reference
- README.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 29
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/README.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 11
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 43
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-development-memory-layout.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 18
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 39
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-soul-user-context.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 14
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-ai-outsourcing-metaphor.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 26
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-lexicon-initial-read-order.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 18
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-requirements-conditional-read-order.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 16
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/artifact-placement.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 60
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/README.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 24
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/memory/20260614-210853-deckpilot-as-reference-case-for-ai-readable-worl.md
  - depth: 2
  - via: AGENTS.md
  - edge: path-reference `AGENTS.md` at line 35
  - confidence: high
  - reason: repo-relative path reference

### Symbols And Keys
- `Assert-HelloWorldMatches` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:765
- `Assert-HelloWorldStructure` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:258
- `Assert-JapaneseText` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:696
- `Convert-ToBulletLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:711
- `Edge` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:63
- `FileRecord` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:44
- `Format-TreeLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:113
- `Get-AheadCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:666
- `Get-BehindCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:681
- `Get-GitOutput` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:648
- `Get-OpsEntrypointLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:226
- `Get-PendingCounts` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:146
- `Get-RelativePath` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:97
- `Get-RepoLocalSkillLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:183
- `Get-UpstreamBranch` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:658
- `IndexedFile` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:23
- `Invoke-CodeImpactRebuild` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:778
- `Invoke-Git` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:639
- `Invoke-HelloWorldGate` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:791
- `New-GateCommitMessage` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:728
- `New-HelloWorldContent` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:349
- `Normalize-Text` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:630
- `SearchResult` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:32
- `Sort-ByPreferredOrder` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:82
- `TokenHit` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:54
- `add` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:505
- `add_edge` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:182
- `add_token_hit` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:178
- `adjacent_edges` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:430
- `build_fts_query` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:111

### Risk Hints
- Hello-world.md:270 - `external-call:requests.` (medium)
- Hello-world.md:272 - `external-call:requests.` (medium)
- MEMORY.md:19 - `secret-env:secret` (medium)
- MEMORY.md:19 - `shell:shell` (medium)
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

### Validation Candidates
- `git diff --check`
- `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 status`
- `python -m py_compile knowledge\ops\orchestrators\code-impact\code_impact.py`
- `python -m py_compile knowledge\ops\orchestrators\knowledge-search\knowledge_search.py`

### Index Status
- db: knowledge/.index/code-impact.sqlite
- generated_at: 2026-06-17T16:15:12+0900
- generator_version: code-impact-v0.1
- files: 184
- edges: 27688
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-161503-entry-gate-regression-rules-and-upfront-flow-fix.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 16:19:28 +09:00
- status: completed
- result: 00-entryに低言語化経由と代理/伝聞経由のpass禁止を追加。初手で既存フロー/手順書/Excelを渡す扱いをgate/check/grill/anomalyへ追加。評価fixtureを35 personaへ拡張し、31-35に初手資料持ち込みペルソナを追加。
- verified: rgで35 persona、初手資料持ち込み、低言語化経由、代理/伝聞経由、確認してよい、source holderの反映を確認。git diff --check対象無出力。code-impact rebuild/status成功、stale no。
- residual_risk: 31-35の実サブエージェント対話テストは未実行。template/_shared/evaluationは前回から未追跡ディレクトリとして残っている。
- released_locks: 6

