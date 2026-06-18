[CmdletBinding()]
param(
  [Parameter(Position = 0)]
  [ValidateSet('start', 'review', 'finalize', 'status', 'help')]
  [string]$Command = 'help',

  [string]$PhaseDir,
  [string]$OutDir,
  [string]$TargetDir,
  [string]$EntryHandoff,
  [string]$EntryHandoffFile,
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
  $templatePhase = [System.IO.Path]::GetFullPath((Join-Path $repoRoot 'template\10-source-intake')).TrimEnd('\', '/')
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
  return [regex]::IsMatch($Text, '(?s)<!--\s*10_HANDOFF_START\s*-->.*?<!--\s*10_HANDOFF_END\s*-->')
}

function Get-HandoffDraft {
  param([string]$Text)
  $match = [regex]::Match($Text, '(?s)<!--\s*10_HANDOFF_START\s*-->\s*(?<body>.*?)\s*<!--\s*10_HANDOFF_END\s*-->')
  if (-not $match.Success) {
    throw 'handoff draft markers not found. Expected <!-- 10_HANDOFF_START --> ... <!-- 10_HANDOFF_END -->'
  }
  $body = $match.Groups['body'].Value.Trim()
  if (-not $body) { throw 'handoff draft is empty' }
  if ($body -notmatch '(?im)^\s*#\s+10\s*->\s*20\s+Handoff Packet') {
    $body = "# 10 -> 20 Handoff Packet`n`n$body"
  }
  return $body
}

function Get-MarkedBlock {
  param([string]$Text, [string]$MarkerName)
  if (-not $Text) { return '' }
  $escaped = [regex]::Escape($MarkerName)
  $match = [regex]::Match($Text, "(?s)<!--\s*${escaped}_START\s*-->\s*(?<body>.*?)\s*<!--\s*${escaped}_END\s*-->")
  if (-not $match.Success) { return '' }
  return $match.Groups['body'].Value.Trim()
}

function Test-HasMarkedBlock {
  param([string]$Text, [string]$MarkerName)
  return -not [string]::IsNullOrWhiteSpace((Get-MarkedBlock -Text $Text -MarkerName $MarkerName))
}
function Get-TextBeforeHandoffDraft {
  param([string]$Text)
  if (-not $Text) { return '' }
  $match = [regex]::Match($Text, '(?is)<!--\s*10_HANDOFF_START\s*-->')
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

function Test-OutputArtifactsMinimumFor20 {
  param([string]$ResultText)
  $checks = New-Object System.Collections.Generic.List[object]

  $sourceInventory = Get-MarkedBlock -Text $ResultText -MarkerName '10_SOURCE_INVENTORY'
  $intakeLog = Get-MarkedBlock -Text $ResultText -MarkerName '10_INTAKE_LOG'
  $factRegister = Get-MarkedBlock -Text $ResultText -MarkerName '10_FACT_REGISTER'

  if ($sourceInventory) {
    $checks.Add((New-HandoffCheck 'output-source-inventory-draft' 'pass' 'source-inventory.md draft block exists')) | Out-Null
    if ($sourceInventory -match '<[^>\r\n]+>') {
      $checks.Add((New-HandoffCheck 'output-source-inventory-placeholders' 'fail' 'source-inventory draft has placeholders')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'output-source-inventory-placeholders' 'pass' 'source-inventory draft has no obvious placeholders')) | Out-Null
    }
    if ($sourceInventory -match '(?i)S-[0-9]{3}' -and $sourceInventory -match '(?i)target|collected|reviewed|unavailable' -and $sourceInventory -match '(?i)primary|secondary|hearsay|assumption') {
      $checks.Add((New-HandoffCheck 'output-source-inventory-minimum' 'pass' 'source inventory has source_id, status, and source_class')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'output-source-inventory-minimum' 'fail' 'source inventory needs S-###, status, and source_class')) | Out-Null
    }
    if ($sourceInventory -match '(?im)\|\s*provided\s*\|') {
      $checks.Add((New-HandoffCheck 'output-source-inventory-no-provided' 'fail' 'source inventory must not keep provided as 10 status')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'output-source-inventory-no-provided' 'pass' 'source inventory has no obvious provided status')) | Out-Null
    }
  } else {
    $checks.Add((New-HandoffCheck 'output-source-inventory-draft' 'fail' 'terminal result must include 10_SOURCE_INVENTORY draft block')) | Out-Null
  }

  if ($intakeLog) {
    $checks.Add((New-HandoffCheck 'output-intake-log-draft' 'pass' 'intake-log.md draft block exists')) | Out-Null
    if ($intakeLog -match '<[^>\r\n]+>') {
      $checks.Add((New-HandoffCheck 'output-intake-log-placeholders' 'fail' 'intake log draft has placeholders')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'output-intake-log-placeholders' 'pass' 'intake log draft has no obvious placeholders')) | Out-Null
    }
    if ($intakeLog -match '(?i)S-[0-9]{3}|source_id' -and $intakeLog -match '(?i)collected|reviewed|asked|observed|unavailable|確認|観測') {
      $checks.Add((New-HandoffCheck 'output-intake-log-minimum' 'pass' 'intake log records source-linked intake activity')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'output-intake-log-minimum' 'fail' 'intake log needs source-linked collection/review/observation records')) | Out-Null
    }
  } else {
    $checks.Add((New-HandoffCheck 'output-intake-log-draft' 'fail' 'terminal result must include 10_INTAKE_LOG draft block')) | Out-Null
  }

  if ($factRegister) {
    $checks.Add((New-HandoffCheck 'output-fact-register-draft' 'pass' 'fact-register.md draft block exists')) | Out-Null
    if ($factRegister -match '<[^>\r\n]+>') {
      $checks.Add((New-HandoffCheck 'output-fact-register-placeholders' 'fail' 'fact register draft has placeholders')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'output-fact-register-placeholders' 'pass' 'fact register draft has no obvious placeholders')) | Out-Null
    }
    if ($factRegister -match '(?i)C-[0-9]{3}' -and $factRegister -match '(?i)observed_fact|person_explanation|hypothesis|unconfirmed|derived' -and $factRegister -match '(?i)S-[0-9]{3}' -and $factRegister -match '(?i)provenance|observed|hypothesized|negotiated|derived' -and $factRegister -match '(?i)confidence|low|medium|high') {
      $checks.Add((New-HandoffCheck 'output-fact-register-minimum' 'pass' 'fact register has claim_id, claim_type, source_id, provenance, and confidence')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'output-fact-register-minimum' 'fail' 'fact register needs C-###, claim_type, S-###, provenance, and confidence')) | Out-Null
    }
  } else {
    $checks.Add((New-HandoffCheck 'output-fact-register-draft' 'fail' 'terminal result must include 10_FACT_REGISTER draft block')) | Out-Null
  }

  return $checks.ToArray()
}
function Test-HandoffMinimumFor20 {
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
    'Source Summary',
    'Observed Facts For 20',
    'Person Explanations For 20',
    'Hypotheses / Unconfirmed',
    'Deferred Claims For 20',
    '20 Readiness',
    'Route Confirmation',
    'Reviewer Notes',
    'Scope / Gate Notes'
  )
  foreach ($section in $requiredSections) {
    $body = Get-MarkdownSection -Text $HandoffText -Heading $section
    $id = 'handoff-section-' + (($section.ToLowerInvariant() -replace '[^a-z0-9]+', '-').Trim('-'))
    if ($body) { $checks.Add((New-HandoffCheck $id 'pass' "$section section exists")) | Out-Null }
    else { $checks.Add((New-HandoffCheck $id 'fail' "$section section is required for 20-decompose-encrs input")) | Out-Null }
  }

  if ($GateResult -and $HandoffText -match ("(?im)(^|\|)\s*(source_gate_result|gate_result)\s*(\||[:=])\s*`?" + [regex]::Escape($GateResult) + "`?")) {
    $checks.Add((New-HandoffCheck 'handoff-gate-result' 'pass' "gate_result matches $GateResult")) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-gate-result' 'fail' 'handoff gate_result must match accepted 10 source gate result')) | Out-Null
  }

  if ($HandoffText -match '(?im)(^|\|)\s*terminality\s*(\||[:=])\s*`?terminal`?') {
    $checks.Add((New-HandoffCheck 'handoff-terminality' 'pass' 'terminality is terminal')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-terminality' 'fail' '10->20 handoff requires terminality = terminal')) | Out-Null
  }

  $readinessSection = Get-MarkdownSection -Text $HandoffText -Heading '20 Readiness'
  if ($readinessSection -match '(?i)20_readiness\s*(\||[:=])\s*(as_is_decompose|requirements_candidate|business_design_candidate)' -and
      $readinessSection -match '(?i)20_input_contract\s*(\||[:=])\s*(observed_as_is_sources|requirements_candidate_sources|business_program_hypotheses)' -and
      $readinessSection -match '(?i)as_is_observed\s*(\||[:=])\s*(true|false)') {
    $checks.Add((New-HandoffCheck 'handoff-20-readiness-route' 'pass' '20 readiness and input contract are explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-20-readiness-route' 'fail' '10->20 handoff needs 20_readiness, 20_input_contract, and as_is_observed')) | Out-Null
  }

  if ($readinessSection -match '(?i)20_readiness\s*(\||[:=])\s*as_is_decompose' -and $readinessSection -match '(?i)as_is_observed\s*(\||[:=])\s*false') {
    $checks.Add((New-HandoffCheck 'handoff-as-is-observed-guard' 'fail' 'as_is_decompose requires as_is_observed=true')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-as-is-observed-guard' 'pass' '20 readiness does not claim As-Is decomposition without observed As-Is')) | Out-Null
  }

  $routeConfirmationSection = Get-MarkdownSection -Text $HandoffText -Heading 'Route Confirmation'
  if ($routeConfirmationSection -match '(?i)route_rechecked_in_10\s*(\||[:=])\s*yes' -and
      $routeConfirmationSection -match '(?i)route_confirmation_source\s*(\||[:=])\s*(00_handoff|source_holder_answer|reviewed_material|main_reclassification)' -and
      $routeConfirmationSection -match '(?i)route_delta_from_00\s*(\||[:=])\s*(none|existing_to_new|new_to_existing|single_to_program|program_to_single)' -and
      $routeConfirmationSection -match '(?i)route_delta_reason\s*(\||[:=])\s*[^|\r\n<>]{4,}') {
    $checks.Add((New-HandoffCheck 'handoff-route-confirmation' 'pass' '10 route recheck is explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-route-confirmation' 'fail' '10->20 handoff needs Route Confirmation with recheck source, delta, and reason')) | Out-Null
  }
  $sourceSection = Get-MarkdownSection -Text $HandoffText -Heading 'Source Summary'
  if ($sourceSection -match '(?i)S-[0-9]{3}' -and $sourceSection -match '(?i)reviewed|collected|target|unavailable') {
    $checks.Add((New-HandoffCheck 'handoff-source-summary' 'pass' 'source summary includes concrete source ids and status')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-source-summary' 'fail' '20 needs source summary with S-### source_id and status')) | Out-Null
  }
  if ($sourceSection -match '(?im)\|\s*[^|]*\|\s*S-[0-9]{3}\s*\|\s*[^|]*\|\s*provided\s*\|') {
    $checks.Add((New-HandoffCheck 'handoff-source-status-normalized' 'fail' '10->20 source status must not contain provided')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-source-status-normalized' 'pass' 'no obvious provided status remains in source summary')) | Out-Null
  }

  $observedSection = Get-MarkdownSection -Text $HandoffText -Heading 'Observed Facts For 20'
  if ($observedSection -match '(?i)C-[0-9]{3}' -and $observedSection -match '(?i)S-[0-9]{3}' -and $observedSection -match '(?i)low|medium|high') {
    $checks.Add((New-HandoffCheck 'handoff-observed-facts' 'pass' 'observed facts include claim_id, source_id, and confidence')) | Out-Null
  } elseif ($GateResult -eq 'pass') {
    $checks.Add((New-HandoffCheck 'handoff-observed-facts' 'fail' 'pass requires at least one observed fact with claim_id, source_id, and confidence')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-observed-facts' 'warn' 'defer handoff has weak observed facts; main judgment required')) | Out-Null
  }

  $personSection = Get-MarkdownSection -Text $HandoffText -Heading 'Person Explanations For 20'
  if ($personSection -match '(?i)C-[0-9]{3}|none|なし|該当なし') {
    $checks.Add((New-HandoffCheck 'handoff-person-explanations' 'pass' 'person explanations are explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-person-explanations' 'fail' 'person explanations must be listed or explicitly none')) | Out-Null
  }

  $hypothesisSection = Get-MarkdownSection -Text $HandoffText -Heading 'Hypotheses / Unconfirmed'
  if ($hypothesisSection -match '(?i)C-[0-9]{3}|none|なし|該当なし') {
    $checks.Add((New-HandoffCheck 'handoff-hypotheses-unconfirmed' 'pass' 'hypotheses/unconfirmed are explicit')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-hypotheses-unconfirmed' 'fail' 'hypotheses/unconfirmed must be listed or explicitly none')) | Out-Null
  }

  $deferredSection = Get-MarkdownSection -Text $HandoffText -Heading 'Deferred Claims For 20'
  if ($GateResult -eq 'defer') {
    if ($deferredSection -match '(?i)C-[0-9]{3}' -and $deferredSection -match '(?i)why_20_can_continue|20で' -and $deferredSection -match '(?i)next_check|追加source|owner確認' -and $deferredSection -match '(?i)must_resolve_before|30-route-executor|40-ir-freeze') {
      $checks.Add((New-HandoffCheck 'handoff-deferred-claims' 'pass' 'defer handoff contains bounded deferred claims for 20')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'handoff-deferred-claims' 'fail' 'defer handoff needs claim_id, why_20_can_continue, next_check, and must_resolve_before')) | Out-Null
    }
  } else {
    if ($deferredSection -match '(?i)C-[0-9]{3}') {
      $checks.Add((New-HandoffCheck 'handoff-pass-no-deferred-claims' 'fail' 'pass handoff must not include deferred claims for 20')) | Out-Null
    } else {
      $checks.Add((New-HandoffCheck 'handoff-pass-no-deferred-claims' 'pass' 'pass handoff has no deferred claims')) | Out-Null
    }
  }

  $reviewerSection = Get-MarkdownSection -Text $HandoffText -Heading 'Reviewer Notes'
  if ($reviewerSection -match '(?i)20へ渡す|10へ戻す|00へ戻す|stop|Action') {
    $checks.Add((New-HandoffCheck 'handoff-reviewer-notes' 'pass' 'reviewer notes include action routing')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-reviewer-notes' 'fail' 'reviewer notes must tell 20/10/00/stop action implications')) | Out-Null
  }

  $scopeSection = Get-MarkdownSection -Text $HandoffText -Heading 'Scope / Gate Notes'
  $scopeLabels = @('external candidate', 'sensitive candidate', 'out-of-scope')
  $missingScope = @($scopeLabels | Where-Object { $scopeSection -notmatch ('(?i)' + [regex]::Escape($_)) })
  if ($missingScope.Count -eq 0) {
    $checks.Add((New-HandoffCheck 'handoff-scope-gate-notes' 'pass' 'scope/gate notes cover external, sensitive, and out-of-scope')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-scope-gate-notes' 'fail' ('scope/gate notes missing: ' + ($missingScope -join ', ')))) | Out-Null
  }

  if ($HandoffText -match '(?i)executor routing.*(決め|確定|fixed)|automation.*(決め|確定|fixed)|IR freeze|manifest.*(凍結|確定|fixed)|consent.*(設計|決め|確定|fixed)') {
    $checks.Add((New-HandoffCheck 'handoff-phase-boundary' 'fail' 'handoff appears to decide 30/40/50+ matters inside 10')) | Out-Null
  } else {
    $checks.Add((New-HandoffCheck 'handoff-phase-boundary' 'pass' 'handoff does not obviously decide later phases')) | Out-Null
  }

  return $checks.ToArray()
}
function Write-Or-Print {
  param([string]$Content, [string]$TargetPath, [string]$Label)
  if ($NoWrite) {
    Write-Output $Content
    return
  }
  $parent = Split-Path -Parent $TargetPath
  if (-not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent | Out-Null }
  $encoding = [System.Text.UTF8Encoding]::new($false)
  [System.IO.File]::WriteAllText($TargetPath, $Content.TrimEnd() + "`n", $encoding)
  Write-Host "${Label}: $TargetPath"
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
    'knowledge/docs/meta/phase-catalog.md',
    'knowledge/docs/ir/evidence-confidence-model.md'
  )
  $phaseItems = @(
    'README.md',
    'questions.md',
    'checks.md',
    'contract.md',
    'handoff.md',
    'artifacts/source-inventory.md',
    'artifacts/intake-log.md',
    'artifacts/fact-register.md',
    '_context/dispatch-packet.md',
    '_context/dispatch-checks.md'
  )

  $rows = New-Object System.Collections.Generic.List[object]
  foreach ($item in $rootItems) {
    $fullPath = Join-Path $repoRoot ($item -replace '/', '\')
    $rows.Add([pscustomobject]@{ path = $item; source = 'repo-root'; exists = [bool](Test-Path -LiteralPath $fullPath); full_path = $fullPath }) | Out-Null
  }
  foreach ($item in $phaseItems) {
    $fullPath = Join-Path $PhasePath ($item -replace '/', '\')
    $rows.Add([pscustomobject]@{ path = $item; source = 'phase-dir'; exists = [bool](Test-Path -LiteralPath $fullPath); full_path = $fullPath }) | Out-Null
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
    [pscustomobject]@{ path = $_; exists = [bool](Test-Path -LiteralPath $resolved); resolved = $resolved }
  })
}

function Get-DispatchPacketText {
  param([string]$PhasePath)
  $path = Join-Path $PhasePath '_context\dispatch-packet.md'
  if (Test-Path -LiteralPath $path) { return [System.IO.File]::ReadAllText($path) }
  throw 'dispatch-packet.md not found'
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
    '(?im)^\s*\|\s*(source_gate_result|gate_result|result)\s*\|\s*(pass|defer|rework|stop)\s*\|',
    '(?im)(source[_ -]?gate[_ ]?result|gate_result)\s*[:：]\s*(pass|defer|rework|stop)',
    '(?im)^\s*source[_ -]?gate[_ ]?result\s*=\s*(pass|defer|rework|stop)',
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
  if ($normalized -match '(?i)non[- ]terminal|non-terminal loop|10内|追加観測|追加確認') { return 'non-terminal loop' }
  if ($normalized -match '(?i)terminal') { return 'terminal' }
  return ''
}

function Get-IntMetadataValue {
  param([string]$Text, [string[]]$Names)
  foreach ($name in $Names) {
    $escaped = [regex]::Escape($name)
    $patterns = @(
      "(?im)(^|\|)\s*$escaped\s*(\||[:：=])\s*(?<value>[0-9]+)",
      "(?im)^\s*$escaped\s*[:：=]\s*(?<value>[0-9]+)"
    )
    foreach ($pattern in $patterns) {
      $match = [regex]::Match($Text, $pattern)
      if ($match.Success) { return [int]$match.Groups['value'].Value }
    }
  }
  return $null
}

function Invoke-Start {
  $phasePath = Get-PhaseDirectory
  $outPath = Get-OutputDirectory -PhasePath $phasePath
  if ((Test-IsTemplatePhaseDir -Path $phasePath) -and -not $NoWrite -and -not $AllowTemplateWrite -and -not $OutDir) {
    throw 'Refusing to write _work under template/10-source-intake. Use -NoWrite for preview, pass -OutDir, or add -AllowTemplateWrite explicitly.'
  }

  $entryHandoffText = $EntryHandoff
  if ($EntryHandoffFile) { $entryHandoffText = Read-TextFileOrEmpty -Path $EntryHandoffFile }
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
# 10-source-intake Phase Dispatch Bundle

Generated at: $now
Phase dir: $phaseRel`

## Operator Steps

1. 10担当subagentへ Dispatch Prompt 以降を渡す。
2. subagent返答をファイルへ保存する。
3. main agentが次を実行してreviewする。

.\phase-orchestrator.ps1 review -SubagentResultFile "<subagent-result.md>"

4. reviewer_result = preflight_retry なら10を開始せず必読ファイルを読了まで再読込する。ask_rework ならrework_targetへ戻す。accept_pass / accept_defer なら `finalize` で handoff.md をmaterializeして20へ進める。accept_stop なら停止理由を残す。

## 00 Handoff / Entry Context

$entryHandoffText

## Materials

$materialTable

## Conversation Context

$conversationText

## Required Files Status

$requiredTable

## Dispatch Prompt

$dispatchPacket
"@

  $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
  $target = Join-Path $outPath "10-source-intake-dispatch-$stamp.md"
  Write-Or-Print -Content $content -TargetPath $target -Label 'phase-orchestrator: wrote dispatch bundle'
}

function Invoke-Review {
  $phasePath = Get-PhaseDirectory
  $outPath = Get-OutputDirectory -PhasePath $phasePath
  if ((Test-IsTemplatePhaseDir -Path $phasePath) -and -not $NoWrite -and -not $AllowTemplateWrite -and -not $OutDir) {
    throw 'Refusing to write _work under template/10-source-intake. Use -NoWrite for preview, pass -OutDir, or add -AllowTemplateWrite explicitly.'
  }

  $resultText = $SubagentResult
  if ($SubagentResultFile) { $resultText = Read-TextFileOrEmpty -Path $SubagentResultFile }
  if (-not $resultText) { throw 'review requires -SubagentResult or -SubagentResultFile' }

  $checks = New-Object System.Collections.Generic.List[object]
  $normalized = $resultText -replace '`', ''
  $gateResult = Find-GateResult -Text $normalized
  $terminality = Find-Terminality -Text $normalized
  $readFailurePattern = Get-PreflightReadFailurePattern
  $preflightScanText = Get-TextBeforeHandoffDraft -Text $normalized
  $preflightRetry = $preflightScanText -match $readFailurePattern
  $phaseBoundaryPattern = '(?i)executor routing.*(決め|確定|fixed)|automation / Skill.*(決め|確定|fixed)|automation候補.*(決め|確定|fixed)|executor.*(決め|確定|fixed)|IR freeze|manifest.*(凍結|確定|fixed)|consent.*(設計|決め|確定|fixed)|validation plan.*(作|設計|確定|fixed)|As-Is.*完了|20で分解済'
  $providedStatusPattern = '(?im)(status\s*[:：=\|]\s*provided|\|\s*provided\s*\|)'
  $reviewedWithoutClaimPattern = '(?i)reviewed.*(claimなし|source_idなし|未接続|not connected)'
  $questionTurnCount = Get-IntMetadataValue -Text $normalized -Names @('question_turn_count', 'questions_asked_count', 'asked_question_count')
  $materialEvidenceCount = Get-IntMetadataValue -Text $normalized -Names @('material_evidence_count', 'reviewed_material_count', 'source_material_count')
  $sourceContactAttemptCount = Get-IntMetadataValue -Text $normalized -Names @('source_contact_attempt_count', 'source_holder_contact_count', 'source_contact_count')
  $hasSourceInteractionState = $normalized -match '(?i)source_intake_interaction|question_turn_count|questions_asked_count|material_evidence_count|source_contact_attempt_count|source_holder_contact_count'

  if ($preflightRetry) {
    Add-ReviewCheck $checks 'preflight-confirmation' 'fail' '必読ファイルのtimeout/未読/読込失敗は10-source-intakeの分岐ではなくpreflight retry対象'
  } elseif ($preflightScanText -match '(?i)preflight確認|前提ファイル確認|必読ファイル|read files|required files') {
    Add-ReviewCheck $checks 'preflight-confirmation' 'pass' 'preflight確認がある'
  } else {
    Add-ReviewCheck $checks 'preflight-confirmation' 'fail' 'preflight確認が見えない'
  }

  if (-not $preflightRetry -and ($gateResult -eq 'pass' -or $gateResult -eq 'defer')) {
    if ($hasSourceInteractionState) {
      Add-ReviewCheck $checks 'source-intake-interaction' 'pass' 'source intake interaction metadataがある'
    } else {
      Add-ReviewCheck $checks 'source-intake-interaction' 'fail' 'pass/defer terminal resultにはsource_intake_interaction、質問回数、資料確認数、source holder接続数のメタデータが必要'
    }

    if ($null -ne $questionTurnCount -and $questionTurnCount -gt 3) {
      Add-ReviewCheck $checks 'question-turn-budget' 'fail' '10の初回source確認で一度に質問を投げすぎている。最大3問までに絞る'
    } elseif ($null -ne $questionTurnCount) {
      Add-ReviewCheck $checks 'question-turn-budget' 'pass' "question_turn_count = $questionTurnCount"
    }

    $sourceWorkCount = 0
    if ($null -ne $materialEvidenceCount) { $sourceWorkCount += $materialEvidenceCount }
    if ($null -ne $sourceContactAttemptCount) { $sourceWorkCount += $sourceContactAttemptCount }
    if ($null -ne $materialEvidenceCount -and $null -ne $sourceContactAttemptCount) {
      if ($sourceWorkCount -gt 0) {
        Add-ReviewCheck $checks 'terminal-source-work' 'pass' 'terminal result前に資料確認またはsource holder接続がある'
      } else {
        Add-ReviewCheck $checks 'terminal-source-work' 'fail' '資料確認もsource holder接続もないまま10をpass/defer terminalにしている'
      }
    } else {
      Add-ReviewCheck $checks 'terminal-source-work' 'fail' 'pass/defer terminal resultにはmaterial_evidence_countとsource_contact_attempt_countが必要'
    }

    if ($gateResult -eq 'pass' -and ($null -eq $materialEvidenceCount -or $materialEvidenceCount -lt 1)) {
      Add-ReviewCheck $checks 'pass-needs-reviewed-material' 'fail' 'passには少なくとも1つの実資料/ログ/画面/観測source確認が必要'
    }
  }

  if ($preflightRetry) {
    $review = [pscustomobject]@{
      phase_id = '10-source-intake'
      reviewer_result = 'preflight_retry'
      accepted_source_gate_result = ''
      terminality = ''
      handoff_ready = 'no'
      required_follow_up = '10-source-intakeの質問へ戻さず、必読ファイルを読了するまで再読込する'
      residual_risk = 'preflight retry required until all required files are read'
      checks = $checks.ToArray()
    }

    if ($Format -eq 'json') {
      $json = $review | ConvertTo-Json -Depth 8
      $targetJson = Join-Path $outPath ('10-source-intake-review-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.json')
      Write-Or-Print -Content $json -TargetPath $targetJson -Label 'phase-orchestrator: wrote review json'
      return
    }

    $checkRows = @($checks | ForEach-Object { [pscustomobject]@{ id = $_.id; status = $_.status; message = $_.message } })
    $checkTable = New-MarkdownTable -Rows $checkRows -Columns @('id', 'status', 'message')
    $content = @"
# 10-source-intake Phase Review

| Field | Value |
|---|---|
| phase_id | 10-source-intake |
| reviewer_result | preflight_retry |
| accepted_source_gate_result |  |
| terminality |  |
| handoff_ready | no |
| required_follow_up | 10-source-intakeの質問へ戻さず、必読ファイルを読了するまで再読込する |
| residual_risk | preflight retry required until all required files are read |

## Checks

$checkTable

## Next Action

- preflight_retry: 10-source-intakeを開始せず、必読ファイルを読了するまで再読込する。
"@
    $target = Join-Path $outPath ('10-source-intake-review-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.md')
    Write-Or-Print -Content $content -TargetPath $target -Label 'phase-orchestrator: wrote review'
    return
  }

  if ($normalized -match '(?i)source_inventory|source inventory|source-inventory|source_id|S-[0-9]') {
    Add-ReviewCheck $checks 'source-inventory' 'pass' 'source inventoryまたはsource_idが見える'
  } else {
    Add-ReviewCheck $checks 'source-inventory' 'fail' 'source inventory / source_id が見えない'
  }

  if ($normalized -match $providedStatusPattern) {
    Add-ReviewCheck $checks 'status-normalization' 'fail' '10 statusに provided が残っている。00 provided は collected + not_reviewed へ正規化する'
  } elseif ($normalized -match '(?i)target|collected|reviewed|unavailable') {
    Add-ReviewCheck $checks 'status-normalization' 'pass' '10のsource statusが見える'
  } else {
    Add-ReviewCheck $checks 'status-normalization' 'fail' 'source status が見えない'
  }

  if ($normalized -match '(?i)primary|secondary|hearsay|assumption') {
    Add-ReviewCheck $checks 'source-class' 'pass' 'source_classの区別がある'
  } else {
    Add-ReviewCheck $checks 'source-class' 'fail' 'primary / secondary / hearsay / assumption の区別が見えない'
  }

  if ($normalized -match '(?i)observed_fact' -and $normalized -match '(?i)person_explanation' -and ($normalized -match '(?i)hypothesis|unconfirmed')) {
    Add-ReviewCheck $checks 'claim-separation' 'pass' 'claim typeが分離されている'
  } else {
    Add-ReviewCheck $checks 'claim-separation' 'fail' 'observed_fact / person_explanation / hypothesis / unconfirmed の分離が見えない'
  }

  if ($normalized -match '(?i)provenance' -and $normalized -match '(?i)confidence' -and $normalized -match '(?i)source_ids?|S-[0-9]') {
    Add-ReviewCheck $checks 'provenance-confidence' 'pass' '主要claimのsource/provenance/confidenceが見える'
  } else {
    Add-ReviewCheck $checks 'provenance-confidence' 'fail' '主要claimのsource_id / provenance / confidence が不足している'
  }

  if ($normalized -match '(?i)owner|source_holder|source holder|approver|permission|authorization|閲覧範囲|利用許可|承認') {
    Add-ReviewCheck $checks 'permission-risk' 'pass' 'owner/permission/riskの扱いが見える'
  } else {
    Add-ReviewCheck $checks 'permission-risk' 'fail' 'owner、source holder、承認、利用許可の扱いが見えない'
  }

  if ($normalized -match '(?i)counter_evidence|counter evidence|near-miss|near miss|差戻し|矛盾|反例|例外') {
    Add-ReviewCheck $checks 'counter-evidence' 'pass' '反例/矛盾/near-missの扱いが見える'
  } else {
    Add-ReviewCheck $checks 'counter-evidence' 'warn' '反例、差戻し、near-missが空なのか未確認なのか要確認'
  }

  if ($normalized -match $phaseBoundaryPattern) {
    Add-ReviewCheck $checks 'phase-boundary' 'fail' '10で20以降の分解、routing、IR、consent、validationを決めている可能性がある'
  } else {
    Add-ReviewCheck $checks 'phase-boundary' 'pass' '明らかな後続phase確定は見えない'
  }

  if ($normalized -match $reviewedWithoutClaimPattern) {
    Add-ReviewCheck $checks 'reviewed-claim-link' 'fail' 'reviewed source がclaimへ接続されていない可能性がある'
  }

  $factRegisterForBoundary = Get-MarkedBlock -Text $resultText -MarkerName '10_FACT_REGISTER'
  if (-not $factRegisterForBoundary) { $factRegisterForBoundary = $normalized }
  if ($factRegisterForBoundary -match '(?im)^\|[^\r\n]*\b(person_explanation|hypothesis|unconfirmed)\b[^\r\n]*\|\s*observed\s*\|') {
    Add-ReviewCheck $checks 'claim-provenance-boundary' 'fail' 'person_explanation / hypothesis / unconfirmed を provenance=observed として扱っている。observedにできるのは発話や資料の存在であり、主張内容はhypothesized等に分ける'
  } else {
    Add-ReviewCheck $checks 'claim-provenance-boundary' 'pass' 'claim_type と provenance の明らかな昇格は見えない'
  }
  if ($factRegisterForBoundary -match '(?im)^\|[^\r\n]*\|\s*reported\s*\|') {
    Add-ReviewCheck $checks 'provenance-vocabulary' 'fail' 'provenance=reported は10標準外。observed / hypothesized / negotiated / derived に正規化する'
  } else {
    Add-ReviewCheck $checks 'provenance-vocabulary' 'pass' '明らかな標準外provenance値は見えない'
  }

  if ($gateResult) {
    Add-ReviewCheck $checks 'source-gate-result' 'pass' "source_gate_result = $gateResult"
  } else {
    Add-ReviewCheck $checks 'source-gate-result' 'fail' 'source_gate_result が見えない'
  }
  if ($gateResult -eq 'pass' -or $gateResult -eq 'defer') {
    if (Test-HasHandoffDraft -Text $resultText) {
      Add-ReviewCheck $checks 'handoff-draft' 'pass' 'terminal result に 10_HANDOFF_START / 10_HANDOFF_END で囲まれたhandoff draftがある'
      $handoffDraft = Get-HandoffDraft -Text $resultText
      foreach ($handoffCheck in (Test-HandoffMinimumFor20 -HandoffText $handoffDraft -GateResult $gateResult)) {
        Add-ReviewCheck $checks $handoffCheck.id $handoffCheck.status $handoffCheck.message
      }
      foreach ($artifactCheck in (Test-OutputArtifactsMinimumFor20 -ResultText $resultText)) {
        Add-ReviewCheck $checks $artifactCheck.id $artifactCheck.status $artifactCheck.message
      }
    } else {
      Add-ReviewCheck $checks 'handoff-draft' 'fail' 'pass/defer は 20へ渡す handoff.md materialize 用の handoff draft を必ず含める'
    }
  }

  if ($gateResult -eq 'pass') {
    if ($normalized -match '(?i)unconfirmed.*used_by_20\s*[:：=\|]\s*yes|hypothesis.*used_by_20\s*[:：=\|]\s*yes') {
      Add-ReviewCheck $checks 'pass-strictness' 'fail' 'passなのに unconfirmed/hypothesis を20で確定扱いしている可能性がある'
    }
    $factRegisterForPromotion = Get-MarkedBlock -Text $resultText -MarkerName '10_FACT_REGISTER'
    if (-not $factRegisterForPromotion) { $factRegisterForPromotion = $normalized }
    $subjectivePromotionPattern = '(?im)^\|[^\r\n]*\b(hearsay|assumption)\b[^\r\n]*\bobserved_fact\b[^\r\n]*$|^\|[^\r\n]*\bobserved_fact\b[^\r\n]*\b(hearsay|assumption)\b[^\r\n]*$'
    if ($factRegisterForPromotion -match $subjectivePromotionPattern) {
      Add-ReviewCheck $checks 'subjective-promotion' 'fail' 'hearsay/assumptionをobserved_factへ昇格している可能性がある'
    }
  }

  if ($gateResult -eq 'defer') {
    if ($normalized -match '(?i)deferred_items|deferred|Next check|next_check|first_check_phase|must_resolve_before|未確認.*20') {
      Add-ReviewCheck $checks 'defer-policy' 'pass' 'defer項目と次の確認先が見える'
    } else {
      Add-ReviewCheck $checks 'defer-policy' 'fail' 'deferなのに deferred_items / 次の確認先が見えない'
    }
  }

  if ($gateResult -eq 'rework') {
    if ($terminality -eq 'non-terminal loop') {
      Add-ReviewCheck $checks 'rework-terminality' 'pass' 'rework がnon-terminal loopとして扱われている'
    } else {
      Add-ReviewCheck $checks 'rework-terminality' 'fail' 'rework をterminal扱いしていないか確認が必要'
    }
    if ($normalized -match '(?i)rework_target\s*[:：=\|]\s*(10-source-intake|00-entry)|rework target|追加観測|追加source|00へ戻') {
      Add-ReviewCheck $checks 'rework-target' 'pass' 'rework_targetが見える'
    } else {
      Add-ReviewCheck $checks 'rework-target' 'fail' 'rework_target が見えない'
    }
  }

  if ($gateResult -eq 'stop') {
    if ($normalized -match '(?i)stop_reason|停止理由|unauthorized|承認迂回|同意なし|権限なし') {
      Add-ReviewCheck $checks 'stop-reason' 'pass' 'stop理由がある'
    } else {
      Add-ReviewCheck $checks 'stop-reason' 'fail' 'stop には停止理由が必要'
    }
  }

  $hasFail = @($checks | Where-Object { $_.status -eq 'fail' }).Count -gt 0
  $hasWarn = @($checks | Where-Object { $_.status -eq 'warn' }).Count -gt 0
  $reviewerResult = 'ask_rework'
  $handoffReady = 'no'
  $requiredFollowUp = '10内でsource、claim分離、provenance、permissionの不足を追加確認する'

  if ($preflightRetry) {
    $reviewerResult = 'preflight_retry'
    $handoffReady = 'no'
    $requiredFollowUp = '10-source-intakeの質問へ戻さず、必読ファイルを読了するまで再読込する'
  }

  if ((-not $hasFail) -and (-not $preflightRetry)) {
    switch ($gateResult) {
      'pass' {
        $reviewerResult = 'accept_pass'
        $handoffReady = 'yes'
        $requiredFollowUp = ''
      }
      'defer' {
        $reviewerResult = 'accept_defer'
        $handoffReady = 'yes'
        $requiredFollowUp = ''
      }
      'stop' {
        $reviewerResult = 'accept_stop'
        $handoffReady = 'no'
        $requiredFollowUp = ''
      }
      'rework' {
        $reviewerResult = 'ask_rework'
        $handoffReady = 'no'
      }
    }
  }

  if ($hasWarn -and ($reviewerResult -eq 'accept_pass')) {
    $reviewerResult = 'main_override'
    $handoffReady = 'no'
    $requiredFollowUp = 'warning項目をmainが確認し、passのまま閉じるかdefer/reworkへ修正する'
  }

  $residualRisk = 'none from deterministic checks'
  if ($hasWarn) { $residualRisk = 'warnings require main judgment' }
  if ($hasFail) { $residualRisk = 'failed checks block handoff' }
  if ($preflightRetry) { $residualRisk = 'preflight retry required until all required files are read' }

  $review = [pscustomobject]@{
    phase_id = '10-source-intake'
    reviewer_result = $reviewerResult
    accepted_source_gate_result = $gateResult
    terminality = $terminality
    handoff_ready = $handoffReady
    required_follow_up = $requiredFollowUp
    residual_risk = $residualRisk
    checks = $checks.ToArray()
  }

  if ($Format -eq 'json') {
    $json = $review | ConvertTo-Json -Depth 8
    $targetJson = Join-Path $outPath ('10-source-intake-review-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.json')
    Write-Or-Print -Content $json -TargetPath $targetJson -Label 'phase-orchestrator: wrote review json'
    return
  }

  $checkRows = @($checks | ForEach-Object { [pscustomobject]@{ id = $_.id; status = $_.status; message = $_.message } })
  $checkTable = New-MarkdownTable -Rows $checkRows -Columns @('id', 'status', 'message')
  $content = @"
# 10-source-intake Phase Review

| Field | Value |
|---|---|
| phase_id | 10-source-intake |
| reviewer_result | $reviewerResult |
| accepted_source_gate_result | $gateResult |
| terminality | $terminality |
| handoff_ready | $handoffReady |
| required_follow_up | $requiredFollowUp |
| residual_risk | $residualRisk |

## Checks

$checkTable

## Next Action

- preflight_retry: 10-source-intakeを開始せず、必読ファイルを読了するまで再読込する。
- accept_pass: `finalize -SubagentResultFile <subagent-result.md> -TargetDir output/Biz-XXX-業務名/10-source-intake` で `handoff.md` をmaterializeし、20-decompose-encrsへ進める。
- accept_defer: deferred_items と20での扱いを含むdraftから `finalize -SubagentResultFile <subagent-result.md> -TargetDir output/Biz-XXX-業務名/10-source-intake` で `handoff.md` をmaterializeし、20-decompose-encrsへ進める。
- ask_rework: rework_target に従い、10内の追加観測または00-entryへ戻す。
- accept_stop: stop理由を contract.md / intake-log.md に残して閉じる。
- main_override: main agentが理由を残してgate resultを修正する。
"@
  $target = Join-Path $outPath ('10-source-intake-review-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.md')
  Write-Or-Print -Content $content -TargetPath $target -Label 'phase-orchestrator: wrote review'
}

function Invoke-Finalize {
  $phasePath = Get-PhaseDirectory
  $targetPath = Get-FinalizeDirectory -PhasePath $phasePath
  if ((Test-IsTemplatePhaseDir -Path $targetPath) -and -not $AllowTemplateWrite) {
    throw 'Refusing to finalize under template/10-source-intake. Pass -TargetDir for output/Biz-XXX/10-source-intake, use -PhaseDir for an output phase dir, or add -AllowTemplateWrite explicitly.'
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
  $handoffChecks = @(Test-HandoffMinimumFor20 -HandoffText $handoff -GateResult $gateResult)
  $artifactChecks = @(Test-OutputArtifactsMinimumFor20 -ResultText $resultText)
  $failedHandoffChecks = @($handoffChecks + $artifactChecks | Where-Object { $_.status -eq 'fail' })
  if ($failedHandoffChecks.Count -gt 0) {
    $messages = @($failedHandoffChecks | ForEach-Object { $_.id + ': ' + $_.message }) -join '; '
    throw ('10 output minimum check failed: ' + $messages)
  }

  $sourceInventory = Get-MarkedBlock -Text $resultText -MarkerName '10_SOURCE_INVENTORY'
  $intakeLog = Get-MarkedBlock -Text $resultText -MarkerName '10_INTAKE_LOG'
  $factRegister = Get-MarkedBlock -Text $resultText -MarkerName '10_FACT_REGISTER'

  if (-not (Test-Path -LiteralPath $targetPath)) { New-Item -ItemType Directory -Path $targetPath | Out-Null }
  $artifactDir = Join-Path $targetPath 'artifacts'
  if (-not (Test-Path -LiteralPath $artifactDir)) { New-Item -ItemType Directory -Path $artifactDir | Out-Null }

  $encoding = [System.Text.UTF8Encoding]::new($false)
  $handoffPath = Join-Path $targetPath 'handoff.md'
  $sourceInventoryPath = Join-Path $artifactDir 'source-inventory.md'
  $intakeLogPath = Join-Path $artifactDir 'intake-log.md'
  $factRegisterPath = Join-Path $artifactDir 'fact-register.md'
  [System.IO.File]::WriteAllText($handoffPath, $handoff.TrimEnd() + "`n", $encoding)
  [System.IO.File]::WriteAllText($sourceInventoryPath, $sourceInventory.TrimEnd() + "`n", $encoding)
  [System.IO.File]::WriteAllText($intakeLogPath, $intakeLog.TrimEnd() + "`n", $encoding)
  [System.IO.File]::WriteAllText($factRegisterPath, $factRegister.TrimEnd() + "`n", $encoding)
  Write-Output ("phase-orchestrator: wrote handoff: " + $handoffPath)
  Write-Output ("phase-orchestrator: wrote artifact: " + $sourceInventoryPath)
  Write-Output ("phase-orchestrator: wrote artifact: " + $intakeLogPath)
  Write-Output ("phase-orchestrator: wrote artifact: " + $factRegisterPath)
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
    'artifacts/source-inventory.md',
    'artifacts/intake-log.md',
    'artifacts/fact-register.md'
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
# 10-source-intake Phase Orchestrator Status

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
    '# 10-source-intake Phase Orchestrator',
    '',
    'Commands:',
    '',
    'Create a dispatch bundle for the 10担当subagent:',
    '.\phase-orchestrator.ps1 start -EntryHandoffFile "output/Biz-001-demo/00-entry/handoff.md" -Materials "docs/manual.md;docs/sample.xlsx" -OutDir "output/Biz-001-demo/10-source-intake/_work"',
    '',
    'Review a subagent result and decide pass/defer/rework/stop handling:',
    '.\phase-orchestrator.ps1 review -SubagentResultFile "output/Biz-001-demo/10-source-intake/_work/subagent-result.md"',
    '',
    'JSON review, suitable for validators:',
    '.\phase-orchestrator.ps1 review -SubagentResultFile "output/Biz-001-demo/10-source-intake/_work/subagent-result.md" -Format json',
    '',
    'Materialize handoff.md from an accepted pass/defer terminal result:',
    '.\phase-orchestrator.ps1 finalize -SubagentResultFile "output/Biz-001-demo/10-source-intake/_work/subagent-result.md" -TargetDir "output/Biz-001-demo/10-source-intake"',
    '',
    'Inspect phase-local files:',
    '.\phase-orchestrator.ps1 status',
    '',
    'Notes:',
    '',
    '- start refuses to write under template/10-source-intake/_work unless -OutDir, -NoWrite, or -AllowTemplateWrite is supplied.',
    '- review is deterministic and conservative. It blocks obvious source/provenance/confidence/handoff mistakes.',
    '- finalize writes only a pass/defer result that contains 10_HANDOFF plus source-inventory / intake-log / fact-register draft blocks and passes the 20-decompose-encrs minimum checks.',
    '- rework remains a non-terminal loop. Do not advance to 20-decompose-encrs from rework.'
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
