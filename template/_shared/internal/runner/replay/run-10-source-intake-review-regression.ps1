[CmdletBinding()]
param(
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
  if ($dir -and -not (Test-Path -LiteralPath $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  [System.IO.File]::WriteAllText($Path, $Text.TrimEnd() + "`n", $Utf8NoBom)
}

function Read-Utf8File {
  param([Parameter(Mandatory)][string]$Path)
  return [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
}

function Get-PowerShellExecutable {
  $candidates = @((Join-Path $PSHOME 'powershell.exe'), (Join-Path $PSHOME 'pwsh.exe'), 'pwsh', 'powershell')
  foreach ($candidate in $candidates) {
    $command = Get-Command $candidate -ErrorAction SilentlyContinue
    if ($command) { return $command.Source }
  }
  throw 'PowerShell executable not found'
}

function Invoke-PhaseScript {
  param([Parameter(Mandatory)][string]$ScriptPath, [Parameter(Mandatory)][string[]]$Arguments, [Parameter(Mandatory)][string]$Label)
  $global:LASTEXITCODE = 0
  $exe = Get-PowerShellExecutable
  $processArgs = @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', $ScriptPath) + @($Arguments)
  try { $output = & $exe @processArgs 2>&1 | ForEach-Object { $_.ToString() } }
  catch { throw "$Label failed: $($_.Exception.Message)" }
  if ($LASTEXITCODE -ne 0) { throw "$Label exited with code $LASTEXITCODE`n$($output -join "`n")" }
  return ($output -join "`n")
}

function Get-LatestJson {
  param([Parameter(Mandatory)][string]$Directory, [Parameter(Mandatory)][string]$Pattern)
  $file = Get-ChildItem -LiteralPath $Directory -Filter $Pattern | Sort-Object LastWriteTimeUtc -Descending | Select-Object -First 1
  if (-not $file) { throw "review json not found: $Directory / $Pattern" }
  return (Read-Utf8File -Path $file.FullName | ConvertFrom-Json)
}

function New-Good10Result {
  param(
    [ValidateSet('pass','defer')][string]$Gate = 'defer',
    [switch]$OmitInteraction,
    [int]$QuestionTurnCount = 1,
    [int]$MaterialEvidenceCount = 1,
    [int]$SourceContactAttemptCount = 1,
    [string]$PersonExplanationProvenance = 'hypothesized',
    [string]$UnconfirmedProvenance = 'hypothesized'
  )
  $interaction = ''
  if (-not $OmitInteraction) {
    $interaction = @"
| source_intake_interaction | present |
| question_turn_count | $QuestionTurnCount |
| material_evidence_count | $MaterialEvidenceCount |
| source_contact_attempt_count | $SourceContactAttemptCount |
| source_gap_policy | 20へ渡すdeferと10で追加観測する不足を分ける |
"@
  }
  $deferred = if ($Gate -eq 'defer') {
@"
| C-003 | owner/permission未確認 | low | why_20_can_continue: 20で候補分解だけなら可能 | next_check: owner確認 | must_resolve_before: 30-route-executor |
"@
  } else {
    '| none | none | none | none | none | none |'
  }
  return @"
# 10-source-intake regression fixture

preflight確認: 必読ファイル read files completed.

| Field | Value |
|---|---|
| source_gate_result | $Gate |
| gate_result | $Gate |
| terminality | terminal |
$interaction| source_inventory | S-001 / S-002 |
| permission | owner / source_holder / approver / permission checked at intake level |
| counter_evidence | near-miss, 例外, 差戻しは未収集として明示 |
| deferred_items | C-003 if defer |

<!-- 10_SOURCE_INVENTORY_START -->
# Source Inventory

| source_id | source_name | status | source_class | source_holder | owner | permission_status | notes |
|---|---|---|---|---|---|---|---|
| S-001 | sample procedure | reviewed | primary | ops lead | ops owner | confirmed | claimへ接続済み |
| S-002 | requester explanation | collected | assumption | requester | ops owner | unknown | 本人説明として分離 |
<!-- 10_SOURCE_INVENTORY_END -->

<!-- 10_INTAKE_LOG_START -->
# Intake Log

| event_id | source_id | action | observation | actor | timestamp_or_order | notes |
|---|---|---|---|---|---|---|
| I-001 | S-001 | reviewed | 手順資料を確認 | 10担当 | 1 | source_idに接続 |
| I-002 | S-002 | asked | requesterへsource holderを確認 | 10担当 | 2 | owner/permissionは未解決 |

counter_evidence: none_observed. near-miss、差戻し、例外は未確認。
<!-- 10_INTAKE_LOG_END -->

<!-- 10_FACT_REGISTER_START -->
# Fact Register

| claim_id | claim_type | statement | source_id | provenance | confidence | used_by_20 | notes |
|---|---|---|---|---|---|---|---|
| C-001 | observed_fact | sample procedure contains the target workflow outline | S-001 | observed | medium | yes | 資料本文として観測 |
| C-002 | person_explanation | requester says ops lead is the likely owner | S-002 | $PersonExplanationProvenance | low | yes | 本人説明として分離 |
| C-003 | unconfirmed | owner approval and source permission are unresolved | S-002 | $UnconfirmedProvenance | low | yes | 30前に解く |
<!-- 10_FACT_REGISTER_END -->

<!-- 10_HANDOFF_START -->
# 10 -> 20 Handoff Packet

## Packet
| Field | Value |
|---|---|
| source_gate_result | $Gate |
| terminality | terminal |
| artifacts_produced | source-inventory.md, intake-log.md, fact-register.md |
| route_confirmed_by_requester | yes |
| route_confirmation_source | 00_handoff |
| route_delta_from_00 | none |

## Route Confirmation
| Field | Value |
|---|---|
| route_rechecked_in_10 | yes |
| route_confirmation_source | 00_handoff |
| route_delta_from_00 | none |
| route_delta_reason | 10 source intake kept the 00 route flags for this regression fixture |

## Source Summary
| source_id | source_name | status | source_class | note |
|---|---|---|---|---|
| S-001 | sample procedure | reviewed | primary | claimへ接続済み |
| S-002 | requester explanation | collected | assumption | 本人説明として分離 |

## Observed Facts For 20
- C-001: sample procedure contains the target workflow outline. source_id=S-001, confidence=medium.

## Person Explanations For 20
- C-002: requester says ops lead is the likely owner. source_id=S-002, confidence=low.

## Hypotheses / Unconfirmed
- C-003: owner approval and source permission are unresolved. source_id=S-002, confidence=low.

## Deferred Claims For 20
| claim_id | deferred_item | current_confidence | why_20_can_continue | next_check | must_resolve_before |
|---|---|---|---|---|---|
$deferred
## 20 Readiness

| Field | Value |
|---|---|
| 20_readiness | as_is_decompose |
| 20_input_contract | observed_as_is_sources |
| as_is_observed | true |
| work_unit | single_business |
| delivery_shape | single_executor |
| source_posture | first_party |
| route_delta_from_00 | none |
| must_not_do_in_20 | executor routing, automation scope, team staffing are later-phase topics |

## Reviewer Notes
Action: 20へ渡す。ただしowner/permissionは30前に10へ戻して確認する。

## Scope / Gate Notes
- external candidate: possible downstream external interface.
- sensitive candidate: possible customer or account data.
- out-of-scope: execution, routing, consent, validation.
<!-- 10_HANDOFF_END -->
"@
}

function Get-Cases {
  return @(
    [pscustomobject]@{ id = 'good-defer'; expect_accept = $true; expected_check = ''; result = (New-Good10Result -Gate 'defer') },
    [pscustomobject]@{ id = 'missing-interaction'; expect_accept = $false; expected_check = 'source-intake-interaction'; result = (New-Good10Result -Gate 'defer' -OmitInteraction) },
    [pscustomobject]@{ id = 'no-source-work'; expect_accept = $false; expected_check = 'terminal-source-work'; result = (New-Good10Result -Gate 'defer' -MaterialEvidenceCount 0 -SourceContactAttemptCount 0) },
    [pscustomobject]@{ id = 'person-explanation-observed'; expect_accept = $false; expected_check = 'claim-provenance-boundary'; result = (New-Good10Result -Gate 'defer' -PersonExplanationProvenance 'observed') },
    [pscustomobject]@{ id = 'reported-provenance'; expect_accept = $false; expected_check = 'provenance-vocabulary'; result = (New-Good10Result -Gate 'defer' -PersonExplanationProvenance 'reported') },
    [pscustomobject]@{ id = 'pass-without-material'; expect_accept = $false; expected_check = 'pass-needs-reviewed-material'; result = (New-Good10Result -Gate 'pass' -MaterialEvidenceCount 0 -SourceContactAttemptCount 1) }
  )
}

function Escape-Cell {
  param([AllowNull()][string]$Value)
  if ($null -eq $Value -or $Value -eq '') { return 'n/a' }
  return (($Value -replace '\|', '/' -replace "`r?`n", ' ') -replace '\s+', ' ').Trim()
}

function Write-Report {
  param([Parameter(Mandatory)][object[]]$Results, [Parameter(Mandatory)][string]$ReportPath, [Parameter(Mandatory)][string]$JsonPath)
  $passed = @($Results | Where-Object { $_.status -eq 'pass' }).Count
  $failed = $Results.Count - $passed
  $rows = foreach ($r in $Results) {
    '| {0} | {1} | {2} | {3} | {4} | {5} |' -f $r.id, $r.reviewer_result, $r.expected_check, $r.expected_check_status, $r.status, (Escape-Cell $r.failure)
  }
  $content = @"
# 10-source-intake Review Regression Report

| Field | Value |
|---|---|
| total | $($Results.Count) |
| passed | $passed |
| failed | $failed |
| json | $JsonPath |

## Results

| id | reviewer_result | expected_check | expected_check_status | status | failure |
|---|---|---|---|---|---|
$($rows -join "`n")

## Scope

This runner verifies deterministic 10-source-intake review behavior for strict source interaction and claim provenance boundaries. Negative cases pass only when the reviewer rejects them for the expected reason.
"@
  Write-Utf8File -Path $ReportPath -Text $content
  Write-Utf8File -Path $JsonPath -Text (($Results | ConvertTo-Json -Depth 10))
}

$repoRoot = Get-RepoRoot
if (-not $OutDir) {
  $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
  $OutDir = Join-Path ([System.IO.Path]::GetTempPath()) "biz-compiler-10-source-intake-review-regression-$stamp"
}
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$script10 = Join-Path $repoRoot 'template/10-source-intake/phase-orchestrator.ps1'
$results = New-Object System.Collections.Generic.List[object]
foreach ($case in Get-Cases) {
  $caseDir = Join-Path $OutDir $case.id
  New-Item -ItemType Directory -Force -Path $caseDir | Out-Null
  $resultFile = Join-Path $caseDir '10-result.md'
  Write-Utf8File -Path $resultFile -Text $case.result
  $reviewDir = Join-Path $caseDir 'review'
  New-Item -ItemType Directory -Force -Path $reviewDir | Out-Null
  $failure = ''
  try {
    Invoke-PhaseScript -ScriptPath $script10 -Arguments @('review', '-SubagentResultFile', $resultFile, '-OutDir', $reviewDir, '-Format', 'json') -Label "10 review $($case.id)" | Out-Null
    $review = Get-LatestJson -Directory $reviewDir -Pattern '10-source-intake-review-*.json'
    $isAccepted = $review.reviewer_result -in @('accept_pass', 'accept_defer')
    $expectedCheckStatus = ''
    if ($case.expected_check) {
      $check = @($review.checks | Where-Object { $_.id -eq $case.expected_check } | Select-Object -First 1)
      if ($check.Count -eq 0) { $failure = "expected check not found: $($case.expected_check)" }
      else { $expectedCheckStatus = $check[0].status }
    }
    if ($case.expect_accept -and -not $isAccepted) { $failure = "expected accept, got $($review.reviewer_result)" }
    if ((-not $case.expect_accept) -and $isAccepted) { $failure = "expected rejection, got $($review.reviewer_result)" }
    if ((-not $case.expect_accept) -and $case.expected_check -and $expectedCheckStatus -ne 'fail') { $failure = "expected $($case.expected_check)=fail, got $expectedCheckStatus" }
    $results.Add([pscustomobject]@{
      id = $case.id
      reviewer_result = $review.reviewer_result
      expected_check = $case.expected_check
      expected_check_status = $expectedCheckStatus
      status = if ($failure) { 'fail' } else { 'pass' }
      failure = $failure
    }) | Out-Null
  } catch {
    $results.Add([pscustomobject]@{
      id = $case.id
      reviewer_result = ''
      expected_check = $case.expected_check
      expected_check_status = ''
      status = 'fail'
      failure = $_.Exception.Message
    }) | Out-Null
  }
  $latest = $results[$results.Count - 1]
  Write-Host ("{0}: {1} reviewer={2}" -f $latest.id, $latest.status, $latest.reviewer_result)
  if ($StopOnFailure -and $latest.status -ne 'pass') { break }
}

$reportPath = Join-Path $OutDir '10-source-intake-review-regression-report.md'
$jsonPath = Join-Path $OutDir '10-source-intake-review-regression-results.json'
$resultsArray = @($results.ToArray())
Write-Report -Results $resultsArray -ReportPath $reportPath -JsonPath $jsonPath

$failedCount = @($resultsArray | Where-Object { $_.status -ne 'pass' }).Count
Write-Host "Report: $reportPath"
Write-Host "JSON: $jsonPath"
Write-Host ("Summary: {0}/{1} passed" -f ($resultsArray.Count - $failedCount), $resultsArray.Count)

if ($failedCount -gt 0) { exit 1 }
