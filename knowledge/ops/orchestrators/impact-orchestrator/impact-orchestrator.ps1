[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [ValidateSet("register", "complete", "locks", "release-locks")]
  [string]$Action = "register",

  [Parameter(Mandatory=$false)]
  [switch]$Complete,

  [Parameter(Mandatory=$false)]
  [switch]$ListLocks,

  [Parameter(Mandatory=$false)]
  [switch]$ReleaseLocks,

  [Parameter(Mandatory=$false)]
  [string]$Title = "",

  [Parameter(Mandatory=$false)]
  [string]$Kind = "work",

  [Parameter(Mandatory=$false)]
  [string]$Intent = "",

  [Parameter(Mandatory=$false)]
  [string]$Impact = "",

  [Parameter(Mandatory=$false)]
  [string[]]$Files = @(),

  [Parameter(Mandatory=$false)]
  [string]$Executor = "codex",

  [Parameter(Mandatory=$false)]
  [ValidateSet("low", "medium", "high", "unknown")]
  [string]$Risk = "medium",

  [Parameter(Mandatory=$false)]
  [string]$WorkCard = "",

  [Parameter(Mandatory=$false)]
  [ValidateSet("completed", "blocked", "cancelled")]
  [string]$Status = "completed",

  [Parameter(Mandatory=$false)]
  [string]$Result = "",

  [Parameter(Mandatory=$false)]
  [string]$Verified = "",

  [Parameter(Mandatory=$false)]
  [string]$ResidualRisk = "",

  [Parameter(Mandatory=$false)]
  [switch]$NoWrite,

  [Parameter(Mandatory=$false)]
  [switch]$NoLock,

  [Parameter(Mandatory=$false)]
  [switch]$Force
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$workRoot = Join-Path $repoRoot "knowledge\journal\work"
$lockPath = Join-Path $workRoot "locks.json"
$registryPath = Join-Path $repoRoot "knowledge\ops\registry.md"

if ($Complete) { $Action = "complete" }
if ($ListLocks) { $Action = "locks" }
if ($ReleaseLocks) { $Action = "release-locks" }

function Get-RelativePath($Path) {
  $fullPath = [System.IO.Path]::GetFullPath($Path)
  $rootPath = [System.IO.Path]::GetFullPath($repoRoot)
  if (-not $rootPath.EndsWith([System.IO.Path]::DirectorySeparatorChar)) {
    $rootPath += [System.IO.Path]::DirectorySeparatorChar
  }
  if ($fullPath.StartsWith($rootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
    return $fullPath.Substring($rootPath.Length).Replace("\", "/")
  }
  return $fullPath.Replace("\", "/")
}

function Resolve-RepoPath($Path) {
  if ([System.IO.Path]::IsPathRooted($Path)) {
    return [System.IO.Path]::GetFullPath($Path)
  }
  return [System.IO.Path]::GetFullPath((Join-Path $repoRoot $Path))
}

function Split-Items($Items) {
  $result = New-Object System.Collections.Generic.List[string]
  foreach ($item in @($Items)) {
    if ([string]::IsNullOrWhiteSpace([string]$item)) { continue }
    foreach ($part in [System.Text.RegularExpressions.Regex]::Split([string]$item, "\r?\n|;")) {
      $value = $part.Trim().Replace("\", "/")
      if ($value.Length -gt 0 -and -not $result.Contains($value)) {
        $result.Add($value)
      }
    }
  }
  return @($result)
}

function New-Slug($Text) {
  $slug = $Text.Trim().ToLowerInvariant()
  $slug = [System.Text.RegularExpressions.Regex]::Replace($slug, "[^\p{L}\p{Nd}]+", "-").Trim("-")
  if ([string]::IsNullOrWhiteSpace($slug)) { $slug = "work" }
  if ($slug.Length -gt 48) { $slug = $slug.Substring(0, 48).Trim("-") }
  return $slug
}

function Ensure-LockFile {
  New-Item -ItemType Directory -Force -Path $workRoot | Out-Null
  if (-not (Test-Path -LiteralPath $lockPath -PathType Leaf)) {
    Save-Locks -Locks @()
  }
}

function Read-Locks {
  New-Item -ItemType Directory -Force -Path $workRoot | Out-Null
  if (-not (Test-Path -LiteralPath $lockPath -PathType Leaf)) { return @() }
  $raw = Get-Content -LiteralPath $lockPath -Raw
  if ([string]::IsNullOrWhiteSpace($raw)) { return @() }
  $data = $raw | ConvertFrom-Json
  if ($null -eq $data -or $null -eq $data.locks) { return @() }
  return @($data.locks)
}

function Save-Locks($Locks) {
  New-Item -ItemType Directory -Force -Path $workRoot | Out-Null
  $payload = [ordered]@{ locks = @($Locks) }
  $json = $payload | ConvertTo-Json -Depth 8
  Set-Content -LiteralPath $lockPath -Value $json -Encoding UTF8
}

function Get-ActiveLocks {
  return @(Read-Locks | Where-Object { $_.status -eq "active" })
}

function Format-LockLines($Locks) {
  $items = @($Locks)
  if ($items.Count -eq 0) { return @("- None") }
  return @($items | Sort-Object file | ForEach-Object {
    "- $($_.file) locked by $($_.work_id) ($($_.executor), $($_.created_at))"
  })
}

function Add-Unique($List, $Line) {
  if (-not $List.Contains($Line)) { $List.Add($Line) }
}

function Markdown-List($Items) {
  $items = @($Items)
  if ($items.Count -eq 0) { return @("- None") }
  return @($items | ForEach-Object { if ([string]$_ -like "- *") { [string]$_ } else { "- $_" } })
}

function Get-RoutingHints($Blob, $TouchedFiles) {
  $hints = New-Object System.Collections.Generic.List[string]
  Add-Unique $hints "AGENTS.md / Hello-world.md: 作業規約と現在地"
  $target = "$Blob $($TouchedFiles -join ' ')"
  if ($target -match "knowledge[/\\]ops|\bops\b|Skill|hook|orchestrator|command|tool|registry|lock|completion") {
    Add-Unique $hints "knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し"
    Add-Unique $hints "knowledge/ops/README.md: ops配置とコマンドの入口"
  }
  if ($target -match "IR|schema|manifest|contract") { Add-Unique $hints "knowledge/docs/ir/: IR / schema / manifest / contract の設計" }
  if ($target -match "meta|state|brief|placement|phase-catalog") { Add-Unique $hints "knowledge/docs/meta/: メタ土台、配置判断、brief、完成条件" }
  if ($target -match "lexicon|用語|概念") { Add-Unique $hints "knowledge/docs/lexicon.md: 用語境界" }
  if ($target -match "template|phase|ENCRS|method|検証") { Add-Unique $hints "knowledge/docs/method/ と template/<phase>/: phase設計と雛形" }
  if ($target -match "requirements|要求") { Add-Unique $hints "knowledge/docs/requirements/: 要求全体や要求変更の確認" }
  if ($target -match "decision|判断|採用|却下") { Add-Unique $hints "knowledge/docs/decisions/: 背景理由の確認" }
  return @($hints)
}

function Get-FinishHints($TouchedFiles) {
  $hints = New-Object System.Collections.Generic.List[string]
  Add-Unique $hints "git diff --check"
  $joined = $TouchedFiles -join " "
  if ($joined -match "(^|\s)(AGENTS.md|Hello-world.md|SOUL.md|USER.md|COMPASS.md|MEMORY.md)|knowledge[/\\]ops|template[/\\]|output[/\\]|knowledge[/\\]") {
    Add-Unique $hints "hello-world-gate.ps1 で Hello-world.md 同期、検査、commit/push"
  }
  if ($joined -match "knowledge[/\\]ops[/\\]registry.md|knowledge[/\\]ops[/\\]skills|knowledge[/\\]ops[/\\]hooks|knowledge[/\\]ops[/\\]orchestrators") {
    Add-Unique $hints "knowledge/ops/registry.md と Hello-world.md のops entrypoint同期"
  }
  if ($joined -match "\.ps1") { Add-Unique $hints "対象PowerShellのスモークテスト" }
  if (@($TouchedFiles).Count -gt 0) { Add-Unique $hints "作業完了時に impact-orchestrator -Complete でwork cardを閉じ、lockを解放" }
  return @($hints)
}

function Get-OpsInventoryLines {
  $lines = New-Object System.Collections.Generic.List[string]
  if (Test-Path -LiteralPath $registryPath -PathType Leaf) { Add-Unique $lines "- registry: $(Get-RelativePath $registryPath)" }
  else { Add-Unique $lines "- registry: missing (knowledge/ops/registry.md)" }

  $skillRoot = Join-Path $repoRoot "knowledge\ops\skills"
  if (Test-Path -LiteralPath $skillRoot -PathType Container) {
    foreach ($dir in @(Get-ChildItem -LiteralPath $skillRoot -Directory | Sort-Object Name)) { Add-Unique $lines "- skill: $($dir.Name) ($(Get-RelativePath $dir.FullName)/)" }
  }

  $orchestratorRoot = Join-Path $repoRoot "knowledge\ops\orchestrators"
  if (Test-Path -LiteralPath $orchestratorRoot -PathType Container) {
    foreach ($dir in @(Get-ChildItem -LiteralPath $orchestratorRoot -Directory | Sort-Object Name)) { Add-Unique $lines "- orchestrator: $($dir.Name) ($(Get-RelativePath $dir.FullName)/)" }
  }

  $hooksRoot = Join-Path $repoRoot "knowledge\ops\hooks"
  if (Test-Path -LiteralPath $hooksRoot -PathType Container) { Add-Unique $lines "- hooks: $(Get-RelativePath $hooksRoot)/" }
  return @($lines)
}

function Get-MarkdownReferenceImpact($TouchedFiles) {
  $files = @($TouchedFiles)
  if ($files.Count -eq 0) { return @("- None") }

  $result = New-Object System.Collections.Generic.List[string]
  $mdFiles = @(Get-ChildItem -LiteralPath $repoRoot -Recurse -File -Filter "*.md" -Force | Where-Object { $_.FullName -notmatch "[\\/]\.git[\\/]" } | Sort-Object FullName)

  foreach ($target in $files) {
    $patterns = New-Object System.Collections.Generic.List[string]
    Add-Unique $patterns $target
    Add-Unique $patterns ($target.Replace("/", "\"))
    $leaf = [System.IO.Path]::GetFileName($target)
    if (-not [string]::IsNullOrWhiteSpace($leaf)) { Add-Unique $patterns $leaf }

    $matches = New-Object System.Collections.Generic.List[string]
    foreach ($mdFile in $mdFiles) {
      $relativeMd = Get-RelativePath $mdFile.FullName
      $lineNumber = 0
      foreach ($line in [System.IO.File]::ReadLines($mdFile.FullName)) {
        $lineNumber++
        foreach ($pattern in @($patterns)) {
          if (-not [string]::IsNullOrWhiteSpace($pattern) -and $line.Contains($pattern)) {
            $matches.Add("  - ${relativeMd}:$lineNumber")
            break
          }
        }
        if ($matches.Count -ge 25) { break }
      }
      if ($matches.Count -ge 25) { break }
    }

    if ($matches.Count -gt 0) {
      $result.Add("- $target")
      foreach ($match in @($matches)) { $result.Add($match) }
      if ($matches.Count -ge 25) { $result.Add("  - ... truncated at 25 references") }
    }
  }

  if ($result.Count -eq 0) { return @("- None found") }
  return @($result)
}

function Invoke-RegisterWork {
  if ([string]::IsNullOrWhiteSpace($Title)) { throw "Title is required when registering work." }
  New-Item -ItemType Directory -Force -Path $workRoot | Out-Null
  if (-not (Test-Path -LiteralPath $lockPath -PathType Leaf)) { Save-Locks -Locks @() }

  $touchedFiles = Split-Items $Files
  $activeLocks = Get-ActiveLocks
  $conflicts = @($activeLocks | Where-Object { $_.file -in $touchedFiles })
  if ($conflicts.Count -gt 0 -and -not $Force) {
    $message = @("impact-orchestrator: lock conflict", "", "Conflicting active locks:")
    $message += Format-LockLines -Locks $conflicts
    $message += ""
    $message += "Use -Force only when intentionally overriding a stale or coordinated lock."
    throw ($message -join [Environment]::NewLine)
  }

  if ([string]::IsNullOrWhiteSpace($Intent)) { $Intent = "未記入。作業前に補う。" }
  if ([string]::IsNullOrWhiteSpace($Impact)) { $Impact = "未記入。影響が小さいと判断した場合も理由を補う。" }

  $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss K"
  $workId = "{0}-{1}" -f (Get-Date -Format "yyyyMMdd-HHmmss"), (New-Slug $Title)
  $outputPath = Join-Path $workRoot ("{0}.md" -f $workId)
  $relativeOutputPath = Get-RelativePath $outputPath

  if ($NoLock) { $lockState = "skipped by -NoLock" }
  elseif ($touchedFiles.Count -eq 0) { $lockState = "skipped because no touched files were declared" }
  elseif ($NoWrite) { $lockState = "checked only by -NoWrite" }
  elseif ($Force -and $conflicts.Count -gt 0) { $lockState = "acquired with -Force despite conflicts" }
  else { $lockState = "acquired" }

  $lines = @(
    "# Work Card: $Title",
    "",
    "- work_id: $workId",
    "- registered_at: $timestamp",
    "- kind: $Kind",
    "- state: registered",
    "- executor: $Executor",
    "- risk: $Risk",
    "- lock_state: $lockState",
    "",
    "## Intent",
    "",
    $Intent,
    "",
    "## Impact",
    "",
    $Impact,
    "",
    "## Touched Files"
  )
  $lines += Markdown-List $touchedFiles
  $lines += @("", "## File Locks", "", "Lock state: $lockState", "", "Active conflicts before registration:")
  $lines += Format-LockLines -Locks $conflicts
  $lines += @("", "Other active locks at registration:")
  $lines += Format-LockLines -Locks $activeLocks
  $lines += @("", "## Existing Ops To Check")
  $lines += Get-OpsInventoryLines
  $lines += @("", "## Read Routing")
  $lines += Markdown-List (Get-RoutingHints "$Title $Kind $Intent $Impact" $touchedFiles)
  $lines += @("", "## Markdown Reference Impact", "")
  $lines += Get-MarkdownReferenceImpact $touchedFiles
  $lines += @("", "## Execution Assignment", "", "- executor: $Executor", "- subagent: 必要なら `knowledge/docs/meta/subagent-brief.md` に従って、タスク用仮ゴールを別で渡す", "", "## Finish Gate")
  $lines += Markdown-List (Get-FinishHints $touchedFiles)
  $lines += @(
    "",
    "## MergeGate Mapping",
    "",
    "| 作法 | このwork cardでの対応 |",
    "|---|---|",
    "| register work | このファイルを作る |",
    "| record impact | `Impact`、`Touched Files`、`Markdown Reference Impact` に残す |",
    "| lock files | `knowledge/journal/work/locks.json` にactive lockを持つ |",
    "| assign execution | `Execution Assignment` に残す |",
    "| verify completion | `impact-orchestrator -Complete` でこのwork cardを閉じる |",
    "| track branch / PR state | 未実装。GitHub運用が固まってから判断する |",
    "",
    "## Completion",
    "",
    "- status: pending"
  )
  $lines += ('- close command: `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1 -Complete -WorkCard "{0}" -Result "..." -Verified "..." -ResidualRisk "..."`' -f $relativeOutputPath)
  $lines += @("", "## Notes", "", "- このファイルは作業ログであり、正本仕様ではない。", "- 長期の採用理由は `knowledge/docs/decisions/` へ移す。")

  $content = (($lines -join [Environment]::NewLine) + [Environment]::NewLine)
  if ($NoWrite) { Write-Output $content; return }

  Set-Content -LiteralPath $outputPath -Value $content -Encoding UTF8
  if (-not $NoLock -and $touchedFiles.Count -gt 0) {
    $locks = New-Object System.Collections.Generic.List[object]
    foreach ($lock in Read-Locks) { $locks.Add($lock) }
    foreach ($file in @($touchedFiles)) {
      $locks.Add([pscustomobject][ordered]@{
        file = [string]$file
        work_id = $workId
        work_card = $relativeOutputPath
        title = $Title
        executor = $Executor
        created_at = $timestamp
        status = "active"
        forced = [bool]$Force
      })
    }
    Save-Locks -Locks ($locks.ToArray())
  }

  Write-Output "impact-orchestrator: wrote $relativeOutputPath"
}

function Resolve-WorkCard($Path) {
  $fullPath = Resolve-RepoPath $Path
  if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) { throw "WorkCard not found: $Path" }
  return $fullPath
}

function Invoke-CompleteWork {
  if ([string]::IsNullOrWhiteSpace($WorkCard)) { throw "WorkCard is required when completing work." }
  $workCardPath = Resolve-WorkCard $WorkCard
  $relativeWorkCard = Get-RelativePath $workCardPath
  $content = Get-Content -LiteralPath $workCardPath -Raw
  $workIdMatch = [regex]::Match($content, '(?m)^- work_id:\s*(.+?)\s*$')
  $workId = if ($workIdMatch.Success) { $workIdMatch.Groups[1].Value.Trim() } else { [System.IO.Path]::GetFileNameWithoutExtension($workCardPath) }

  if ([string]::IsNullOrWhiteSpace($Result)) { $Result = "未記入" }
  if ([string]::IsNullOrWhiteSpace($Verified)) { $Verified = "未記入" }
  if ([string]::IsNullOrWhiteSpace($ResidualRisk)) { $ResidualRisk = "未記入" }

  $released = @()
  if (-not $NoWrite -and -not $NoLock) {
    $remaining = New-Object System.Collections.Generic.List[object]
    $releasedList = New-Object System.Collections.Generic.List[object]
    foreach ($lock in Read-Locks) {
      if ($lock.work_id -eq $workId -or $lock.work_card -eq $relativeWorkCard) { $releasedList.Add($lock) }
      else { $remaining.Add($lock) }
    }
    $released = @($releasedList.ToArray())
    Save-Locks -Locks ($remaining.ToArray())
  }

  $updated = [regex]::Replace($content, '(?m)^- state:\s*.+$', "- state: $Status", 1)
  $updated = [regex]::Replace($updated, '(?m)^- lock_state:\s*.+$', "- lock_state: released-on-$Status", 1)
  $completionBlock = @(
    "",
    "## Completion Update",
    "",
    "- completed_at: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss K')",
    "- status: $Status",
    "- result: $Result",
    "- verified: $Verified",
    "- residual_risk: $ResidualRisk",
    "- released_locks: $($released.Count)",
    ""
  ) -join [Environment]::NewLine
  $updated = $updated.TrimEnd() + [Environment]::NewLine + $completionBlock

  if ($NoWrite) { Write-Output "impact-orchestrator: would complete $relativeWorkCard as $Status"; return }
  Set-Content -LiteralPath $workCardPath -Value $updated -Encoding UTF8
  Write-Output "impact-orchestrator: completed $relativeWorkCard as $Status"
  Write-Output "impact-orchestrator: released $($released.Count) lock(s)"
}

function Invoke-ListLocks {
  Write-Output "impact-orchestrator: active locks"
  foreach ($line in (Format-LockLines -Locks @(Get-ActiveLocks))) { Write-Output $line }
}

function Invoke-ReleaseLocks {
  if ([string]::IsNullOrWhiteSpace($WorkCard) -and -not $Force) { throw "WorkCard is required for release-locks unless -Force is used." }
  if ($Force -and [string]::IsNullOrWhiteSpace($WorkCard)) {
    $count = @(Read-Locks).Count
    if (-not $NoWrite) { Save-Locks -Locks @() }
    Write-Output "impact-orchestrator: released all active locks ($count)"
    return
  }
  $workCardPath = Resolve-WorkCard $WorkCard
  $relativeWorkCard = Get-RelativePath $workCardPath
  $content = Get-Content -LiteralPath $workCardPath -Raw
  $workIdMatch = [regex]::Match($content, '(?m)^- work_id:\s*(.+?)\s*$')
  $workId = if ($workIdMatch.Success) { $workIdMatch.Groups[1].Value.Trim() } else { "" }
  $remaining = New-Object System.Collections.Generic.List[object]
  $released = New-Object System.Collections.Generic.List[object]
  foreach ($lock in Read-Locks) {
    if ($lock.work_id -eq $workId -or $lock.work_card -eq $relativeWorkCard) { $released.Add($lock) }
    else { $remaining.Add($lock) }
  }
  if (-not $NoWrite) { Save-Locks -Locks ($remaining.ToArray()) }
  Write-Output "impact-orchestrator: released $($released.Count) lock(s)"
}

Set-Location -LiteralPath $repoRoot
switch ($Action) {
  "register" { Invoke-RegisterWork }
  "complete" { Invoke-CompleteWork }
  "locks" { Invoke-ListLocks }
  "release-locks" { Invoke-ReleaseLocks }
  default { throw "Unsupported action: $Action" }
}
