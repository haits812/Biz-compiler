# Work Card: impact-orchestrator LF固定

- work_id: 20260617-173938-impact-orchestrator-lf固定
- registered_at: 2026-06-17 17:39:38 +09:00
- kind: ops
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

work cardとlocks.jsonの書き込みをLF固定にして、作業前後のCRLF警告を止める

## Impact

impact-orchestrator register/complete、work ledger、hello-world-gate前のstatus/diff出力に効く

## Touched Files
- knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1
- knowledge/journal/work/locks.json

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

## Markdown Reference Impact

- knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1
  - AGENTS.md:133
  - Hello-world.md:228
  - Hello-world.md:276
  - knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md:19
  - knowledge/journal/work/20260615-114127-mergegate型opsをhooks-lock-completionまで拡張.md:22
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:31
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:342
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:382
  - knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md:249
  - knowledge/journal/work/20260615-151815-python生成物を除外する.md:111
  - knowledge/journal/work/20260615-152307-knowledge-search自然言語トリガーを明記する.md:214
  - knowledge/journal/work/20260615-153858-setup-mdを追加する.md:238
  - knowledge/journal/work/20260615-161029-repo-local-ops-readmeの読み導線を固定する.md:268
  - knowledge/journal/work/20260615-173024-skill-creator-gateを作成する.md:344
  - knowledge/journal/work/20260615-175737-skill-creator-gateのskill実装設計を直す.md:212
  - knowledge/journal/work/20260615-182040-opensquilla由来のwriting-research-skillを追加.md:215
  - knowledge/journal/work/20260615-184153-empirical-prompt-tuningをrepo-local-skillへ追加.md:188
  - knowledge/journal/work/20260615-200302-職場ses業務委託メタファーをmemoryへ残す.md:101
  - knowledge/journal/work/20260615-200624-ai人材派遣会社メタファーをmemoryへ反映.md:101
  - knowledge/journal/work/20260615-202309-biz-compilerメタファーをreadmeとagentsへ反映.md:160
  - knowledge/journal/work/20260615-213041-contract-gate未整備メモをmemoryへ残す.md:102
  - knowledge/journal/work/20260615-213818-contract-gateをphase末尾処理としてmemoryへ訂正.md:102
  - knowledge/journal/work/20260615-214043-readme先頭へai派遣会社インフォグラフィックを追加.md:101
  - knowledge/journal/work/20260615-224041-recompile-lifecycleの後回し判断をmemoryへ記録.md:103
  - knowledge/journal/work/20260615-230123-phase-handoff-gate-policy-evidence-confidence-v0.md:165
  - ... truncated at 25 references
- knowledge/journal/work/locks.json
  - AGENTS.md:149
  - Hello-world.md:283
  - knowledge/docs/decisions/2026-06-15-mergegate-hooks-lock-completion.md:25
  - knowledge/journal/work/20260615-145631-hello-worldファイル名をハイフンへ変更.md:374
  - knowledge/journal/work/20260615-150433-sqlite-knowledge-searchを追加.md:241
  - knowledge/journal/work/20260615-151815-python生成物を除外する.md:103
  - knowledge/journal/work/20260615-152307-knowledge-search自然言語トリガーを明記する.md:206
  - knowledge/journal/work/20260615-153858-setup-mdを追加する.md:230
  - knowledge/journal/work/20260615-161029-repo-local-ops-readmeの読み導線を固定する.md:260
  - knowledge/journal/work/20260615-173024-skill-creator-gateを作成する.md:336
  - knowledge/journal/work/20260615-175737-skill-creator-gateのskill実装設計を直す.md:204
  - knowledge/journal/work/20260615-182040-opensquilla由来のwriting-research-skillを追加.md:207
  - knowledge/journal/work/20260615-184153-empirical-prompt-tuningをrepo-local-skillへ追加.md:180
  - knowledge/journal/work/20260615-200302-職場ses業務委託メタファーをmemoryへ残す.md:93
  - knowledge/journal/work/20260615-200624-ai人材派遣会社メタファーをmemoryへ反映.md:93
  - knowledge/journal/work/20260615-202309-biz-compilerメタファーをreadmeとagentsへ反映.md:152
  - knowledge/journal/work/20260615-213041-contract-gate未整備メモをmemoryへ残す.md:94
  - knowledge/journal/work/20260615-213818-contract-gateをphase末尾処理としてmemoryへ訂正.md:94
  - knowledge/journal/work/20260615-214043-readme先頭へai派遣会社インフォグラフィックを追加.md:93
  - knowledge/journal/work/20260615-224041-recompile-lifecycleの後回し判断をmemoryへ記録.md:95
  - knowledge/journal/work/20260615-230123-phase-handoff-gate-policy-evidence-confidence-v0.md:157
  - knowledge/journal/work/20260615-231232-review系メタスキルをrepo-local採用.md:210
  - knowledge/journal/work/20260615-232249-review-harness-quickstart-guide削除.md:100
  - knowledge/journal/work/20260615-233010-review-agent-essenceをレポート出力化.md:97
  - knowledge/journal/work/20260615-233938-review系repo-local-skillの正式同期.md:154
  - ... truncated at 25 references

## Code Impact Candidates

> Note: code-impact index was rebuilt automatically before query.

> Warnings
> - related file limit reached: 60

### Related Files
- AGENTS.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 149
  - confidence: high
  - reason: repo-relative path reference
- Hello-world.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 283
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-mergegate-hooks-lock-completion.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 25
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-145631-hello-world�t�@�C�������n�C�t���֕ύX.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 374
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-150433-sqlite-knowledge-search��ǉ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 241
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-151815-python�����������O����.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 103
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-152307-knowledge-search���R����g���K�[�𖾋L����.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 206
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-153858-setup-md��ǉ�����.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 230
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-161029-repo-local-ops-readme�̓ǂݓ������Œ肷��.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 260
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-173024-skill-creator-gate���쐬����.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 336
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-175737-skill-creator-gate��skill�����݌v�𒼂�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 204
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-182040-opensquilla�R����writing-research-skill��ǉ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 207
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-184153-empirical-prompt-tuning��repo-local-skill�֒ǉ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 180
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200302-�E��ses�Ɩ��ϑ����^�t�@�[��memory�֎c��.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 93
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200624-ai�l�ޔh����Ѓ��^�t�@�[��memory�֔��f.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 93
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-202309-biz-compiler���^�t�@�[��readme��agents�֔��f.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 152
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213041-contract-gate������������memory�֎c��.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 94
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213818-contract-gate��phase���������Ƃ���memory�֒���.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 94
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-214043-readme�擪��ai�h����ЃC���t�H�O���t�B�b�N��ǉ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 93
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-224041-recompile-lifecycle�̌�񂵔��f��memory�֋L�^.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 95
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-230123-phase-handoff-gate-policy-evidence-confidence-v0.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 157
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-231232-review�n���^�X�L����repo-local�̗p.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 210
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-232249-review-harness-quickstart-guide�폜.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 100
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-233010-review-agent-essence�����|�[�g�o�͉�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 97
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-233938-review�nrepo-local-skill�̐�������.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 154
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-234027-review�nskill-frontmatter�W����.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 128
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-234715-empirical-prompt-tuning���Ώ�������.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 188
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-234928-knowledge-curation���Ώ�������.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 181
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 149
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260616-000340-readme�֓y��C���t�H�O���t�B�b�N��ǉ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 96
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260616-222504-clone-safe�ȃp�X�\�L�֏C��.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 216
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-005419-taint-lite���z��skill-gate�ƌ����֎c��.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 96
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-010415-code-impact�y�ʉi���O���t���j��memory�֎c��.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 95
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-011853-code-impact�y�ʉi���O���t��ǉ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 296
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-014503-code-impact����ƃt���[�֎����A�g.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 323
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-020334-code-impact���f��decision�֏���.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 108
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-021127-matt-pocock-skills��phase�Ή���memory�֕ۑ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 550
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-022656-compass��heading�ɍi���ďd������.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 597
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-024414-00-entry-phase-v0������.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 150
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-025846-00-entry-source-first-routing��⋭���čăe�X�g.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 566
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-103354-00-entry-adversarial-and-low-language-rules.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 563
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-103651-00-entry-hypothesis-and-authorization-artifact-f.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 256
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-115131-00-entry-persona-test-matrix.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 136
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-122731-move-persona-matrix-to-shared-template-evaluatio.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 181
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-141639-paired-subagent-evaluation-protocol.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 575
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-154742-entry-gate-and-source-intake-reviewer.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 795
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-155216-source-intake-reviewer-artifact-fields.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 575
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-161503-entry-gate-regression-rules-and-upfront-flow-fix.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 672
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-162137-upfront-existing-material-test-fixtures.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 169
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-163240-mismatched-flow-persona-fixtures.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 166
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-164626-clarify-rework-as-non-terminal-entry-loop.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 654
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-165022-clarify-rework-terminality-in-entry-artifacts.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 581
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-170226-split-shared-evaluation-personas-into-stable-fol.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 164
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-170844-evaluation-fixture-readme-persona�Q�ƍX�V.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 546
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-173209-hello-world-gate-lf�Œ�.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 139
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/README.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 149
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/orchestrators/impact-orchestrator/README.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 28
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/registry.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 110
  - confidence: high
  - reason: repo-relative path reference
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: path-reference `knowledge/journal/work/locks.json` at line 277
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/README.md
  - depth: 1
  - via: knowledge/journal/work/locks.json
  - edge: basename-reference `locks.json` at line 12
  - confidence: medium
  - reason: basename reference

### Symbols And Keys
- `Add-AutoRebuildNote` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:302
- `Add-Unique` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:157
- `Assert-HelloWorldMatches` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:787
- `Assert-HelloWorldStructure` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:280
- `Assert-JapaneseText` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:718
- `Convert-ToBulletLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:733
- `Convert-ToLf` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:27
- `Ensure-LockFile` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:121
- `Format-LockLines` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:149
- `Format-TreeLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:135
- `Get-ActiveLocks` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:145
- `Get-AheadCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:688
- `Get-BehindCount` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:703
- `Get-CodeImpactLines` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:261
- `Get-FinishHints` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:184
- `Get-GitOutput` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:670
- `Get-MarkdownReferenceImpact` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:219
- `Get-OpsEntrypointLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:248
- `Get-OpsInventoryLines` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:199
- `Get-PendingCounts` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:168
- `Get-RelativePath` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:80
- `Get-RelativePath` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:119
- `Get-RepoLocalSkillLines` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:205
- `Get-RoutingHints` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:167
- `Get-UpstreamBranch` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:680
- `Invoke-CodeImpactQueryLocal` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:280
- `Invoke-CodeImpactRebuild` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:800
- `Invoke-CodeImpactRebuildLocal` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:291
- `Invoke-CompleteWork` (symbol, define, high) - knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1:465
- `Invoke-Git` (symbol, define, high) - knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1:661

### Risk Hints
- Hello-world.md:319 - `external-call:requests.` (medium)
- Hello-world.md:321 - `external-call:requests.` (medium)
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
- `$errors = $null; [System.Management.Automation.Language.Parser]::ParseFile("knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1", [ref]$null, [ref]$errors) | Out-Null; if ($errors.Count) { throw ($errors | Out-String) }`

### Index Status
- db: knowledge/.index/code-impact.sqlite
- generated_at: 2026-06-17T17:39:42+0900
- generator_version: code-impact-v0.1
- files: 240
- edges: 48332
- stale: no

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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-173938-impact-orchestrator-lf固定.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 17:41:06 +09:00
- status: completed
- result: impact-orchestratorのlocks.jsonとwork card書き込みをLF固定にした。
- verified: PowerShell parser OK、Environment.NewLine/Set-Content残存なし、対象scriptにCRなし
- residual_risk: 既に過去に生成済みのwork cardは履歴として残るが、今後のregister/completeはLFで書く
- released_locks: 2
