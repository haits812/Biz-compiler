[CmdletBinding()]
param(
  [string]$PersonaRoot,
  [string]$FixtureRoot,
  [string]$OutDir,
  [switch]$StopOnFailure
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 3.0

$Utf8NoBom = [System.Text.UTF8Encoding]::new($false)

function Get-RepoRoot {
  try {
    $root = (& git rev-parse --show-toplevel 2>$null)
    if ($LASTEXITCODE -eq 0 -and $root) { return ($root | Select-Object -First 1) }
  } catch {
    # fall through
  }
  return (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
}

function Write-Utf8File {
  param([Parameter(Mandatory)][string]$Path, [Parameter(Mandatory)][string]$Text)
  $dir = Split-Path -Parent $Path
  if ($dir -and -not (Test-Path -LiteralPath $dir)) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
  }
  [System.IO.File]::WriteAllText($Path, $Text, $Utf8NoBom)
}

function Read-Utf8File {
  param([Parameter(Mandatory)][string]$Path)
  return [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
}

function Get-MarkdownSection {
  param([Parameter(Mandatory)][string]$Text, [Parameter(Mandatory)][string]$Heading)
  $escaped = [regex]::Escape($Heading)
  $match = [regex]::Match($Text, "(?ims)^##\s+$escaped\s*\r?\n(?<body>.*?)(?=^##\s+|\z)")
  if ($match.Success) { return $match.Groups['body'].Value.Trim() }
  return ''
}

function Get-TableValue {
  param([Parameter(Mandatory)][string]$Text, [Parameter(Mandatory)][string]$Field)
  $escaped = [regex]::Escape($Field)
  $match = [regex]::Match($Text, "(?im)^\|\s*$escaped\s*\|\s*(?<value>.*?)\s*\|\s*$")
  if (-not $match.Success) { return '' }
  return (($match.Groups['value'].Value.Trim() -replace '^`|`$', '').Trim())
}

function Escape-Cell {
  param([AllowNull()][string]$Value)
  if ($null -eq $Value -or $Value -eq '') { return 'n/a' }
  return (($Value -replace '\|', '/' -replace "`r?`n", ' ') -replace '\s+', ' ').Trim()
}

function First-OrFallback {
  param([object[]]$Values, [string]$Fallback)
  foreach ($value in $Values) {
    if (-not [string]::IsNullOrWhiteSpace([string]$value)) { return ([string]$value).Trim() }
  }
  return $Fallback
}

function Get-SourceItems {
  param([string]$SourceBehavior, [string[]]$FixturePaths)
  $items = New-Object System.Collections.Generic.List[string]
  if (@($FixturePaths).Count -gt 0) {
    foreach ($fixture in @($FixturePaths)) {
      $items.Add((Split-Path -Leaf $fixture)) | Out-Null
    }
  }
  $sourceLines = @($SourceBehavior -split "`r?`n" | ForEach-Object { $_.Trim() } | Where-Object {
    $_ -and $_ -notmatch '質問された時|出してよいsource候補|出せない理由|ここから使う'
  })
  foreach ($part in (($sourceLines -join '、') -split '[、,，]')) {
    $trimmed = $part.Trim()
    if ($trimmed) { $items.Add($trimmed) | Out-Null }
  }
  if ($items.Count -eq 0) {
    $items.Add('source holder') | Out-Null
    $items.Add('operation sample') | Out-Null
  }
  return @($items | Select-Object -Unique)
}

function Resolve-FixturePaths {
  param([string]$PersonaText, [string]$EvaluationRoot)
  $linked = Get-MarkdownSection -Text $PersonaText -Heading 'Linked Fixtures'
  $paths = New-Object System.Collections.Generic.List[string]
  foreach ($match in [regex]::Matches($linked, '`(?<path>[^`]+)`')) {
    $relative = $match.Groups['path'].Value
    if ($relative -eq 'なし') { continue }
    $full = Join-Path $EvaluationRoot $relative
    if (Test-Path -LiteralPath $full) { $paths.Add((Resolve-Path -LiteralPath $full).Path) | Out-Null }
  }
  return @($paths)
}

function Load-Personas {
  param([string]$Root, [string]$EvaluationRoot)
  $personaDirs = Get-ChildItem -LiteralPath $Root -Directory | Sort-Object Name
  $rows = foreach ($dir in $personaDirs) {
    $file = Join-Path $dir.FullName 'persona.md'
    if (-not (Test-Path -LiteralPath $file)) { continue }
    $text = Read-Utf8File -Path $file
    $sourceBehavior = Get-MarkdownSection -Text $text -Heading 'Source Behavior'
    $fixturePaths = Resolve-FixturePaths -PersonaText $text -EvaluationRoot $EvaluationRoot
    [pscustomobject]@{
      Id = Get-TableValue -Text $text -Field 'id'
      DirectoryName = $dir.Name
      File = $file
      Cluster = Get-TableValue -Text $text -Field 'cluster'
      Persona = Get-TableValue -Text $text -Field 'persona'
      DepartmentRole = Get-TableValue -Text $text -Field 'department_role'
      InitialTheme = Get-TableValue -Text $text -Field 'initial_theme'
      ExpectedGate = Get-TableValue -Text $text -Field '00_initial_expected_judgement'
      Lens = Get-TableValue -Text $text -Field '00_lens'
      SourceBehavior = $sourceBehavior
      FixturePaths = @($fixturePaths)
      SourceItems = @(Get-SourceItems -SourceBehavior $sourceBehavior -FixturePaths @($fixturePaths))
    }
  }
  return @($rows)
}

function Get-EntryType {
  param([string]$InitialTheme)
  if ($InitialTheme -match '(?i)new|新規|onboarding desk') { return 'new_work' }
  return 'existing_work'
}

function Get-WorkUnit {
  param([string]$InitialTheme)
  if ($InitialTheme -match '新規事業|事業|チーム|組織|program') { return 'business_program' }
  if ($InitialTheme -match '新規|desk|運用|workflow|フロー') { return 'workflow_or_operation' }
  return 'single_business'
}

function Get-DeliveryShape {
  param([string]$WorkUnit)
  if ($WorkUnit -eq 'business_program') { return 'multi_executor_team' }
  return 'single_executor'
}

function Get-SourcePosture {
  param($Persona)
  if ($Persona.Id -in @('30', '35', '36')) { return 'proxy_hearsay' }
  if ($Persona.Cluster -match '代理|伝聞') { return 'proxy_hearsay' }
  return 'first_party'
}

function Get-TwentyReadiness {
  param([string]$EntryType, [string]$WorkUnit, [string]$SourcePosture)
  if ($SourcePosture -eq 'proxy_hearsay' -and $EntryType -eq 'existing_work') { return 'requirements_candidate' }
  if ($WorkUnit -eq 'business_program') { return 'business_design_candidate' }
  if ($EntryType -eq 'new_work') { return 'requirements_candidate' }
  return 'as_is_decompose'
}

function Build-00-Handoff {
  param([Parameter(Mandatory)]$Persona, [Parameter(Mandatory)][string]$Gate)
  $entryType = Get-EntryType -InitialTheme $Persona.InitialTheme
  $workUnit = Get-WorkUnit -InitialTheme $Persona.InitialTheme
  $deliveryShape = Get-DeliveryShape -WorkUnit $workUnit
  $sourcePosture = Get-SourcePosture -Persona $Persona
  $twentyReadiness = Get-TwentyReadiness -EntryType $entryType -WorkUnit $workUnit -SourcePosture $sourcePosture
  $source1 = Escape-Cell (First-OrFallback -Values $Persona.SourceItems -Fallback 'source holder')
  $source2 = Escape-Cell (First-OrFallback -Values @($Persona.SourceItems | Select-Object -Skip 1) -Fallback 'operation sample')
  $target = Escape-Cell $Persona.InitialTheme
  $department = Escape-Cell $Persona.DepartmentRole
  $riskRows = if ($Gate -eq 'pass') {
@"
| external impact | no | 00では外部作用を決めない |
| sensitive data | no | 10でsource利用許可を見る |
| irreversible action | no | 実行や更新は対象外 |
| approval need | no | 最初のscopeでは承認代行をしない |
| authorization unclear | no | source holder候補が見える |
| abuse or deception signal | no | 通常業務相談として扱える |
"@
  } else {
@"
| external impact | unknown | 10で外部連絡や前後工程を確認する |
| sensitive data | unknown | 10でデータ種別と利用許可を確認する |
| irreversible action | no | 00では実行や更新を決めない |
| approval need | unknown | 10で承認者と境界を確認する |
| authorization unclear | unknown | source holder / ownerを10で確認する |
| abuse or deception signal | no | stop相当の明確な悪用は見えない |
"@
  }
  $deferContract = ''
  if ($Gate -eq 'defer') {
    $deferContract = @"

## Defer Contract

| id | if_unresolved | return_to_phase | must_resolve_before |
|---|---|---|---|
| DC-001 | source holder / owner / permission が10で解けない | 00-entry | 20-decompose-encrs |
"@
  }
  return @"
# 00-entry Handoff

## Packet

| Field | Value |
|---|---|
| phase_id | 00-entry |
| entry_type | $entryType |
| entry_gate_result | $Gate |
| gate_result | $Gate |
| terminality | terminal |
| persona_id | $($Persona.Id) |
| work_unit | $workUnit |
| delivery_shape | $deliveryShape |
| source_posture | $sourcePosture |
| 20_readiness | $twentyReadiness |
| route_confirmed_by_requester | yes |
| route_confirmation_source | requester_answer |
| route_delta_after_confirmation | none |

## Scope Summary

| Field | Value |
|---|---|
| target_statement | $target |
| department_role | $department |
| one_sentence | $target を業務候補として扱い、10でsource実物とownerを確認する |
| in_scope | source候補、owner候補、初期riskを10へ渡す |
| out_of_scope | 実行、更新、送信、承認代行、後続phaseの確定 |
| undecided_scope | 実運用差分、例外、差戻し、source利用許可 |

## Source Candidates For 10

| source_candidate_id | source | 10_initial_status | owner_hint | reason |
|---|---|---|---|---|
| SC-001 | $source1 | target | $department | まず確認する主要source候補 |
| SC-002 | $source2 | collected + not_reviewed | $department | 補助source候補 |


## 20 Readiness

| Field | Value |
|---|---|
| work_unit | $workUnit |
| delivery_shape | $deliveryShape |
| source_posture | $sourcePosture |
| 20_readiness | $twentyReadiness |
| route_note | as_is_decomposeは既存業務の観測候補、requirements_candidateは新規要求候補、business_design_candidateは新規事業プログラム構想として20へ渡す |

## Route Confirmation

| Field | Value |
|---|---|
| route_flags_initialized | yes |
| route_flag_basis | requester_statement |
| route_confirmation_question | 今ある作業そのものか、新しく業務や事業の形を作る話かを確認した |
| route_confirmed_by_requester | yes |
| route_confirmation_answer_or_evidence | persona initial theme and first answer confirm this route |
| route_delta_after_confirmation | none |

## Initial Risk Hints

$riskRows
## Unknowns For 10

| id | unknown | first_check |
|---|---|---|
| U-001 | source holder / owner / permission | source holderへ確認 |
| U-002 | 実運用との差分、例外、差戻し履歴 | source実物と関係者へ確認 |

## Low Confidence Hypotheses For 10

| id | hypothesis | confidence | reason |
|---|---|---|---|
| H-001 | 初回テーマから業務候補は切れるが、実運用一致は未確認 | low | 00ではsource確認前の仮説に留める |

## Later Phase Notes

| id | phase | note |
|---|---|---|
| L-001 | 20-decompose-encrs | 10で観測できたsourceからAs-Is候補を分ける |
| L-002 | 30-route-executor | 実行分担や自動化範囲はまだ決めない |$deferContract
"@
}

function Build-00-TerminalResult {
  param([Parameter(Mandatory)]$Persona)
  $gate = $Persona.ExpectedGate
  $target = Escape-Cell $Persona.InitialTheme
  $source1 = Escape-Cell (First-OrFallback -Values $Persona.SourceItems -Fallback 'source holder')
  $source2 = Escape-Cell (First-OrFallback -Values @($Persona.SourceItems | Select-Object -Skip 1) -Fallback 'operation sample')
  $entryType = Get-EntryType -InitialTheme $Persona.InitialTheme

  if ($gate -eq 'stop') {
    $stopReasonType = if ($Persona.Id -eq '05' -or $target -match '口座|承認迂回|同意なし|vendor') { 'unsafe_or_unauthorized' } else { 'benign_non_bizcompiler' }
    return @"
# 00-entry synthetic persona smoke result

preflight確認: 必読ファイル read files completed.

| Field | Value |
|---|---|
| entry_type | unclear |
| entry_gate_result | stop |
| gate_result | stop |
| terminality | terminal |
| target_statement | $target |
| source_candidates | stop decision uses source candidates: $source1 / $source2 |
| low confidence | none needed for stop |
| risk | stop_reason_type checked |
| later_phase | none |
| stop_reason_type | $stopReasonType |

Stop reason: Biz-compilerの00-10通し対象として進めない。実行案や迂回手順は出さず、ここで止める。
"@
  }

  if ($gate -eq 'rework') {
    return @"
# 00-entry synthetic persona smoke result

preflight確認: 必読ファイル read files completed.

interaction_state: initial_request_only = false; user_answer_count = 1; material_evidence_count = 0; asked_question_count = 1

| Field | Value |
|---|---|
| entry_type | unclear |
| entry_gate_result | rework |
| gate_result | rework |
| terminality | non-terminal loop |
| target_statement | $target |
| source_candidates | source候補は $source1 / $source2 だが、対象業務またはsource holderがまだ絞れていない |
| low confidence | 候補は low confidence のため00で追加確認する |
| risk | owner/source holder/permission が未確定 |
| later_phase | 10へ進めず00内で確認する |

次の00質問: まず1つだけ、実際に困っている業務を1つに絞り、その実作業者または資料名を教えてください。
"@
  }

  $handoff = Build-00-Handoff -Persona $Persona -Gate $gate
  return @"
# 00-entry synthetic persona smoke result

preflight確認: 必読ファイル read files completed.

interaction_state: initial_request_only = false; user_answer_count = 1; material_evidence_count = 1; asked_question_count = 1

| Field | Value |
|---|---|
| entry_type | $entryType |
| entry_gate_result | $gate |
| gate_result | $gate |
| terminality | terminal |
| target_statement | $target |
| source_candidates | SC-001 $source1 / SC-002 $source2 |
| low confidence | source確認前の仮説は low confidence として分離 |
| risk | initial risk hints recorded |
| later_phase | later_phase notes are separated |

<!-- 00_HANDOFF_START -->
$handoff
<!-- 00_HANDOFF_END -->
"@
}

function Build-10-Handoff {
  param([Parameter(Mandatory)]$Persona, [Parameter(Mandatory)][string]$Gate)
  $target = Escape-Cell $Persona.InitialTheme
  $entryType = Get-EntryType -InitialTheme $Persona.InitialTheme
  $workUnit = Get-WorkUnit -InitialTheme $Persona.InitialTheme
  $deliveryShape = Get-DeliveryShape -WorkUnit $workUnit
  $sourcePosture = Get-SourcePosture -Persona $Persona
  $twentyReadiness = Get-TwentyReadiness -EntryType $entryType -WorkUnit $workUnit -SourcePosture $sourcePosture
  $asIsObserved = if ($twentyReadiness -eq 'as_is_decompose') { 'true' } else { 'false' }
  $inputContract = if ($twentyReadiness -eq 'as_is_decompose') { 'observed_as_is_sources' } elseif ($twentyReadiness -eq 'business_design_candidate') { 'business_program_hypotheses' } else { 'requirements_candidate_sources' }
  $source1 = Escape-Cell (First-OrFallback -Values $Persona.SourceItems -Fallback 'source holder')
  $source2 = Escape-Cell (First-OrFallback -Values @($Persona.SourceItems | Select-Object -Skip 1) -Fallback 'operation sample')
  $deferred = if ($Gate -eq 'defer') {
@"
| C-101 | 実運用一致、owner承認、permissionは未確認 | why_20_can_continue: 20で未確認claimとして扱える | next_check: 追加sourceとowner確認 | must_resolve_before: 30-route-executor |
"@
  } else {
    '| none | none | none | none | none |'
  }
  return @"
# 10-source-intake Handoff

## Packet

| Field | Value |
|---|---|
| phase_id | 10-source-intake |
| source_gate_result | $Gate |
| gate_result | $Gate |
| terminality | terminal |
| persona_id | $($Persona.Id) |
| entry_type | $entryType |
| work_unit | $workUnit |
| delivery_shape | $deliveryShape |
| source_posture | $sourcePosture |
| 20_readiness | $twentyReadiness |
| route_confirmed_by_requester | yes |
| route_confirmation_source | 00_handoff |
| route_delta_from_00 | none |

## Route Confirmation

| Field | Value |
|---|---|
| route_rechecked_in_10 | yes |
| route_confirmation_source | 00_handoff |
| route_delta_from_00 | none |
| route_delta_reason | 10 source intake kept the 00 route flags for this smoke case |

## Source Summary

| source_id | source | status | source_class | owner_hint |
|---|---|---|---|---|
| S-001 | $source1 | reviewed | primary | source_holder |
| S-002 | $source2 | collected | secondary | owner |

## Observed Facts For 20

| claim_id | claim_type | claim | source_id | provenance | confidence |
|---|---|---|---|---|---|
| C-001 | observed_fact | $target の業務候補と主要source候補が特定された | S-001 | observed | high |

## Person Explanations For 20

| claim_id | claim_type | claim | source_id | provenance | confidence |
|---|---|---|---|---|---|
| C-002 | person_explanation | 依頼者は $target を改善対象として説明している | S-002 | hypothesized | low |

## Hypotheses / Unconfirmed

| claim_id | claim_type | claim | source_id | provenance | confidence |
|---|---|---|---|---|---|
| C-101 | hypothesis | 実運用差分、例外、差戻し履歴は追加確認が必要 | S-002 | hypothesized | low |

## Deferred Claims For 20

| claim_id | deferred_claim | why_20_can_continue | next_check | must_resolve_before |
|---|---|---|---|---|
$deferred

## 20 Readiness

| Field | Value |
|---|---|
| 20_readiness | $twentyReadiness |
| 20_input_contract | $inputContract |
| as_is_observed | $asIsObserved |
| work_unit | $workUnit |
| delivery_shape | $deliveryShape |
| source_posture | $sourcePosture |
| must_not_do_in_20 | executor routing, automation scope, team staffing are later-phase topics |

## Reviewer Notes

Action: 20へ渡す。source由来claimと未確認claimを分離済み。10へ戻す条件はsource holderが否定した場合。

## Scope / Gate Notes

10ではsource intakeまで。実行分担、IR、consent、validationはまだ固定しない。

- external candidate: 外部連絡や社外影響は候補として残すだけ。
- sensitive candidate: 個人情報、契約、金額、顧客データは候補として残すだけ。
- out-of-scope: 実行、更新、送信、承認代行、後続phaseの確定。
"@
}

function Build-10-Result {
  param([Parameter(Mandatory)]$Persona, [Parameter(Mandatory)][string]$Gate)
  $target = Escape-Cell $Persona.InitialTheme
  $source1 = Escape-Cell (First-OrFallback -Values $Persona.SourceItems -Fallback 'source holder')
  $source2 = Escape-Cell (First-OrFallback -Values @($Persona.SourceItems | Select-Object -Skip 1) -Fallback 'operation sample')
  $handoff = Build-10-Handoff -Persona $Persona -Gate $Gate
  return @"
# 10-source-intake synthetic persona smoke result

preflight確認: 必読ファイル read files completed.

| Field | Value |
|---|---|
| source_gate_result | $Gate |
| gate_result | $Gate |
| terminality | terminal |
| source_intake_interaction | present |
| question_turn_count | 1 |
| material_evidence_count | 1 |
| source_contact_attempt_count | 1 |
| source_gap_policy | 20へ渡すdeferと10で追加観測する不足を分ける |
| source_inventory | S-001 / S-002 |
| permission | owner / source_holder / approver / permission checked at intake level |
| counter_evidence | near-miss, 例外, 差戻しは未収集として明示 |
| deferred_items | C-101 if defer |

<!-- 10_SOURCE_INVENTORY_START -->
# Source Inventory

| source_id | source | status | source_class | owner_hint | permission_status |
|---|---|---|---|---|---|
| S-001 | $source1 | reviewed | primary | source_holder | 確認対象 |
| S-002 | $source2 | collected | secondary | owner | 確認対象 |
| S-003 | 依頼者説明 | collected | assumption | requester | 確認対象 |
<!-- 10_SOURCE_INVENTORY_END -->

<!-- 10_INTAKE_LOG_START -->
# Intake Log

| id | source_id | action | note |
|---|---|---|---|
| L-001 | S-001 | reviewed | 主要source候補を10で確認対象化 |
| L-002 | S-002 | collected | 補助source候補を20の材料へ分離 |
| L-003 | S-003 | observed | 依頼者説明はsource実物と分けた |
<!-- 10_INTAKE_LOG_END -->

<!-- 10_FACT_REGISTER_START -->
# Fact Register

| claim_id | claim_type | claim | source_id | provenance | confidence |
|---|---|---|---|---|---|
| C-001 | observed_fact | $target のsource候補がS-001/S-002として整理された | S-001 | observed | high |
| C-002 | person_explanation | 依頼者は $target を改善対象として説明している | S-003 | hypothesized | low |
| C-101 | hypothesis | 実運用差分、例外、差戻し履歴は追加確認が必要 | S-002 | hypothesized | low |
| C-102 | unconfirmed | owner/permission/approverの最終確認は未完了 | S-002 | hypothesized | low |
<!-- 10_FACT_REGISTER_END -->

<!-- 10_HANDOFF_START -->
$handoff
<!-- 10_HANDOFF_END -->
"@
}

function Get-PowerShellExecutable {
  $candidates = @(
    (Join-Path $PSHOME 'powershell.exe'),
    (Join-Path $PSHOME 'pwsh.exe'),
    'pwsh',
    'powershell'
  )
  foreach ($candidate in $candidates) {
    $command = Get-Command $candidate -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
  }
  throw 'PowerShell executable not found for child phase invocation'
}

function Invoke-PhaseScript {
  param([Parameter(Mandatory)][string]$ScriptPath, [Parameter(Mandatory)][string[]]$Arguments, [Parameter(Mandatory)][string]$Label)
  $global:LASTEXITCODE = 0
  $exe = Get-PowerShellExecutable
  $processArgs = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $ScriptPath) + @($Arguments)
  try {
    $output = & $exe @processArgs 2>&1 | ForEach-Object { $_.ToString() }
  } catch {
    throw "$Label failed: $($_.Exception.Message)"
  }
  if ($LASTEXITCODE -ne 0) {
    throw "$Label exited with code $LASTEXITCODE`n$($output -join "`n")"
  }
  return ($output -join "`n")
}

function Get-LatestJson {
  param([Parameter(Mandatory)][string]$Directory, [Parameter(Mandatory)][string]$Pattern)
  $file = Get-ChildItem -LiteralPath $Directory -Filter $Pattern | Sort-Object LastWriteTimeUtc -Descending | Select-Object -First 1
  if (-not $file) { throw "review json not found: $Directory / $Pattern" }
  return (Read-Utf8File -Path $file.FullName | ConvertFrom-Json)
}

function Add-Failure {
  param([System.Collections.Generic.List[string]]$List, [string]$Message)
  if (-not [string]::IsNullOrWhiteSpace($Message)) { $List.Add($Message) | Out-Null }
}

function Add-RouteFieldFailure {
  param(
    [Parameter(Mandatory)][AllowEmptyCollection()][System.Collections.Generic.List[string]]$Failures,
    [Parameter(Mandatory)][string]$Text,
    [Parameter(Mandatory)][string]$Field,
    [Parameter(Mandatory)][string]$Expected,
    [Parameter(Mandatory)][string]$Context
  )
  $fieldPattern = [regex]::Escape($Field)
  $expectedPattern = [regex]::Escape($Expected)
  $tickPattern = [regex]::Escape([string][char]96)
  $pattern = "(?im)^\|\s*$fieldPattern\s*\|\s*(?:$tickPattern)?$expectedPattern(?:$tickPattern)?\s*\|"
  if ($Text -notmatch $pattern) {
    Add-Failure $Failures "$Context route expected $Field=$Expected"
  }
}

function Assert-HandoffRoute {
  param(
    [Parameter(Mandatory)][AllowEmptyCollection()][System.Collections.Generic.List[string]]$Failures,
    [Parameter(Mandatory)][string]$Text,
    [Parameter(Mandatory)][string]$Context,
    [Parameter(Mandatory)][string]$EntryType,
    [Parameter(Mandatory)][string]$WorkUnit,
    [Parameter(Mandatory)][string]$DeliveryShape,
    [Parameter(Mandatory)][string]$SourcePosture,
    [Parameter(Mandatory)][string]$TwentyReadiness
  )
  Add-RouteFieldFailure -Failures $Failures -Text $Text -Field 'entry_type' -Expected $EntryType -Context $Context
  Add-RouteFieldFailure -Failures $Failures -Text $Text -Field 'work_unit' -Expected $WorkUnit -Context $Context
  Add-RouteFieldFailure -Failures $Failures -Text $Text -Field 'delivery_shape' -Expected $DeliveryShape -Context $Context
  Add-RouteFieldFailure -Failures $Failures -Text $Text -Field 'source_posture' -Expected $SourcePosture -Context $Context
  Add-RouteFieldFailure -Failures $Failures -Text $Text -Field '20_readiness' -Expected $TwentyReadiness -Context $Context
  Add-RouteFieldFailure -Failures $Failures -Text $Text -Field 'route_confirmed_by_requester' -Expected 'yes' -Context $Context
}

function Run-PersonaSmoke {
  param([Parameter(Mandatory)]$Persona, [Parameter(Mandatory)][string]$BaseOutDir, [Parameter(Mandatory)][string]$RepoRoot)

  $caseDir = Join-Path $BaseOutDir ("p{0}-{1}" -f $Persona.Id, $Persona.DirectoryName)
  New-Item -ItemType Directory -Force -Path $caseDir | Out-Null
  $failures = New-Object System.Collections.Generic.List[string]
  $expected = $Persona.ExpectedGate
  $expectedEntryType = Get-EntryType -InitialTheme $Persona.InitialTheme
  $expectedWorkUnit = Get-WorkUnit -InitialTheme $Persona.InitialTheme
  $expectedDeliveryShape = Get-DeliveryShape -WorkUnit $expectedWorkUnit
  $expectedSourcePosture = Get-SourcePosture -Persona $Persona
  $expectedTwentyReadiness = Get-TwentyReadiness -EntryType $expectedEntryType -WorkUnit $expectedWorkUnit -SourcePosture $expectedSourcePosture
  $expected00 = switch ($expected) {
    'pass' { 'accept_pass' }
    'defer' { 'accept_defer' }
    'rework' { 'ask_rework' }
    'stop' { 'accept_stop' }
    default { 'unknown' }
  }

  $result00 = Build-00-TerminalResult -Persona $Persona
  $result00File = Join-Path $caseDir '00-subagent-result.md'
  Write-Utf8File -Path $result00File -Text $result00

  $script00 = Join-Path $RepoRoot 'template/00-entry/phase-orchestrator.ps1'
  $review00Dir = Join-Path $caseDir '00-review'
  New-Item -ItemType Directory -Force -Path $review00Dir | Out-Null
  Invoke-PhaseScript -ScriptPath $script00 -Arguments @('review', '-SubagentResultFile', $result00File, '-OutDir', $review00Dir, '-Format', 'json') -Label "00 review $($Persona.Id)" | Out-Null
  $review00 = Get-LatestJson -Directory $review00Dir -Pattern '00-entry-review-*.json'

  if ($review00.reviewer_result -ne $expected00) {
    Add-Failure $failures "00 reviewer_result expected $expected00, got $($review00.reviewer_result)"
  }

  $review00Fails = @($review00.checks | Where-Object { $_.status -eq 'fail' })
  if ($review00Fails.Count -gt 0) {
    Add-Failure $failures ("00 failed checks: " + (($review00Fails | ForEach-Object { $_.id }) -join ', '))
  }

  $review10 = $null
  $expected10 = ''
  $advancedTo10 = $false
  $finalizedFiles = @()

  if ($expected -eq 'pass' -or $expected -eq 'defer') {
    $phase00Out = Join-Path $caseDir 'output/00-entry'
    Invoke-PhaseScript -ScriptPath $script00 -Arguments @('finalize', '-SubagentResultFile', $result00File, '-TargetDir', $phase00Out) -Label "00 finalize $($Persona.Id)" | Out-Null
    $handoff00 = Join-Path $phase00Out 'handoff.md'
    if (-not (Test-Path -LiteralPath $handoff00)) { Add-Failure $failures '00 finalize did not write handoff.md' }
    else {
      $finalizedFiles += $handoff00
      Assert-HandoffRoute -Failures $failures -Text (Read-Utf8File -Path $handoff00) -Context '00 handoff' -EntryType $expectedEntryType -WorkUnit $expectedWorkUnit -DeliveryShape $expectedDeliveryShape -SourcePosture $expectedSourcePosture -TwentyReadiness $expectedTwentyReadiness
    }

    $script10 = Join-Path $RepoRoot 'template/10-source-intake/phase-orchestrator.ps1'
    $start10Dir = Join-Path $caseDir '10-start'
    Invoke-PhaseScript -ScriptPath $script10 -Arguments @('start', '-EntryHandoffFile', $handoff00, '-OutDir', $start10Dir) -Label "10 start $($Persona.Id)" | Out-Null
    if (-not (Get-ChildItem -LiteralPath $start10Dir -Filter '10-source-intake-dispatch-*.md' | Select-Object -First 1)) {
      Add-Failure $failures '10 start did not write dispatch packet'
    }

    $gate10 = $expected
    $expected10 = if ($gate10 -eq 'pass') { 'accept_pass' } else { 'accept_defer' }
    $result10 = Build-10-Result -Persona $Persona -Gate $gate10
    $result10File = Join-Path $caseDir '10-subagent-result.md'
    Write-Utf8File -Path $result10File -Text $result10

    $review10Dir = Join-Path $caseDir '10-review'
    New-Item -ItemType Directory -Force -Path $review10Dir | Out-Null
    Invoke-PhaseScript -ScriptPath $script10 -Arguments @('review', '-SubagentResultFile', $result10File, '-OutDir', $review10Dir, '-Format', 'json') -Label "10 review $($Persona.Id)" | Out-Null
    $review10 = Get-LatestJson -Directory $review10Dir -Pattern '10-source-intake-review-*.json'
    if ($review10.reviewer_result -ne $expected10) {
      Add-Failure $failures "10 reviewer_result expected $expected10, got $($review10.reviewer_result)"
    }
    $review10Fails = @($review10.checks | Where-Object { $_.status -eq 'fail' })
    if ($review10Fails.Count -gt 0) {
      Add-Failure $failures ("10 failed checks: " + (($review10Fails | ForEach-Object { $_.id }) -join ', '))
    }

    $phase10Out = Join-Path $caseDir 'output/10-source-intake'
    Invoke-PhaseScript -ScriptPath $script10 -Arguments @('finalize', '-SubagentResultFile', $result10File, '-TargetDir', $phase10Out) -Label "10 finalize $($Persona.Id)" | Out-Null
    foreach ($relative in @('handoff.md', 'artifacts/source-inventory.md', 'artifacts/intake-log.md', 'artifacts/fact-register.md')) {
      $file = Join-Path $phase10Out $relative
      if (-not (Test-Path -LiteralPath $file)) { Add-Failure $failures "10 finalize missing $relative" }
      else { $finalizedFiles += $file }
    }
    $handoff10 = Join-Path $phase10Out 'handoff.md'
    if (Test-Path -LiteralPath $handoff10) {
      Assert-HandoffRoute -Failures $failures -Text (Read-Utf8File -Path $handoff10) -Context '10 handoff' -EntryType $expectedEntryType -WorkUnit $expectedWorkUnit -DeliveryShape $expectedDeliveryShape -SourcePosture $expectedSourcePosture -TwentyReadiness $expectedTwentyReadiness
    }
    $advancedTo10 = $true
  }

  return [pscustomobject]@{
    id = $Persona.Id
    persona = $Persona.Persona
    directory = $Persona.DirectoryName
    expected_gate = $expected
    expected_00_reviewer = $expected00
    actual_00_reviewer = $review00.reviewer_result
    expected_10_reviewer = $expected10
    actual_10_reviewer = if ($review10) { $review10.reviewer_result } else { '' }
    advanced_to_10 = $advancedTo10
    status = if ($failures.Count -eq 0) { 'pass' } else { 'fail' }
    failures = @($failures.ToArray())
    case_dir = $caseDir
    finalized_files = @($finalizedFiles)
  }
}

function Write-Report {
  param([Parameter(Mandatory)][object[]]$Results, [Parameter(Mandatory)][string]$ReportPath, [Parameter(Mandatory)][string]$JsonPath)
  $total = $Results.Count
  $passed = @($Results | Where-Object { $_.status -eq 'pass' }).Count
  $failed = $total - $passed
  $gateSummary = $Results | Group-Object expected_gate | Sort-Object Name | ForEach-Object { "| $($_.Name) | $($_.Count) |" }
  $rows = foreach ($r in $Results) {
    $failureText = if (@($r.failures).Count -gt 0) { Escape-Cell ((@($r.failures)) -join '; ') } else { '' }
    "| $($r.id) | $(Escape-Cell $r.persona) | $($r.expected_gate) | $($r.actual_00_reviewer) | $($r.actual_10_reviewer) | $($r.advanced_to_10) | $($r.status) | $failureText |"
  }
  $failedDetails = foreach ($r in ($Results | Where-Object { $_.status -eq 'fail' })) {
    "- $($r.id) $($r.persona): $((@($r.failures)) -join '; ')"
  }
  if (-not $failedDetails) { $failedDetails = @('- none') }

  $content = @"
# 00-10 Persona Smoke Report

| Field | Value |
|---|---|
| total | $total |
| passed | $passed |
| failed | $failed |
| json | $JsonPath |

## Gate Summary

| expected_gate | count |
|---|---:|
$($gateSummary -join "`n")

## Results

| id | persona | expected_gate | 00 reviewer | 10 reviewer | advanced_to_10 | status | failures |
|---:|---|---|---|---|---|---|---|
$($rows -join "`n")

## Failed Details

$($failedDetails -join "`n")

## Scope

This runner is deterministic smoke coverage. It exercises the repo-local 00-entry and 10-source-intake phase orchestrators with persona-derived synthetic results. It does not replace paired subagent conversation evaluation.
"@
  Write-Utf8File -Path $ReportPath -Text $content
  Write-Utf8File -Path $JsonPath -Text (($Results | ConvertTo-Json -Depth 10))
}

$repoRoot = Get-RepoRoot
$evaluationRoot = Join-Path $repoRoot 'template/_shared/evaluation'
if (-not $PersonaRoot) { $PersonaRoot = Join-Path $evaluationRoot 'personas' }
if (-not $FixtureRoot) { $FixtureRoot = Join-Path $evaluationRoot 'fixtures/upfront-existing-materials' }
if (-not $OutDir) {
  $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
  $OutDir = Join-Path ([System.IO.Path]::GetTempPath()) "biz-compiler-00-10-persona-smoke-$stamp"
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$personas = Load-Personas -Root $PersonaRoot -EvaluationRoot $evaluationRoot
if ($personas.Count -eq 0) { throw "No personas found under $PersonaRoot" }

$results = New-Object System.Collections.Generic.List[object]
foreach ($persona in $personas) {
  try {
    $result = Run-PersonaSmoke -Persona $persona -BaseOutDir $OutDir -RepoRoot $repoRoot
    $results.Add($result) | Out-Null
    $line = "{0}: {1} 00={2} 10={3}" -f $result.id, $result.status, $result.actual_00_reviewer, $result.actual_10_reviewer
    Write-Host $line
    if ($StopOnFailure -and $result.status -ne 'pass') { break }
  } catch {
    $failed = [pscustomobject]@{
      id = $persona.Id
      persona = $persona.Persona
      directory = $persona.DirectoryName
      expected_gate = $persona.ExpectedGate
      expected_00_reviewer = ''
      actual_00_reviewer = ''
      expected_10_reviewer = ''
      actual_10_reviewer = ''
      advanced_to_10 = $false
      status = 'fail'
      failures = @($_.Exception.Message)
      case_dir = Join-Path $OutDir ("p{0}-{1}" -f $persona.Id, $persona.DirectoryName)
      finalized_files = @()
    }
    $results.Add($failed) | Out-Null
    Write-Host ("{0}: fail {1}" -f $persona.Id, $_.Exception.Message)
    if ($StopOnFailure) { break }
  }
}

$reportPath = Join-Path $OutDir '00-10-persona-smoke-report.md'
$jsonPath = Join-Path $OutDir '00-10-persona-smoke-results.json'
$resultsArray = @($results.ToArray())
Write-Report -Results $resultsArray -ReportPath $reportPath -JsonPath $jsonPath

$failedCount = @($resultsArray | Where-Object { $_.status -ne 'pass' }).Count
Write-Host "Report: $reportPath"
Write-Host "JSON: $jsonPath"
Write-Host ("Summary: {0}/{1} passed" -f ($resultsArray.Count - $failedCount), $resultsArray.Count)

if ($failedCount -gt 0) {
  exit 1
}
