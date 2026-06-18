[CmdletBinding()]
param(
  [Parameter(Position = 0)]
  [ValidateSet('start', 'review', 'finalize', 'status', 'help')]
  [string]$Command = 'help',

  [string]$PhaseDir,
  [string]$OutDir,
  [string]$TargetDir,
  [string]$Request,
  [string]$RequestFile,
  [string]$Materials,
  [string]$ConversationFile,
  [string]$SubagentResult,
  [string]$SubagentResultFile,

  [ValidateSet('markdown', 'json')]
  [string]$Format = 'markdown',

  [switch]$NoWrite,
  [switch]$AllowTemplateWrite
)

$ErrorActionPreference = 'Stop'

function Get-ScriptDirectory {
  if ($PSScriptRoot) { return $PSScriptRoot }
  return Split-Path -Parent $MyInvocation.MyCommand.Path
}

function Get-RepoRoot {
  try {
    $root = (& git rev-parse --show-toplevel 2>$null)
    if ($LASTEXITCODE -eq 0 -and $root) { return ($root | Select-Object -First 1) }
  } catch {
    # fall through
  }
  return (Resolve-Path (Join-Path (Get-ScriptDirectory) '..\..')).Path
}

function ConvertTo-RepoRelativePath {
  param([string]$Path)
  if (-not $Path) { return '' }
  $repoRoot = Get-RepoRoot
  $full = [System.IO.Path]::GetFullPath($Path)
  $rootFull = [System.IO.Path]::GetFullPath($repoRoot).TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
  if ($full.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)) {
    $relative = $full.Substring($rootFull.Length).TrimStart('\', '/')
    return $relative.Replace('\', '/')
  }
  return $full
}

function Resolve-InputPath {
  param([string]$Path, [string]$BaseDir)
  if (-not $Path) { return $null }
  if ([System.IO.Path]::IsPathRooted($Path)) { return [System.IO.Path]::GetFullPath($Path) }
  $candidate = Join-Path $BaseDir $Path
  if (Test-Path -LiteralPath $candidate) { return [System.IO.Path]::GetFullPath($candidate) }
  return [System.IO.Path]::GetFullPath((Join-Path (Get-RepoRoot) $Path))
}

function Read-TextFileOrEmpty {
  param([string]$Path)
  if (-not $Path) { return '' }
  $resolved = Resolve-InputPath -Path $Path -BaseDir (Get-Location).Path
  if (-not (Test-Path -LiteralPath $resolved)) { throw "File not found: $Path" }
  return [System.IO.File]::ReadAllText($resolved)
}

function Split-SemicolonList {
  param([string]$Value)
  if (-not $Value) { return @() }
  return @($Value -split ';' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

function Get-PhaseDirectory {
  if ($PhaseDir) {
    $resolved = Resolve-InputPath -Path $PhaseDir -BaseDir (Get-Location).Path
    if (-not (Test-Path -LiteralPath $resolved)) { throw "PhaseDir not found: $PhaseDir" }
    return $resolved
  }
  return (Get-ScriptDirectory)
}

function Test-IsTemplatePhaseDir {
  param([string]$Path)
  $repoRoot = [System.IO.Path]::GetFullPath((Get-RepoRoot)).TrimEnd('\', '/')
  $full = [System.IO.Path]::GetFullPath($Path).TrimEnd('\', '/')
  $templatePhase = [System.IO.Path]::GetFullPath((Join-Path $repoRoot 'template\00-entry')).TrimEnd('\', '/')
  return [string]::Equals($full, $templatePhase, [System.StringComparison]::OrdinalIgnoreCase)
}

function Get-OutputDirectory {
  param([string]$PhasePath)
  if ($OutDir) { return (Resolve-InputPath -Path $OutDir -BaseDir (Get-Location).Path) }
  return (Join-Path $PhasePath '_work')
}

function Get-FinalizeDirectory {
  param([string]$PhasePath)
  if ($TargetDir) { return (Resolve-InputPath -Path $TargetDir -BaseDir (Get-Location).Path) }
  return $PhasePath
}

function Test-HasHandoffDraft {
  param([string]$Text)
  if (-not $Text) { return $false }
  return [regex]::IsMatch($Text, '(?s)<!--\s*00_HANDOFF_START\s*-->.*?<!--\s*00_HANDOFF_END\s*-->')
}

function Get-HandoffDraft {
  param([string]$Text)
  $match = [regex]::Match($Text, '(?s)<!--\s*00_HANDOFF_START\s*-->\s*(?<body>.*?)\s*<!--\s*00_HANDOFF_END\s*-->')
  if (-not $match.Success) {
    throw 'handoff draft markers not found. Expected <!-- 00_HANDOFF_START --> ... <!-- 00_HANDOFF_END -->'
  }
  $body = $match.Groups['body'].Value.Trim()
  if (-not $body) { throw 'handoff draft is empty' }
  if ($body -notmatch '(?im)^\s*#\s+00\s*->\s*10\s+Handoff Packet') {
    $body = "# 00 -> 10 Handoff Packet`n`n$body"
  }
  return $body
}

function Get-TextBeforeHandoffDraft {
  param([string]$Text)
  if (-not $Text) { return '' }
  $match = [regex]::Match($Text, '(?is)<!--\s*00_HANDOFF_START\s*-->')
  if ($match.Success) { return $Text.Substring(0, $match.Index) }
  return $Text
}

function Get-PreflightReadFailurePattern {
  return '(?i)timeout|timed out|タイムアウト|missing required|failed to read|必読ファイルのうち一部|一部が.*読|抜けたが進める|preflight.*(未読|読めなかった|読めていない|読めない|失敗)|必読ファイル.*(未読|読めなかった|読めていない|読めない|失敗)'
}

function Get-MarkdownSection {
  param([string]$Text, [string]$Heading)
  if (-not $Text) { return '' }
  $escaped = [regex]::Escape($Heading)
  $match = [regex]::Match($Text, "(?ims)^##\s+$escaped\s*\r?\n(?<body>.*?)(?=^##\s+|\z)")
  if ($match.Success) { return $match.Groups['body'].Value.Trim() }
  return ''
}

function New-HandoffCheck {
  param([string]$Id, [ValidateSet('pass', 'warn', 'fail')][string]$Status, [string]$Message)
  return [pscustomobject]@{ id = $Id; status = $Status; message = $Message }
}

function Test-HandoffMinimumFor10 {
  param([string]$HandoffText, [string]$GateResult)
  $checks = New-Object System.Collections.Generic.List[object]
  if (-not $HandoffText) {
    $checks.Add((New-HandoffCheck 'handoff-minimum-body' 'fail' 'handoff draft body is empty')) | Out-Null
    return $checks.ToArray()
  }

  if ($HandoffText -match '<[^>\r\n]+>') {
    $checks.Add((New-HandoffCheck 'handoff-no-placeholders' 'fail' 'handoffにテンプレートplaceholderが残っている')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-no-placeholders' 'pass' 'handoffに明らかなplaceholderは残っていない')) | Out-Null
  }

  $requiredSections = @(
    'Packet',
    'Scope Summary',
    'Source Candidates For 10',
    '20 Readiness',
    'Route Confirmation',
    'Initial Risk Hints',
    'Unknowns For 10',
    'Low Confidence Hypotheses For 10',
    'Later Phase Notes'
  )
  foreach ($section in $requiredSections) {
    $body = Get-MarkdownSection -Text $HandoffText -Heading $section
    if ($body) {
      $checks.Add((New-HandoffCheck ("handoff-section-" + ($section.ToLowerInvariant() -replace '[^a-z0-9]+', '-').Trim('-')) 'pass' "$section section exists")) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck ("handoff-section-" + ($section.ToLowerInvariant() -replace '[^a-z0-9]+', '-').Trim('-')) 'fail' "$section section is required for 10-source-intake input")) | Out-Null
    }
  }

  if ($HandoffText -match '(?im)(^|\|)\s*entry_type\s*(\||[:=])\s*`?(existing_work|new_work)`?') {
    $checks.Add((New-HandoffCheck 'handoff-entry-type' 'pass' 'entry_type is concrete existing_work/new_work')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-entry-type' 'fail' 'entry_type must be existing_work or new_work before 10')) | Out-Null
  }

  $readinessSection = Get-MarkdownSection -Text $HandoffText -Heading '20 Readiness'
  if ($readinessSection -match '(?i)work_unit\s*(\||[:=])\s*(single_business|workflow_or_operation|business_program)' -and
      $readinessSection -match '(?i)delivery_shape\s*(\||[:=])\s*(single_executor|multi_executor_team|unknown)' -and
      $readinessSection -match '(?i)source_posture\s*(\||[:=])\s*(first_party|source_holder_connected|proxy_hearsay|mixed|unknown)' -and
      $readinessSection -match '(?i)20_readiness\s*(\||[:=])\s*(as_is_decompose|requirements_candidate|business_design_candidate)') {
    $checks.Add((New-HandoffCheck 'handoff-20-readiness' 'pass' '20 readiness route dimensions are explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-20-readiness' 'fail' 'handoff needs work_unit, delivery_shape, source_posture, and 20_readiness before 10')) | Out-Null
  }

  $routeConfirmationSection = Get-MarkdownSection -Text $HandoffText -Heading 'Route Confirmation'
  if ($routeConfirmationSection -match '(?i)route_confirmed_by_requester\s*(\||[:=])\s*(yes|partial|not_applicable)' -and
      $routeConfirmationSection -match '(?i)route_confirmation_question\s*(\||[:=])\s*[^|\r\n<>]{4,}' -and
      $routeConfirmationSection -match '(?i)route_confirmation_answer_or_evidence\s*(\||[:=])\s*[^|\r\n<>]{2,}' -and
      $routeConfirmationSection -match '(?i)route_delta_after_confirmation\s*(\||[:=])\s*(none|existing_to_new|new_to_existing|single_to_program|program_to_single|unknown_to_fixed)') {
    $checks.Add((New-HandoffCheck 'handoff-route-confirmation' 'pass' 'route confirmation is explicit and can travel to 10')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-route-confirmation' 'fail' 'handoff needs Route Confirmation with requester/source confirmation question, answer/evidence, and route delta')) | Out-Null
  }
  if ($readinessSection -match '(?i)source_posture\s*(\||[:=])\s*proxy_hearsay' -and
      $readinessSection -match '(?i)20_readiness\s*(\||[:=])\s*as_is_decompose') {
    $checks.Add((New-HandoffCheck 'handoff-proxy-as-is-guard' 'fail' 'proxy/hearsay cannot enter 20 as observed As-Is decomposition')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-proxy-as-is-guard' 'pass' 'proxy/hearsay is not promoted to observed As-Is decomposition')) | Out-Null
  }

  if ($GateResult -and $HandoffText -match ("(?im)(^|\|)\s*(entry_gate_result|gate_result)\s*(\||[:=])\s*`?" + [regex]::Escape($GateResult) + "`?")) {
    $checks.Add((New-HandoffCheck 'handoff-gate-result' 'pass' "gate_result matches $GateResult")) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-gate-result' 'fail' 'handoff gate_result must match accepted entry gate result')) | Out-Null
  }

  if ($HandoffText -match '(?im)(^|\|)\s*target_statement\s*(\||[:=])\s*[^|\r\n<>]{4,}') {
    $checks.Add((New-HandoffCheck 'handoff-target-statement' 'pass' 'target_statement is present')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-target-statement' 'fail' '10 needs a concrete target_statement from 00')) | Out-Null
  }

  $scopeSection = Get-MarkdownSection -Text $HandoffText -Heading 'Scope Summary'
  $scopeLabels = @('in_scope', 'out_of_scope', 'undecided_scope')
  $missingScope = @($scopeLabels | Where-Object { $scopeSection -notmatch ('(?i)' + [regex]::Escape($_)) })
  if ($missingScope.Count -eq 0) {
    $checks.Add((New-HandoffCheck 'handoff-scope-minimum' 'pass' 'scope in/out/undecided are present')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-scope-minimum' 'fail' ('scope summary missing: ' + ($missingScope -join ', ')))) | Out-Null
  }

  $sourceSection = Get-MarkdownSection -Text $HandoffText -Heading 'Source Candidates For 10'
  if ($sourceSection -match '(?i)SC-[0-9]{3}' -and $sourceSection -match '(?i)target|collected|unavailable|not_reviewed') {
    $checks.Add((New-HandoffCheck 'handoff-source-candidates' 'pass' 'source candidates for 10 include concrete SC ids and initial status')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-source-candidates' 'fail' '10 needs at least one concrete source candidate with initial status')) | Out-Null
  }
  if ($sourceSection -match '(?im)\|[^\r\n|]*\|\s*provided\s*\|\s*provided\s*\|') {
    $checks.Add((New-HandoffCheck 'handoff-source-status-normalized' 'fail' '10_initial_status must not remain provided; normalize to collected + not_reviewed')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-source-status-normalized' 'pass' 'no obvious provided->provided status leak into 10')) | Out-Null
  }

  $riskSection = Get-MarkdownSection -Text $HandoffText -Heading 'Initial Risk Hints'
  $riskLabels = @('external impact', 'sensitive data', 'irreversible action', 'approval need', 'authorization unclear', 'abuse or deception signal')
  $missingRisks = @($riskLabels | Where-Object { $riskSection -notmatch ('(?i)' + [regex]::Escape($_)) })
  if ($missingRisks.Count -eq 0 -and $riskSection -match '(?i)yes|no|unknown') {
    $checks.Add((New-HandoffCheck 'handoff-risk-hints' 'pass' 'initial risk hints cover 10 intake risk lenses')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-risk-hints' 'fail' ('risk hints missing or not classified: ' + ($missingRisks -join ', ')))) | Out-Null
  }

  if ($GateResult -eq 'pass') {
    $blockingRiskLabels = @('external impact', 'sensitive data', 'irreversible action', 'approval need', 'authorization unclear')
    $blockingRisks = @($blockingRiskLabels | Where-Object { $riskSection -match ("(?im)\|\s*" + [regex]::Escape($_) + "\s*\|\s*(yes|unknown)\s*\|") })
    if ($blockingRisks.Count -gt 0) {
      $checks.Add((New-HandoffCheck 'handoff-pass-risk-strictness' 'fail' ('pass cannot materialize while hard risk is yes/unknown: ' + ($blockingRisks -join ', ')))) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'handoff-pass-risk-strictness' 'pass' 'pass handoff has no hard risk yes/unknown rows')) | Out-Null
    }
  }

  $unknownSection = Get-MarkdownSection -Text $HandoffText -Heading 'Unknowns For 10'
  if ($unknownSection -match '(?i)U-[0-9]{3}|none|なし|該当なし') {
    $checks.Add((New-HandoffCheck 'handoff-unknowns' 'pass' 'unknowns for 10 are explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-unknowns' 'fail' 'unknowns for 10 must be listed or explicitly none')) | Out-Null
  }

  $hypothesisSection = Get-MarkdownSection -Text $HandoffText -Heading 'Low Confidence Hypotheses For 10'
  if ($hypothesisSection -match '(?i)H-[0-9]{3}|none|なし|該当なし') {
    $checks.Add((New-HandoffCheck 'handoff-low-confidence' 'pass' 'low confidence hypotheses are explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-low-confidence' 'fail' 'low confidence hypotheses must be listed or explicitly none')) | Out-Null
  }

  $laterSection = Get-MarkdownSection -Text $HandoffText -Heading 'Later Phase Notes'
  if ($laterSection -match '(?i)L-[0-9]{3}|none|なし|該当なし') {
    $checks.Add((New-HandoffCheck 'handoff-later-phase-notes' 'pass' 'later phase notes are explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-later-phase-notes' 'fail' 'later phase notes must be listed or explicitly none')) | Out-Null
  }

  if ($GateResult -eq 'defer') {
    $deferSection = Get-MarkdownSection -Text $HandoffText -Heading 'Defer Contract'
    if ($deferSection -match '(?i)DC-[0-9]{3}' -and $deferSection -match '(?i)if_unresolved' -and $deferSection -match '(?i)return_to_phase' -and $deferSection -match '(?i)must_resolve_before') {
      $checks.Add((New-HandoffCheck 'handoff-defer-contract' 'pass' 'defer contract has id, unresolved policy, return phase, and must_resolve_before')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'handoff-defer-contract' 'fail' 'defer handoff needs DC id, if_unresolved, return_to_phase, and must_resolve_before')) | Out-Null
    }
  }

  return $checks.ToArray()
}

function Write-Or-Print {
  param(
    [string]$Content,
    [string]$TargetPath,
    [string]$Label
  )
  if ($NoWrite) {
    Write-Output $Content
    return
  }
  $parent = Split-Path -Parent $TargetPath
  if (-not (Test-Path -LiteralPath $parent)) {
    New-Item -ItemType Directory -Path $parent | Out-Null
  }
  $encoding = [System.Text.UTF8Encoding]::new($false)
  [System.IO.File]::WriteAllText($TargetPath, $Content.TrimEnd() + "`n", $encoding)
  Write-Host "${Label}: $TargetPath"
}

function Get-RequiredFiles {
  param([string]$PhasePath)
  $repoRoot = Get-RepoRoot
  $rootItems = @(
    'Hello-world.md',
    'SOUL.md',
    'USER.md',
    'COMPASS.md',
    'knowledge/docs/lexicon.md',
    'MEMORY.md',
    'knowledge/docs/meta/phase-catalog.md'
  )
  $phaseItems = @(
    'README.md',
    'questions.md',
    'checks.md',
    'contract.md',
    'handoff.md',
    '_context/phase-boundary.md',
    '_context/grill-rules.md',
    '_context/sorting-rules.md',
    '_context/anomaly-rules.md',
    '_context/gate-rubric.md',
    '_context/dispatch-packet.md',
    '_context/dispatch-checks.md'
  )

  $rows = New-Object System.Collections.Generic.List[object]
  foreach ($item in $rootItems) {
    $fullPath = Join-Path $repoRoot ($item -replace '/', '\')
    $rows.Add([pscustomobject]@{
      path = $item
      source = 'repo-root'
      exists = [bool](Test-Path -LiteralPath $fullPath)
      full_path = $fullPath
    }) | Out-Null
  }
  foreach ($item in $phaseItems) {
    $fullPath = Join-Path $PhasePath ($item -replace '/', '\')
    $rows.Add([pscustomobject]@{
      path = $item
      source = 'phase-dir'
      exists = [bool](Test-Path -LiteralPath $fullPath)
      full_path = $fullPath
    }) | Out-Null
  }
  return $rows.ToArray()
}

function Convert-MaterialRows {
  param([string[]]$Items)
  $base = (Get-Location).Path
  $nonEmptyItems = @($Items | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })
  if ($nonEmptyItems.Count -eq 0) { return @() }
  return @($nonEmptyItems | ForEach-Object {
    $resolved = Resolve-InputPath -Path $_ -BaseDir $base
    [pscustomobject]@{
      path = $_
      exists = [bool](Test-Path -LiteralPath $resolved)
      resolved = $resolved
    }
  })
}

function New-MarkdownTable {
  param([object[]]$Rows, [string[]]$Columns)
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add('| ' + ($Columns -join ' | ') + ' |')
  $lines.Add('| ' + (($Columns | ForEach-Object { '---' }) -join ' | ') + ' |')
  foreach ($row in $Rows) {
    $values = foreach ($column in $Columns) {
      $value = $row.$column
      if ($null -eq $value -or $value -eq '') { '-' } else { ($value.ToString() -replace '\|', '/') }
    }
    $lines.Add('| ' + ($values -join ' | ') + ' |')
  }
  return ($lines -join "`n")
}

function Get-DispatchPacketText {
  param([string]$PhasePath)
  $path = Join-Path $PhasePath '_context\dispatch-packet.md'
  if (Test-Path -LiteralPath $path) { return [System.IO.File]::ReadAllText($path) }
  $repoPath = Join-Path (Get-RepoRoot) 'template\00-entry\_context\dispatch-packet.md'
  if (Test-Path -LiteralPath $repoPath) { return [System.IO.File]::ReadAllText($repoPath) }
  throw 'dispatch-packet.md not found'
}

function Invoke-Start {
  $phasePath = Get-PhaseDirectory
  $outPath = Get-OutputDirectory -PhasePath $phasePath
  if ((Test-IsTemplatePhaseDir -Path $phasePath) -and -not $NoWrite -and -not $AllowTemplateWrite -and -not $OutDir) {
    throw 'Refusing to write _work under template/00-entry. Use -NoWrite for preview, pass -OutDir, or add -AllowTemplateWrite explicitly.'
  }

  $requestText = $Request
  if ($RequestFile) { $requestText = Read-TextFileOrEmpty -Path $RequestFile }
  $conversationText = ''
  if ($ConversationFile) { $conversationText = Read-TextFileOrEmpty -Path $ConversationFile }
  $materialRows = Convert-MaterialRows -Items (Split-SemicolonList -Value $Materials)
  $requiredRows = Get-RequiredFiles -PhasePath $phasePath
  $dispatchPacket = Get-DispatchPacketText -PhasePath $phasePath
  $now = Get-Date -Format 'yyyy-MM-dd HH:mm:ss K'

  $materialTable = New-MarkdownTable -Rows $materialRows -Columns @('path', 'exists', 'resolved')
  $requiredTable = New-MarkdownTable -Rows $requiredRows -Columns @('path', 'source', 'exists')
  $phaseRel = ConvertTo-RepoRelativePath -Path $phasePath

  $content = @"
# 00-entry Phase Dispatch Bundle

Generated at: $now
Phase dir: $phaseRel`

## Operator Steps

1. 00担当subagentへ Dispatch Prompt 以降を渡す。
2. subagent返答をファイルへ保存する。
3. main agentが次を実行してreviewする。

.\phase-orchestrator.ps1 review -SubagentResultFile "<subagent-result.md>"

4. reviewer_result = preflight_retry なら00を開始せず必読ファイルを読了まで再読込する。ask_rework なら00内で追加質問に戻す。accept_pass / accept_defer なら `finalize` で handoff.md をmaterializeして10へ進める。accept_stop なら停止理由を残す。

## Current Request

$requestText

## Materials

$materialTable

## Conversation Context

$conversationText

## Required Files Status

$requiredTable

## Dispatch Prompt

$dispatchPacket

## Required Return Shape

subagentは、main agentへ次の順で返す。

0. interaction_state: initial_request_only, user_answer_count, material_evidence_count, asked_question_count
1. preflight確認。timeout/未読/読込失敗がある場合は00-entryの判定へ進まず、読了までpreflight retryする
2. 入口判断の結論
3. entry_gate_result と terminality。初回発話だけなら pass/defer にせず rework / non-terminal loop とする
4. 10へ渡すsource候補
5. low confidence hypotheses。assistant補完、本人説明、source候補、合意scopeを分ける
6. risk / unknown / later phase notes
7. rework の場合は次の00質問。terminal resultの場合はmainに確認してほしい点
8. pass / defer のterminal resultの場合は、`<!-- 00_HANDOFF_START -->` と `<!-- 00_HANDOFF_END -->` で囲んだ handoff draft
"@

  $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
  $target = Join-Path $outPath "00-entry-dispatch-$stamp.md"
  Write-Or-Print -Content $content -TargetPath $target -Label 'phase-orchestrator: wrote dispatch bundle'
}

function Add-ReviewCheck {
  param(
    [System.Collections.Generic.List[object]]$Checks,
    [string]$Id,
    [ValidateSet('pass', 'warn', 'fail')]
    [string]$Status,
    [string]$Message
  )
  $Checks.Add([pscustomobject]@{ id = $Id; status = $Status; message = $Message }) | Out-Null
}

function Find-FirstValue {
  param([string]$Text, [string[]]$Values)
  foreach ($value in $Values) {
    if ($Text -match ('(?i)(^|[^a-z0-9_])' + [regex]::Escape($value) + '([^a-z0-9_]|$)')) { return $value }
  }
  return ''
}

function Find-GateResult {
  param([string]$Text)
  $normalized = $Text -replace '`', ''
  $patterns = @(
    '(?im)^\s*\|\s*(entry_gate_result|gate_result|result)\s*\|\s*(pass|defer|rework|stop)\s*\|',
    '(?im)(entry[_ -]?gate[_ ]?result|gate_result)\s*[:：]\s*(pass|defer|rework|stop)',
    '(?im)^\s*entry[_ -]?gate[_ ]?result\s*=\s*(pass|defer|rework|stop)'
  )
  foreach ($pattern in $patterns) {
    $match = [regex]::Match($normalized, $pattern)
    if ($match.Success) { return $match.Groups[$match.Groups.Count - 1].Value.ToLowerInvariant() }
  }
  return Find-FirstValue -Text $normalized -Values @('pass', 'defer', 'rework', 'stop')
}

function Find-Terminality {
  param([string]$Text)
  $normalized = $Text -replace '`', ''
  if ($normalized -match '(?i)non[- ]terminal|non-terminal loop|00内|追加質問') { return 'non-terminal loop' }
  if ($normalized -match '(?i)terminal') { return 'terminal' }
  return ''
}

function Invoke-Review {
  $phasePath = Get-PhaseDirectory
  $outPath = Get-OutputDirectory -PhasePath $phasePath
  if ((Test-IsTemplatePhaseDir -Path $phasePath) -and -not $NoWrite -and -not $AllowTemplateWrite -and -not $OutDir) {
    throw 'Refusing to write _work under template/00-entry. Use -NoWrite for preview, pass -OutDir, or add -AllowTemplateWrite explicitly.'
  }

  $resultText = $SubagentResult
  if ($SubagentResultFile) { $resultText = Read-TextFileOrEmpty -Path $SubagentResultFile }
  if (-not $resultText) { throw 'review requires -SubagentResult or -SubagentResultFile' }

  $checks = New-Object System.Collections.Generic.List[object]
  $normalized = $resultText -replace '`', ''
  $entryType = Find-FirstValue -Text $normalized -Values @('existing_work', 'new_work', 'unclear')
  $gateResult = Find-GateResult -Text $normalized
  $terminality = Find-Terminality -Text $normalized
  $workUnit = Find-FirstValue -Text $normalized -Values @('single_business', 'workflow_or_operation', 'business_program', 'unclear')
  $deliveryShape = Find-FirstValue -Text $normalized -Values @('single_executor', 'multi_executor_team', 'unknown')
  $sourcePosture = Find-FirstValue -Text $normalized -Values @('first_party', 'source_holder_connected', 'proxy_hearsay', 'mixed', 'unknown')
  $twentyReadiness = Find-FirstValue -Text $normalized -Values @('as_is_decompose', 'requirements_candidate', 'business_design_candidate', 'do_not_proceed_rework', 'do_not_proceed_stop')
  $userAnswerCount = $null
  $materialEvidenceCount = $null
  $askedQuestionCount = $null
  $userAnswerMatch = [regex]::Match($normalized, '(?im)user[_ -]?answer[_ -]?count\s*[:：=\|]\s*([0-9]+)')
  if ($userAnswerMatch.Success) { $userAnswerCount = [int]$userAnswerMatch.Groups[1].Value }
  $materialEvidenceMatch = [regex]::Match($normalized, '(?im)material[_ -]?evidence[_ -]?count\s*[:：=\|]\s*([0-9]+)')
  if ($materialEvidenceMatch.Success) { $materialEvidenceCount = [int]$materialEvidenceMatch.Groups[1].Value }
  $askedQuestionMatch = [regex]::Match($normalized, '(?im)asked[_ -]?question[_ -]?count\s*[:：=\|]\s*([0-9]+)')
  if ($askedQuestionMatch.Success) { $askedQuestionCount = [int]$askedQuestionMatch.Groups[1].Value }
  $questionMarkCount = [regex]::Matches($normalized, '[\?？]').Count
  $hasInteractionState = $normalized -match '(?i)interaction[_ -]?state|user[_ -]?answer[_ -]?count|material[_ -]?evidence[_ -]?count|asked[_ -]?question[_ -]?count'
  $initialRequestOnly = $normalized -match '(?i)initial[_ -]?request[_ -]?only\s*[:：=\|]\s*(yes|true)|初回発話のみ|初手のみ|質問0|追加回答なし|user[_ -]?answer[_ -]?count\s*[:：=\|]\s*0'
  $readFailurePattern = Get-PreflightReadFailurePattern
  $preflightScanText = Get-TextBeforeHandoffDraft -Text $normalized
  $phaseTablePattern = '(?im)^\s*\|\s*#\s*\|\s*フェーズ|^\s*\|\s*00\s*\|\s*entry|10-source-intake.*20-decompose|20-decompose.*30-route|phase\s*table|フェーズ表'
  $solutionizingPattern = '(?i)full-auto|完全自動|自動送信|支払確定|確認メール.*自動(送信|で出)|PDF.*(読み|読ませ|読取|抽出).*Excel.*(作|生成|転記).*メール.*(送|出)|Excel.*確認メール.*(自動|送信|出す)|AIに.*(読ませ|作らせ|送らせ)|AI/automation候補|gate候補'
  $hardRiskPassPattern = '(?i)(external[ _-]?impact|sensitive[ _-]?data|irreversible[ _-]?action|authorization[ _-]?unclear|approval[ _-]?need)\s*[:：=\|]\s*(yes|unknown)'
  $preflightViolation = $preflightScanText -match $readFailurePattern

  if ($preflightScanText -match $readFailurePattern) {
    Add-ReviewCheck $checks 'preflight-confirmation' 'fail' '必読ファイルのtimeout/未読/読込失敗は00-entryの分岐ではなくpreflight retry対象'
  } elseif ($preflightScanText -match '(?i)前提ファイル確認|必読ファイル|read files|required files') {
    Add-ReviewCheck $checks 'preflight-confirmation' 'pass' 'preflight確認がある'
  } else {
    Add-ReviewCheck $checks 'preflight-confirmation' 'fail' 'preflight確認が見えない'
  }

  if ($entryType) {
    Add-ReviewCheck $checks 'entry-type' 'pass' "entry_type = $entryType"
  } else {
    Add-ReviewCheck $checks 'entry-type' 'fail' 'entry_type が見えない'
  }

  if ($normalized -match '(?i)target_statement|one_sentence|業務候補|一文') {
    Add-ReviewCheck $checks 'target-statement' 'pass' '業務候補の一文説明がある'
  } else {
    Add-ReviewCheck $checks 'target-statement' 'fail' '業務候補を一文で言えているか不明'
  }

  if ($normalized -match '(?i)source_candidates|source candidate|source候補|資料|現物|SC-[0-9]') {
    Add-ReviewCheck $checks 'source-candidates' 'pass' '10で確認するsource候補がある'
  } else {
    Add-ReviewCheck $checks 'source-candidates' 'fail' '10で何を確認するか見えない'
  }

  if ($normalized -match '(?i)low confidence|hypothes|confidence\s*=\s*low|低信頼|仮説') {
    Add-ReviewCheck $checks 'low-confidence' 'pass' 'low confidence仮説の扱いが見える'
  } else {
    Add-ReviewCheck $checks 'low-confidence' 'warn' 'assistant補完や本人説明をlow confidenceとして分離したか要確認'
  }

  $hasRouteDimensions = (($workUnit -and $deliveryShape -and $sourcePosture -and $twentyReadiness) -or
    ($normalized -match '(?i)work_unit' -and $normalized -match '(?i)delivery_shape' -and $normalized -match '(?i)source_posture' -and $normalized -match '(?i)20_readiness'))
  if ($hasRouteDimensions) {
    Add-ReviewCheck $checks 'route-dimensions' 'pass' 'work_unit / delivery_shape / source_posture / 20_readiness が見える'
  } elseif ($gateResult -eq 'pass' -or $gateResult -eq 'defer') {
    Add-ReviewCheck $checks 'route-dimensions' 'fail' 'pass/defer terminalには20へ何として渡すかのroute dimensionsが必要'
  } else {
    Add-ReviewCheck $checks 'route-dimensions' 'warn' '20へ何として渡すかのroute dimensionsが見えない'
  }

  $routeConfirmationVisible = $normalized -match '(?i)Route Confirmation|route_confirmed_by_requester|route_confirmation_question|route_delta_after_confirmation|本人.*確認|source holder.*確認'
  if ($routeConfirmationVisible) {
    Add-ReviewCheck $checks 'route-confirmation' 'pass' 'route flagの本人/source holder確認状態が見える'
  } elseif ($gateResult -eq 'pass' -or $gateResult -eq 'defer') {
    Add-ReviewCheck $checks 'route-confirmation' 'fail' 'pass/defer terminalにはroute flagの本人/source holder確認状態が必要'
  } else {
    Add-ReviewCheck $checks 'route-confirmation' 'warn' 'route flag確認状態が見えない'
  }
  if ($sourcePosture -eq 'proxy_hearsay' -and $twentyReadiness -eq 'as_is_decompose') {
    Add-ReviewCheck $checks 'proxy-as-is-guard' 'fail' '代理/伝聞をAs-Is分解readyとしている。source holder接続かrequirements_candidateへの切り直しが必要'
  }

  if ($normalized -match '(?i)risk|external|sensitive|irreversible|authorization|abuse|リスク|権限|個人情報|不可逆') {
    Add-ReviewCheck $checks 'risk-hints' 'pass' '初期risk hintがある'
  } else {
    Add-ReviewCheck $checks 'risk-hints' 'fail' '初期risk hintが見えない'
  }

  if ($normalized -match '(?i)later_phase|later phase|後続phase|20|30|40|50|60') {
    Add-ReviewCheck $checks 'later-phase-notes' 'pass' '後続phaseへ送る話が分離されている'
  } else {
    Add-ReviewCheck $checks 'later-phase-notes' 'warn' '後続phase noteが空なのか未確認なのか要確認'
  }

  if ($initialRequestOnly -and $normalized -match $phaseTablePattern) {
    Add-ReviewCheck $checks 'question0-phase-table' 'fail' '質問0の初回返答でフェーズ表や後続phase表を出している'
  }

  if ($initialRequestOnly -and $normalized -match $solutionizingPattern) {
    Add-ReviewCheck $checks 'question0-solutionizing' 'fail' '質問0の初回返答で自動化範囲、メール送信、実行分担などを決めに行っている'
  }

  if ($gateResult) {
    Add-ReviewCheck $checks 'entry-gate-result' 'pass' "entry_gate_result = $gateResult"
  } else {
    Add-ReviewCheck $checks 'entry-gate-result' 'fail' 'entry_gate_result が見えない'
  }

  if ($gateResult -eq 'pass' -or $gateResult -eq 'defer') {
    if (-not $hasInteractionState) {
      Add-ReviewCheck $checks 'terminal-evidence' 'fail' 'pass/defer には interaction_state が必要。質問0完了ではない根拠が見えない'
    } elseif ($initialRequestOnly) {
      Add-ReviewCheck $checks 'zero-question-terminal' 'fail' '初回発話のみ、または質問0の状態で pass/defer terminal にしている'
    } elseif (($null -eq $userAnswerCount -or $userAnswerCount -lt 1) -and ($null -eq $materialEvidenceCount -or $materialEvidenceCount -lt 1)) {
      Add-ReviewCheck $checks 'zero-question-terminal' 'fail' 'pass/defer には追加回答または資料実物などの確認根拠が必要'
    } else {
      Add-ReviewCheck $checks 'terminal-evidence' 'pass' 'terminal result に必要な interaction_state がある'
    }

    if (Test-HasHandoffDraft -Text $resultText) {
      Add-ReviewCheck $checks 'handoff-draft' 'pass' 'terminal result に 00_HANDOFF_START / 00_HANDOFF_END で囲まれたhandoff draftがある'
      $handoffDraft = Get-HandoffDraft -Text $resultText
      foreach ($handoffCheck in (Test-HandoffMinimumFor10 -HandoffText $handoffDraft -GateResult $gateResult)) {
        Add-ReviewCheck $checks $handoffCheck.id $handoffCheck.status $handoffCheck.message
      }
    } else {
      Add-ReviewCheck $checks 'handoff-draft' 'fail' 'pass/defer は handoff.md materialize 用の handoff draft を必ず含める'
    }
  }

  if ($gateResult -eq 'rework') {
    if ($terminality -eq 'non-terminal loop') {
      Add-ReviewCheck $checks 'rework-terminality' 'pass' 'rework がnon-terminal loopとして扱われている'
    } else {
      Add-ReviewCheck $checks 'rework-terminality' 'fail' 'rework をterminal扱いしていないか確認が必要'
    }

    if ($null -ne $askedQuestionCount) {
      if ($askedQuestionCount -gt 3) {
        Add-ReviewCheck $checks 'question-count' 'fail' '00のreworkで一度に質問を投げすぎている。初回は1つ、最大でも3つまでに絞る'
      } elseif ($askedQuestionCount -eq 0) {
        Add-ReviewCheck $checks 'question-count' 'warn' 'reworkなのに次の確認質問数が0に見える'
      } else {
        Add-ReviewCheck $checks 'question-count' 'pass' "asked_question_count = $askedQuestionCount"
      }
    } elseif ($questionMarkCount -gt 3) {
      Add-ReviewCheck $checks 'question-count' 'warn' '質問数メタデータがなく、本文上の疑問符が多い。初回は1つ、最大でも3つまでに絞る'
    } else {
      Add-ReviewCheck $checks 'question-count' 'warn' 'asked_question_count が見えない。rework時の質問数を明示する'
    }
  }

  if ($gateResult -eq 'defer') {
    if ($normalized -match '(?i)defer[_ -]?contract|defer_contract_id|DC-[0-9]') {
      Add-ReviewCheck $checks 'defer-contract' 'pass' 'defer contract が見える'
    } else {
      Add-ReviewCheck $checks 'defer-contract' 'fail' 'defer なのに defer_contract_id / Defer Contract が見えない'
    }

    if ($normalized -match '(?i)if_unresolved|return_to_phase|must_resolve_before|確認できない場合|未解決') {
      Add-ReviewCheck $checks 'defer-unresolved-policy' 'pass' 'defer未解決時の扱いがある'
    } else {
      Add-ReviewCheck $checks 'defer-unresolved-policy' 'fail' 'defer の未解決事項が解けなかった場合の戻し先/停止条件が見えない'
    }
  }

  if ($gateResult -eq 'stop') {
    if ($normalized -match '(?i)stop_reason_type\s*[:：=\|]\s*(benign_non_bizcompiler|unsafe_or_unauthorized|dangerous_scope_unclear)') {
      Add-ReviewCheck $checks 'stop-reason-type' 'pass' 'stop_reason_type がある'
    } else {
      Add-ReviewCheck $checks 'stop-reason-type' 'fail' 'stop には stop_reason_type が必要'
    }
  }

  if (($gateResult -eq 'pass' -or $gateResult -eq 'defer') -and $entryType -eq 'unclear') {
    Add-ReviewCheck $checks 'unclear-handoff' 'fail' 'entry_type = unclear のまま pass/defer handoff しようとしている'
  }

  if ($normalized -match '(?i)assistant_hypothesis_from_conversation|person_explanation') {
    Add-ReviewCheck $checks 'provenance-vocabulary' 'fail' '00/IR標準外のprovenance値らしき語がある。provenanceは hypothesized 等に寄せ、詳細は source_type/claim_type/source_ref に逃がす'
  } else {
    Add-ReviewCheck $checks 'provenance-vocabulary' 'pass' '明らかな標準外provenance値は見えない'
  }

  if ($gateResult -eq 'pass' -and ($normalized -match '(?i)proxy|hearsay|伝聞|代理|authorization_unclear|権限不明' -or $normalized -match $hardRiskPassPattern)) {
    Add-ReviewCheck $checks 'pass-strictness' 'fail' 'passに強い未確認riskが残っている。defer/stop/reworkへ倒す必要がある'
  }

  $hasFail = @($checks | Where-Object { $_.status -eq 'fail' }).Count -gt 0
  $hasWarn = @($checks | Where-Object { $_.status -eq 'warn' }).Count -gt 0
  $reviewerResult = 'ask_rework'
  $handoffReady = 'no'
  $requiredFollowUpQuestion = '00内で、entry_type、target、source候補、riskの不足を1つずつ補う質問に戻す'

  if ($preflightViolation) {
    $reviewerResult = 'preflight_retry'
    $handoffReady = 'no'
    $requiredFollowUpQuestion = '00-entryの質問へ戻さず、必読ファイルを読了するまで再読込する'
  }

  if ((-not $hasFail) -and (-not $preflightViolation)) {
    switch ($gateResult) {
      'pass' {
        $reviewerResult = 'accept_pass'
        $handoffReady = 'yes'
        $requiredFollowUpQuestion = ''
      }
      'defer' {
        $reviewerResult = 'accept_defer'
        $handoffReady = 'yes'
        $requiredFollowUpQuestion = ''
      }
      'stop' {
        $reviewerResult = 'accept_stop'
        $handoffReady = 'no'
        $requiredFollowUpQuestion = ''
      }
      'rework' {
        $reviewerResult = 'ask_rework'
        $handoffReady = 'no'
      }
      default {
        $reviewerResult = 'ask_rework'
        $handoffReady = 'no'
      }
    }
  }

  if ($hasWarn -and ($reviewerResult -eq 'accept_pass')) {
    $reviewerResult = 'main_override'
    $handoffReady = 'no'
    $requiredFollowUpQuestion = 'warning項目をmainが確認し、passのまま閉じるかdefer/reworkへ修正する'
  }

  $residualRisk = 'none from deterministic checks'
  if ($hasWarn) { $residualRisk = 'warnings require main judgment' }
  if ($hasFail) { $residualRisk = 'failed checks block handoff' }
  if ($preflightViolation) { $residualRisk = 'preflight retry required until all required files are read' }

  $checkArray = New-Object System.Collections.Generic.List[object]
  foreach ($check in $checks) { $checkArray.Add($check) | Out-Null }

  $review = [pscustomobject]@{
    phase_id = '00-entry'
    reviewer_result = $reviewerResult
    accepted_entry_gate_result = $gateResult
    entry_type = $entryType
    terminality = $terminality
    handoff_ready = $handoffReady
    required_follow_up_question = $requiredFollowUpQuestion
    residual_risk = $residualRisk
    checks = $checkArray.ToArray()
  }

  if ($Format -eq 'json') {
    $json = $review | ConvertTo-Json -Depth 8
    $targetJson = Join-Path $outPath ('00-entry-review-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.json')
    Write-Or-Print -Content $json -TargetPath $targetJson -Label 'phase-orchestrator: wrote review json'
    return
  }

  $checkRows = @($checks | ForEach-Object { [pscustomobject]@{ id = $_.id; status = $_.status; message = $_.message } })
  $checkTable = New-MarkdownTable -Rows $checkRows -Columns @('id', 'status', 'message')
  $content = @"
# 00-entry Phase Review

| Field | Value |
|---|---|
| phase_id | 00-entry |
| reviewer_result | $reviewerResult |
| accepted_entry_gate_result | $gateResult |
| entry_type | $entryType |
| terminality | $terminality |
| handoff_ready | $handoffReady |
| required_follow_up_question | $requiredFollowUpQuestion |
| residual_risk | $residualRisk |

## Checks

$checkTable

## Next Action

- accept_pass: `finalize -SubagentResultFile <subagent-result.md> -TargetDir output/Biz-XXX-業務名/00-entry` で `handoff.md` をmaterializeし、通常のsource確認として10-source-intakeへ進める。
- accept_defer: `finalize -SubagentResultFile <subagent-result.md> -TargetDir output/Biz-XXX-業務名/00-entry` でdefer契約込みの `handoff.md` をmaterializeし、10-source-intakeへ進める。
- preflight_retry: 00-entryを開始せず、必読ファイルを読了するまで再読込する。
- ask_rework: 00内で追加質問し、subagent返答を更新してもう一度reviewする。
- accept_stop: stop理由を contract.md / initial-risk-memo.md に残して閉じる。
- main_override: main agentが理由を残してgate resultを修正する。
"@
  $target = Join-Path $outPath ('00-entry-review-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.md')
  Write-Or-Print -Content $content -TargetPath $target -Label 'phase-orchestrator: wrote review'
}

function Invoke-Finalize {
  $phasePath = Get-PhaseDirectory
  $targetPath = Get-FinalizeDirectory -PhasePath $phasePath
  if ((Test-IsTemplatePhaseDir -Path $targetPath) -and -not $AllowTemplateWrite) {
    throw 'Refusing to finalize under template/00-entry. Pass -TargetDir for output/Biz-XXX/00-entry, use -PhaseDir for an output phase dir, or add -AllowTemplateWrite explicitly.'
  }

  $resultText = $SubagentResult
  if ($SubagentResultFile) { $resultText = Read-TextFileOrEmpty -Path $SubagentResultFile }
  if (-not $resultText) { throw 'finalize requires -SubagentResult or -SubagentResultFile' }

  $preflightScanText = Get-TextBeforeHandoffDraft -Text ($resultText -replace '`', '')
  if ($preflightScanText -match (Get-PreflightReadFailurePattern)) {
    throw 'finalize refused: preflight read failure is present before handoff draft. Retry required files before materializing handoff.'
  }

  $gateResult = Find-GateResult -Text $resultText
  if ($gateResult -ne 'pass' -and $gateResult -ne 'defer') {
    throw "finalize only writes handoff for pass/defer terminal result. gate_result=$gateResult"
  }

  $handoff = Get-HandoffDraft -Text $resultText
  $handoffChecks = @(Test-HandoffMinimumFor10 -HandoffText $handoff -GateResult $gateResult)
  $failedHandoffChecks = @($handoffChecks | Where-Object { $_.status -eq 'fail' })
  if ($failedHandoffChecks.Count -gt 0) {
    $messages = @($failedHandoffChecks | ForEach-Object { $_.id + ': ' + $_.message }) -join '; '
    throw ('handoff minimum check failed: ' + $messages)
  }

  if (-not (Test-Path -LiteralPath $targetPath)) {
    New-Item -ItemType Directory -Path $targetPath | Out-Null
  }
  $handoffPath = Join-Path $targetPath 'handoff.md'
  $encoding = [System.Text.UTF8Encoding]::new($false)
  [System.IO.File]::WriteAllText($handoffPath, $handoff.TrimEnd() + "`n", $encoding)
  Write-Output ("phase-orchestrator: wrote handoff: " + $handoffPath)
}

function Invoke-Status {
  $phasePath = Get-PhaseDirectory
  $required = @(
    'README.md',
    'questions.md',
    'checks.md',
    'contract.md',
    'handoff.md',
    'phase-orchestrator.ps1',
    '_context/dispatch-packet.md',
    '_context/dispatch-checks.md',
    'artifacts/entry-packet.md',
    'artifacts/scope-memo.md',
    'artifacts/initial-risk-memo.md',
    'artifacts/source-candidates.md',
    'artifacts/later-phase-notes.md'
  )
  $rows = @($required | ForEach-Object {
    $full = Join-Path $phasePath ($_ -replace '/', '\')
    [pscustomobject]@{ path = $_; exists = [bool](Test-Path -LiteralPath $full) }
  })
  $table = New-MarkdownTable -Rows $rows -Columns @('path', 'exists')
  $outPath = Get-OutputDirectory -PhasePath $phasePath
  $workRows = @()
  if (Test-Path -LiteralPath $outPath) {
    $workRows = @(Get-ChildItem -LiteralPath $outPath -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 10 | ForEach-Object {
      [pscustomObject]@{ path = ConvertTo-RepoRelativePath -Path $_.FullName; exists = $true }
    })
  }
  $workTable = if ($workRows.Count -gt 0) { New-MarkdownTable -Rows $workRows -Columns @('path', 'exists') } else { '_No phase work files found._' }
  $phaseRel = ConvertTo-RepoRelativePath -Path $phasePath
  $outRel = ConvertTo-RepoRelativePath -Path $outPath
  $content = @"
# 00-entry Phase Orchestrator Status

Phase dir: $phaseRel`
Work dir: $outRel`

## Phase Files

$table

## Recent Work Files

$workTable
"@
  Write-Output $content.TrimEnd()
}

function Invoke-Help {
  $lines = @(
    '# 00-entry Phase Orchestrator',
    '',
    'Commands:',
    '',
    'Create a dispatch bundle for the 00担当subagent:',
    '.\phase-orchestrator.ps1 start -Request "請求書処理を楽にしたい" -Materials "docs/manual.md;docs/sample.xlsx" -OutDir "output/Biz-001-demo/00-entry/_work"',
    '',
    'Review a subagent result and decide pass/defer/rework/stop handling:',
    '.\phase-orchestrator.ps1 review -SubagentResultFile "output/Biz-001-demo/00-entry/_work/subagent-result.md"',
    '',
    'JSON review, suitable for validators:',
    '.\phase-orchestrator.ps1 review -SubagentResultFile "output/Biz-001-demo/00-entry/_work/subagent-result.md" -Format json',
    '',
    'Materialize handoff.md from an accepted pass/defer terminal result:',
    '.\phase-orchestrator.ps1 finalize -SubagentResultFile "output/Biz-001-demo/00-entry/_work/subagent-result.md" -TargetDir "output/Biz-001-demo/00-entry"',
    '',
    'Inspect phase-local files:',
    '.\phase-orchestrator.ps1 status',
    '',
    'Notes:',
    '',
    '- start refuses to write under template/00-entry/_work unless -OutDir, -NoWrite, or -AllowTemplateWrite is supplied.',
    '- review is deterministic and conservative. It does not prove business correctness; it blocks obvious 00-entry handoff mistakes and flags main review risks.',
    '- finalize writes only a pass/defer result that contains the 00_HANDOFF_START / 00_HANDOFF_END draft block and passes the 10-source-intake minimum handoff checks.',
    '- rework remains a non-terminal loop. Do not advance to 10-source-intake from rework.'
  )
  Write-Output ($lines -join "`n")
}

switch ($Command) {
  'start' { Invoke-Start }
  'review' { Invoke-Review }
  'finalize' { Invoke-Finalize }
  'status' { Invoke-Status }
  'help' { Invoke-Help }
}
