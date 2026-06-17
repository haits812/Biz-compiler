# Work Card: 00-entry orchestrator output実行前提補強

- work_id: 20260617-201038-00-entry-orchestrator-output実行前提補強
- registered_at: 2026-06-17 20:10:38 +09:00
- kind: template
- state: completed
- executor: codex
- risk: medium
- lock_state: released-on-completed

## Intent

00-entry phase-orchestratorをoutput/Biz-*/00-entryで動かす前提に合わせ、phase-local必読ファイルをoutput側優先で扱う

## Impact

template/00-entry/phase-orchestrator.ps1、00-entry README、Hello-worldのtemplate asset一覧、work cardに効く。output側でのdispatch bundle内容に効く

## Touched Files
- template/00-entry/phase-orchestrator.ps1
- template/00-entry/README.md
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

- template/00-entry/phase-orchestrator.ps1
  - Hello-world.md:171
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:20
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:172
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:175
  - knowledge/journal/work/20260617-194104-00-entry-phase-orchestrator実装.md:214
  - template/00-entry/_context/README.md:9
  - template/00-entry/_context/README.md:23
  - template/00-entry/README.md:45
  - template/00-entry/README.md:65
  - template/00-entry/README.md:68
  - template/00-entry/README.md:73
  - template/00-entry/README.md:79
  - template/phase-local-missing.md:29
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
  - Hello-world.md:173
  - Hello-world.md:181
  - Hello-world.md:227
  - Hello-world.md:230
  - Hello-world.md:232
  - Hello-world.md:235
  - Hello-world.md:236
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

> Warnings
> - related file limit reached: 60

### Related Files
- AGENTS.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `AGENTS.md` at line 44
  - confidence: high
  - reason: repo-relative path reference
- COMPASS.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `COMPASS.md` at line 12
  - confidence: high
  - reason: repo-relative path reference
- README.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 19
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/README.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 12
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-compass-direction-packet-and-read-routing.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 44
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-development-memory-layout.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 25
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-hello-world-gate-natural-language-triggers.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 25
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-hello-world-gate-publish-and-skill-local-scripts.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-hello-world-gate.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-hello-world-invariant.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 14
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-repo-local-hello-world-gate-skill.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-root-readme-github-entry.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 10
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-14-soul-user-context.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 19
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-hello-world-file-name-hyphen.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 1
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-lexicon-initial-read-order.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 19
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-memory-boundary-and-pruning.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 8
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-mergegate-style-impact-orchestrator.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 27
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/decisions/2026-06-15-requirements-conditional-read-order.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/lexicon.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 31
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/README.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 35
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/artifact-placement.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 60
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/completion-criteria.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 39
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/phase-catalog.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 45
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/session-brief.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 55
  - confidence: high
  - reason: repo-relative path reference
- knowledge/docs/meta/subagent-brief.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 16
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/README.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 28
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/pending-applied/memory/20260614-211736-ontology-world-model-layer-as-biz-compiler-map.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 5
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-114127-mergegate�^ops��hooks-lock-completion�܂Ŋg��.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 19
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-145631-hello-world�t�@�C�������n�C�t���֕ύX.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 13
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-150433-sqlite-knowledge-search��ǉ�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-151815-python�����������O����.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-152307-knowledge-search���R����g���K�[�𖾋L����.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 20
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-153858-setup-md��ǉ�����.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 23
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-161029-repo-local-ops-readme�̓ǂݓ������Œ肷��.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-173024-skill-creator-gate���쐬����.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-175737-skill-creator-gate��skill�����݌v�𒼂�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 21
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-182040-opensquilla�R����writing-research-skill��ǉ�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 20
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-184153-empirical-prompt-tuning��repo-local-skill�֒ǉ�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 46
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200302-�E��ses�Ɩ��ϑ����^�t�@�[��memory�֎c��.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 44
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-200624-ai�l�ޔh����Ѓ��^�t�@�[��memory�֔��f.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 44
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-202309-biz-compiler���^�t�@�[��readme��agents�֔��f.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 47
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213041-contract-gate������������memory�֎c��.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 44
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-213818-contract-gate��phase���������Ƃ���memory�֒���.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 44
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-214043-readme�擪��ai�h����ЃC���t�H�O���t�B�b�N��ǉ�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-224041-recompile-lifecycle�̌�񂵔��f��memory�֋L�^.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 44
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-230123-phase-handoff-gate-policy-evidence-confidence-v0.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 49
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-231232-review�n���^�X�L����repo-local�̗p.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 24
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-232249-review-harness-quickstart-guide�폜.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 47
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-233010-review-agent-essence�����|�[�g�o�͉�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 46
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-233938-review�nrepo-local-skill�̐�������.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-234027-review�nskill-frontmatter�W����.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 31
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-234715-empirical-prompt-tuning���Ώ�������.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-234928-knowledge-curation���Ώ�������.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260615-235459-10-source-intake-phase-local-v0.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 29
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260616-000340-readme�֓y��C���t�H�O���t�B�b�N��ǉ�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 47
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260616-222504-clone-safe�ȃp�X�\�L�֏C��.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 17
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-005419-taint-lite���z��skill-gate�ƌ����֎c��.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 46
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-010415-code-impact�y�ʉi���O���t���j��memory�֎c��.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 46
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-011853-code-impact�y�ʉi���O���t��ǉ�.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 29
  - confidence: high
  - reason: repo-relative path reference
- knowledge/journal/work/20260617-014503-code-impact����ƃt���[�֎����A�g.md
  - depth: 1
  - via: Hello-world.md
  - edge: path-reference `Hello-world.md` at line 28
  - confidence: high
  - reason: repo-relative path reference

### Symbols And Keys
- `Add-ReviewCheck` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:262
- `Convert-MaterialRows` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:151
- `ConvertTo-RepoRelativePath` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:39
- `Find-FirstValue` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:273
- `Find-GateResult` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:281
- `Find-Terminality` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:296
- `Get-DispatchPacketText` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:179
- `Get-OutputDirectory` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:92
- `Get-PhaseDirectory` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:75
- `Get-RepoRoot` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:29
- `Get-RequiredFiles` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:117
- `Get-ScriptDirectory` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:24
- `Invoke-Help` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:538
- `Invoke-Review` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:304
- `Invoke-Start` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:188
- `Invoke-Status` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:489
- `New-MarkdownTable` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:164
- `Read-TextFileOrEmpty` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:61
- `Resolve-InputPath` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:52
- `Split-SemicolonList` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:69
- `Test-IsTemplatePhaseDir` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:84
- `Write-Or-Print` (symbol, define, high) - template/00-entry/phase-orchestrator.ps1:98
- `BaseDir` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:54
- `Checks` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:265
- `Columns` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:166
- `Content` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:101
- `Id` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:266
- `Items` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:153
- `Label` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:103
- `Path` (param, define, medium) - template/00-entry/phase-orchestrator.ps1:41

### Risk Hints
- Hello-world.md:322 - `external-call:requests.` (medium)
- Hello-world.md:324 - `external-call:requests.` (medium)
- template/00-entry/phase-orchestrator.ps1:114 - `file-write:WriteAllText` (medium)

### Validation Candidates
- `git diff --check`
- `.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 status`
- `$errors = $null; [System.Management.Automation.Language.Parser]::ParseFile("template\00-entry\phase-orchestrator.ps1", [ref]$null, [ref]$errors) | Out-Null; if ($errors.Count) { throw ($errors | Out-String) }`

### Index Status
- db: knowledge/.index/code-impact.sqlite
- generated_at: 2026-06-17T19:55:39+0900
- generator_version: code-impact-v0.1
- files: 250
- edges: 54887
- stale: no

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
- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "knowledge/journal/work/20260617-201038-00-entry-orchestrator-output実行前提補強.md" -Result "..." -Verified "..." -ResidualRisk "..."`

## Notes

- このファイルは作業ログであり、正本仕様ではない。
- 長期の採用理由は knowledge/docs/decisions/ へ移す。

## Completion Update

- completed_at: 2026-06-17 20:13:39 +09:00
- status: completed
- result: 00-entry phase-orchestratorの必読ファイル確認をrepo-root共通ファイルとphase-dirローカルファイルに分け、output/Biz-*/00-entryへ丸ごとコピーして実行する前提をREADMEに明記した。
- verified: PowerShell parser、outputコピーsmoke、git diff --check、CR/trailing whitespaceなし、code-impact rebuild/status stale no
- residual_risk: 業務フォルダ作成そのものを自動化するrunnerはまだ未実装。今回はコピー後の00-entry実行前提を補強。
- released_locks: 3
