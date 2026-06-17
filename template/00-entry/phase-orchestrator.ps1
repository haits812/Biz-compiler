[CmdletBinding()]
param(
  [Parameter(Position = 0)]
  [ValidateSet('start', 'review', 'status', 'help')]
  [string]$Command = 'help',

  [string]$PhaseDir,
  [string]$OutDir,
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
  return @($Items | ForEach-Object {
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

4. reviewer_result = ask_rework なら00内で追加質問に戻す。accept_pass / accept_defer なら handoff.md を埋めて10へ進める。accept_stop なら停止理由を残す。

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

1. 前提ファイル確認
2. 入口判断の結論
3. entry_gate_result と terminality
4. 10へ渡すsource候補
5. low confidence hypotheses。assistant補完、本人説明、source候補、合意scopeを分ける
6. risk / unknown / later phase notes
7. rework の場合は次の00質問。terminal resultの場合はmainに確認してほしい点
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

  if ($normalized -match '(?i)前提ファイル確認|必読ファイル|read files|required files') {
    Add-ReviewCheck $checks 'read-confirmation' 'pass' '前提ファイル確認がある'
  } else {
    Add-ReviewCheck $checks 'read-confirmation' 'fail' '前提ファイル確認が見えない'
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

  if ($gateResult) {
    Add-ReviewCheck $checks 'entry-gate-result' 'pass' "entry_gate_result = $gateResult"
  } else {
    Add-ReviewCheck $checks 'entry-gate-result' 'fail' 'entry_gate_result が見えない'
  }

  if ($gateResult -eq 'rework') {
    if ($terminality -eq 'non-terminal loop') {
      Add-ReviewCheck $checks 'rework-terminality' 'pass' 'rework がnon-terminal loopとして扱われている'
    } else {
      Add-ReviewCheck $checks 'rework-terminality' 'fail' 'rework をterminal扱いしていないか確認が必要'
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

  if ($gateResult -eq 'pass' -and $normalized -match '(?i)proxy|hearsay|伝聞|代理|authorization_unclear|権限不明|sensitive_data\s*\|\s*yes|irreversible_action\s*\|\s*yes|external_impact\s*\|\s*yes') {
    Add-ReviewCheck $checks 'pass-strictness' 'warn' 'passにするには強い未確認riskが残っていないかmain reviewが必要'
  }

  $hasFail = @($checks | Where-Object { $_.status -eq 'fail' }).Count -gt 0
  $hasWarn = @($checks | Where-Object { $_.status -eq 'warn' }).Count -gt 0
  $reviewerResult = 'ask_rework'
  $handoffReady = 'no'
  $requiredFollowUpQuestion = '00内で、entry_type、target、source候補、riskの不足を1つずつ補う質問に戻す'

  if (-not $hasFail) {
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

- accept_pass: handoff.md を作り、通常のsource確認として10-source-intakeへ進める。
- accept_defer: 未確認事項を明記して handoff.md を作り、10-source-intakeへ進める。
- ask_rework: 00内で追加質問し、subagent返答を更新してもう一度reviewする。
- accept_stop: stop理由を contract.md / initial-risk-memo.md に残して閉じる。
- main_override: main agentが理由を残してgate resultを修正する。
"@
  $target = Join-Path $outPath ('00-entry-review-' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '.md')
  Write-Or-Print -Content $content -TargetPath $target -Label 'phase-orchestrator: wrote review'
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
    'Inspect phase-local files:',
    '.\phase-orchestrator.ps1 status',
    '',
    'Notes:',
    '',
    '- start refuses to write under template/00-entry/_work unless -OutDir, -NoWrite, or -AllowTemplateWrite is supplied.',
    '- review is deterministic and conservative. It does not prove business correctness; it blocks obvious 00-entry handoff mistakes and flags main review risks.',
    '- rework remains a non-terminal loop. Do not advance to 10-source-intake from rework.'
  )
  Write-Output ($lines -join "`n")
}

switch ($Command) {
  'start' { Invoke-Start }
  'review' { Invoke-Review }
  'status' { Invoke-Status }
  'help' { Invoke-Help }
}
