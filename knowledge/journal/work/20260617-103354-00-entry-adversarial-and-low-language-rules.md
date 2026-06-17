# Work Card: 00-entry adversarial and low-language rules

- work_id: 20260617-103354-00-entry-adversarial-and-low-language-rules
- registered_at: 2026-06-17 10:33:54 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

00-entryで悪意ある依頼と低言語化ユーザーを安全に扱うルールを明文化する

## Impact

template/00-entryのphase-local contextに効く。00-entry subagentの問診、stop/rework/defer/pass判定、low confidence記録に影響する。ops入口やroot読み込み順には効かない

## Touched Files
- template/00-entry/_context/anomaly-rules.md
- template/00-entry/_context/grill-rules.md
- template/00-entry/_context/gate-rubric.md

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

- template/00-entry/_context/anomaly-rules.md
  - Hello-world.md:102
  - template/00-entry/_context/README.md:17
  - template/00-entry/_context/subagent-brief.md:29
  - template/00-entry/README.md:48
  - template/phase-local-missing.md:38
- template/00-entry/_context/grill-rules.md
  - Hello-world.md:104
  - template/00-entry/_context/README.md:15
  - template/00-entry/_context/subagent-brief.md:27
  - template/00-entry/README.md:46
  - template/phase-local-missing.md:36
- template/00-entry/_context/gate-rubric.md
  - Hello-world.md:103
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
  - template/00-entry/_context/matt-pocock-skills.md:47
  - template/00-entry/_context/README.md:18
  - template/00-entry/_context/subagent-brief.md:30
  - template/00-entry/README.md:49
  - template/00-entry/README.md:60
  - template/phase-local-missing.md:39
  - ... truncated at 25 references

## Code Impact Candidates

> Note: code-impact index was rebuilt automatically before query.

> Warnings
> - weak token fanout skipped: scope (77 edges)
> - weak token fanout skipped: Gate (168 edges)
> - weak token fanout skipped: checks (61 edges)
> - weak token fanout skipped: compass (441 edges)
> - weak token fanout skipped: handoff (136 edges)
> - weak token fanout skipped: user (67 edges)
> - related file limit reached: 60

### Related Files
- COMPASS.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: path-reference `COMPASS.md` at line 32
  - confidence: high
  - reason: repo-relative path reference
- Hello-world.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: path-reference `template/00-entry/_context/anomaly-rules.md` at line 102
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: path-reference `template/00-entry/_context/gate-rubric.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- template/00-entry/_context/subagent-brief.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: path-reference `template/00-entry/_context/anomaly-rules.md` at line 29
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
  - edge: symbol-reference `Main` at line 41
  - confidence: medium
  - reason: symbol token reference
- knowledge/ops/orchestrators/knowledge-search/knowledge_search.py
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: symbol-reference `Main` at line 41
  - confidence: medium
  - reason: symbol token reference
- template/00-entry/README.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: basename-reference `anomaly-rules.md` at line 48
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/README.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: basename-reference `anomaly-rules.md` at line 17
  - confidence: medium
  - reason: basename reference
- template/00-entry/_context/matt-pocock-skills.md
  - depth: 1
  - via: template/00-entry/_context/gate-rubric.md
  - edge: basename-reference `gate-rubric.md` at line 47
  - confidence: medium
  - reason: basename reference
- template/00-entry/artifacts/initial-risk-memo.md
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: basename-reference `initial-risk-memo.md` at line 12
  - confidence: medium
  - reason: basename reference
- template/50-consent/pipeline-flowchart/pipeline-flowchart.html
  - depth: 1
  - via: template/00-entry/_context/anomaly-rules.md
  - edge: key-reference `actor` at line 26
  - confidence: low
  - reason: key token reference
- template/00-entry/questions.md
  - depth: 1
  - via: template/00-entry/_context/grill-rules.md
  - edge: stem-reference `questions` at line 19
  - confidence: low
  - reason: word-to-stem reference
- template/10-source-intake/questions.md
  - depth: 1
  - via: template/00-entry/_context/grill-rules.md
  - edge: stem-reference `questions` at line 19
  - confidence: low
  - reason: word-to-stem reference
- AGENTS.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `AGENTS.md` at line 18
  - confidence: high
  - reason: repo-relative path reference
- MEMORY.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 67
  - confidence: high
  - reason: repo-relative path reference
- README.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 19
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/README.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 3
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-compass-v1-cleanup.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 1
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-development-memory-layout.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 19
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-hello-world-invariant.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 26
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-pending-approval-workflow.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-soul-user-context.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 22
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-ai-outsourcing-metaphor.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 12
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-knowledge-curation-consolidates-pending-workflow.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 27
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-lexicon-initial-read-order.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 22
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 26
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-requirements-conditional-read-order.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 20
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/ir/gate-policy-matrix.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 11
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/ir/minimum-ir-attributes.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 3
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/lexicon.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 3
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/README.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 37
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/session-brief.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 5
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/subagent-brief.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 5
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/method/README.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 9
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/method/empirical-business-design-loop.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 3
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/README.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 25
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/memory/20260614-215546-compass-is-a-direction-packet-for-agents.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-145631-hello-world�t�@�C�������n�C�t���֕ύX.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 23
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-150433-sqlite-knowledge-search��ǉ�.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 92
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-151815-python�����������O����.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 68
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-152307-knowledge-search���R����g���K�[�𖾋L����.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 63
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-153858-setup-md��ǉ�����.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 85
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-161029-repo-local-ops-readme�̓ǂݓ������Œ肷��.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 91
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-173024-skill-creator-gate���쐬����.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 98
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-175737-skill-creator-gate��skill�����݌v�𒼂�.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 90
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-182040-opensquilla�R����writing-research-skill��ǉ�.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 65
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-184153-empirical-prompt-tuning��repo-local-skill�֒ǉ�.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 118
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200302-�E��ses�Ɩ��ϑ����^�t�@�[��memory�֎c��.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 63
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200624-ai�l�ޔh����Ѓ��^�t�@�[��memory�֔��f.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 63
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-202309-biz-compiler���^�t�@�[��readme��agents�֔��f.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 65
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213041-contract-gate������������memory�֎c��.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 64
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213818-contract-gate��phase���������Ƃ���memory�֒���.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 64
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-214043-readme�擪��ai�h����ЃC���t�H�O���t�B�b�N��ǉ�.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 60
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-224041-recompile-lifecycle�̌�񂵔��f��memory�֋L�^.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 65
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-230123-phase-handoff-gate-policy-evidence-confidence-v0.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 70
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-231232-review�n���^�X�L����repo-local�̗p.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 149
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-233938-review�nrepo-local-skill�̐�������.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 93
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-234715-empirical-prompt-tuning���Ώ�������.md
  - depth: 2
  - via: COMPASS.md
  - edge: path-reference `COMPASS.md` at line 127
  - confidence: high
  - reason: repo-relative path reference

### Symbols And Keys
- `Edge` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:63
- `FileRecord` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:44
- `IndexedFile` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:23
- `SearchResult` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:32
- `TokenHit` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:54
- `add` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:505
- `add_edge` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:182
- `add_token_hit` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:178
- `adjacent_edges` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:430
- `build_fts_query` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:111
- `build_path_edges` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:237
- `build_symbol_edges` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:287
- `chunk_lines` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:125
- `classify_source` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:106
- `classify_source` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:52
- `collect_files` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:134
- `compact_snippet` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:298
- `confidence_label` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:85
- `connect` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:143
- `connect` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:149
- `dedupe_edges` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:326
- `dedupe_hits` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:316
- `dedupe_preserve_order` (symbol, define, high) - knowledge/ops/orchestrators/knowledge-search/knowledge_search.py:87
- `detect_staleness` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:378
- `edge_token_fanout` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:426
- `extract_definition_index` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:277
- `extract_definitions` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:189
- `extract_path_mentions` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:230
- `extract_risk_hints` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:221
- `fetch_risk_hints` (symbol, define, high) - knowledge/ops/orchestrators/code-impact/code_impact.py:490

### Risk Hints
- Hello-world.md:268 - `external-call:requests.` (medium)
- Hello-world.md:270 - `external-call:requests.` (medium)
- MEMORY.md:19 - `secret-env:secret` (medium)
- MEMORY.md:19 - `shell:shell` (medium)
- knowledge/docs/ir/gate-policy-matrix.md:41 - `external-call:send` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:100 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:101 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:102 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:103 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:104 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:105 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:106 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:107 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:140 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:146 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:242 - `secret-env:token` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:505 - `external-call:requests.` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:506 - `external-call:requests.` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:507 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:508 - `shell:shell` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:509 - `external-call:send` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:510 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:511 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:512 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:513 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:514 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:515 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:516 - `secret-env:secret` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:517 - `external-call:requests.` (medium)
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md:518 - `external-call:requests.` (medium)

### Validation Candidates
- `git diff --check`
- `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 status`
- `python -m py_compile knowledge\ops\orchestrators\code-impact\code_impact.py`
- `python -m py_compile knowledge\ops\orchestrators\knowledge-search\knowledge_search.py`

### Index Status
- db: knowledge/.index/code-impact.sqlite
- generated_at: 2026-06-17T10:33:59+0900
- generator_version: code-impact-v0.1
- files: 175
- edges: 22379
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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 10:39:26 +09:00
- status: completed
- result: 00-entryにadversarial/abuse handlingと低言語化ユーザーのlow confidence記録ルールを追加
- verified: git diff --check、rgでlow confidence/authorization/abuse記述確認、code-impact rebuild/status
- residual_risk: 実会話での誘導抑制は引き続きsubagentテストで確認が必要
- released_locks: 3

