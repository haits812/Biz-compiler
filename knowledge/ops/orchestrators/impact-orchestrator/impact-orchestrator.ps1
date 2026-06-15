[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$Title,

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
  [switch]$NoWrite
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$workRoot = Join-Path $repoRoot "knowledge\journal\work"
$registryPath = Join-Path $repoRoot "knowledge\ops\registry.md"

function Get-RelativePath {
  param([Parameter(Mandatory=$true)][string]$Path)

  $fullPath = [System.IO.Path]::GetFullPath($Path)
  $rootPath = [System.IO.Path]::GetFullPath($repoRoot)
  if (-not $rootPath.EndsWith([System.IO.Path]::DirectorySeparatorChar)) {
    $rootPath = $rootPath + [System.IO.Path]::DirectorySeparatorChar
  }

  if ($fullPath.StartsWith($rootPath, [System.StringComparison]::OrdinalIgnoreCase)) {
    return $fullPath.Substring($rootPath.Length).Replace("\", "/")
  }

  return $fullPath.Replace("\", "/")
}

function Split-List {
  param([Parameter(Mandatory=$false)][string[]]$Items = @())

  $result = New-Object System.Collections.Generic.List[string]
  foreach ($item in $Items) {
    if ([string]::IsNullOrWhiteSpace($item)) {
      continue
    }

    $parts = [System.Text.RegularExpressions.Regex]::Split($item, "\r?\n|;")
    foreach ($part in $parts) {
      $value = $part.Trim()
      if ($value.Length -gt 0) {
        $result.Add($value)
      }
    }
  }

  return @($result | Select-Object -Unique)
}

function New-Slug {
  param([Parameter(Mandatory=$true)][string]$Text)

  $slug = $Text.Trim().ToLowerInvariant()
  $slug = [System.Text.RegularExpressions.Regex]::Replace($slug, "[^\p{L}\p{Nd}]+", "-").Trim("-")
  if ([string]::IsNullOrWhiteSpace($slug)) {
    $slug = "work"
  }
  if ($slug.Length -gt 48) {
    $slug = $slug.Substring(0, 48).Trim("-")
  }
  return $slug
}

function Add-UniqueLine {
  param(
    [Parameter(Mandatory=$true)][object]$Lines,
    [Parameter(Mandatory=$true)][string]$Line
  )

  if (-not $Lines.Contains($Line)) {
    $Lines.Add($Line)
  }
}

function Get-ReadRoutingHints {
  param(
    [Parameter(Mandatory=$true)][string]$Blob,
    [Parameter(Mandatory=$true)][string[]]$TouchedFiles
  )

  $hints = New-Object System.Collections.Generic.List[string]
  Add-UniqueLine -Lines $hints -Line "AGENTS.md / Hello,world.md: 作業規約と現在地"

  $joinedFiles = ($TouchedFiles -join " ")
  $target = "$Blob $joinedFiles"

  if ($target -match "knowledge[/\\]ops|\bops\b|Skill|hook|orchestrator|command|tool|registry") {
    Add-UniqueLine -Lines $hints -Line "knowledge/ops/registry.md: 既存Skill、hooks、orchestrators、commandsの棚卸し"
    Add-UniqueLine -Lines $hints -Line "knowledge/ops/README.md: ops配置とコマンドの入口"
  }
  if ($target -match "IR|schema|manifest|contract") {
    Add-UniqueLine -Lines $hints -Line "knowledge/docs/ir/: IR / schema / manifest / contract の設計"
  }
  if ($target -match "meta|state|brief|placement|phase-catalog") {
    Add-UniqueLine -Lines $hints -Line "knowledge/docs/meta/: メタ土台、配置判断、brief、完成条件"
  }
  if ($target -match "lexicon|用語|概念") {
    Add-UniqueLine -Lines $hints -Line "knowledge/docs/lexicon.md: 用語境界"
  }
  if ($target -match "template|phase|ENCRS|method|検証") {
    Add-UniqueLine -Lines $hints -Line "knowledge/docs/method/ と template/<phase>/: phase設計と雛形"
  }
  if ($target -match "requirements|要求") {
    Add-UniqueLine -Lines $hints -Line "knowledge/docs/requirements/: 要求全体や要求変更の確認"
  }
  if ($target -match "decision|判断|採用|却下") {
    Add-UniqueLine -Lines $hints -Line "knowledge/docs/decisions/: 背景理由の確認"
  }

  return @($hints)
}

function Get-FinishGateHints {
  param([Parameter(Mandatory=$true)][string[]]$TouchedFiles)

  $hints = New-Object System.Collections.Generic.List[string]
  Add-UniqueLine -Lines $hints -Line "git diff --check"

  $joinedFiles = ($TouchedFiles -join " ")
  if ($joinedFiles -match "(^|\s)(AGENTS.md|Hello,world.md|SOUL.md|USER.md|COMPASS.md|MEMORY.md)|knowledge[/\\]ops|template[/\\]|output[/\\]|knowledge[/\\]") {
    Add-UniqueLine -Lines $hints -Line "hello-world-gate.ps1 で Hello,world.md 同期、検査、commit/push"
  }
  if ($joinedFiles -match "knowledge[/\\]ops[/\\]registry.md|knowledge[/\\]ops[/\\]skills|knowledge[/\\]ops[/\\]hooks|knowledge[/\\]ops[/\\]orchestrators") {
    Add-UniqueLine -Lines $hints -Line "knowledge/ops/registry.md と Hello,world.md のops entrypoint同期"
  }
  if ($joinedFiles -match "\.ps1") {
    Add-UniqueLine -Lines $hints -Line "対象PowerShellのスモークテスト"
  }

  return @($hints)
}

function Get-OpsInventoryLines {
  $lines = New-Object System.Collections.Generic.List[string]

  if (Test-Path -LiteralPath $registryPath -PathType Leaf) {
    Add-UniqueLine -Lines $lines -Line "- registry: $(Get-RelativePath -Path $registryPath)"
  } else {
    Add-UniqueLine -Lines $lines -Line "- registry: missing (knowledge/ops/registry.md)"
  }

  $skillRoot = Join-Path $repoRoot "knowledge\ops\skills"
  if (Test-Path -LiteralPath $skillRoot -PathType Container) {
    $skillDirs = @(Get-ChildItem -LiteralPath $skillRoot -Directory | Sort-Object Name)
    foreach ($dir in $skillDirs) {
      Add-UniqueLine -Lines $lines -Line "- skill: $($dir.Name) ($(Get-RelativePath -Path $dir.FullName)/)"
    }
  }

  $orchestratorRoot = Join-Path $repoRoot "knowledge\ops\orchestrators"
  if (Test-Path -LiteralPath $orchestratorRoot -PathType Container) {
    $orchestratorDirs = @(Get-ChildItem -LiteralPath $orchestratorRoot -Directory | Sort-Object Name)
    foreach ($dir in $orchestratorDirs) {
      Add-UniqueLine -Lines $lines -Line "- orchestrator: $($dir.Name) ($(Get-RelativePath -Path $dir.FullName)/)"
    }
  }

  $hooksRoot = Join-Path $repoRoot "knowledge\ops\hooks"
  if (Test-Path -LiteralPath $hooksRoot -PathType Container) {
    Add-UniqueLine -Lines $lines -Line "- hooks: $(Get-RelativePath -Path $hooksRoot)/"
  }

  return @($lines)
}

function Convert-ToMarkdownList {
  param([Parameter(Mandatory=$true)][string[]]$Items)

  if ($Items.Count -eq 0) {
    return @("- None")
  }

  return @($Items | ForEach-Object {
    if ($_.Trim().StartsWith("- ")) { $_ } else { "- $_" }
  })
}

Set-Location -LiteralPath $repoRoot

$touchedFiles = Split-List -Items $Files
$blob = "$Title $Kind $Intent $Impact"
$readHints = Get-ReadRoutingHints -Blob $blob -TouchedFiles $touchedFiles
$finishHints = Get-FinishGateHints -TouchedFiles $touchedFiles
$opsInventory = Get-OpsInventoryLines
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss K"
$fileTimestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$slug = New-Slug -Text $Title
$outputPath = Join-Path $workRoot ("{0}-{1}.md" -f $fileTimestamp, $slug)

if ([string]::IsNullOrWhiteSpace($Intent)) {
  $Intent = "未記入。作業前に補う。"
}
if ([string]::IsNullOrWhiteSpace($Impact)) {
  $Impact = "未記入。影響が小さいと判断した場合も理由を補う。"
}

$lines = @(
  "# Work Card: $Title",
  "",
  "- registered_at: $timestamp",
  "- kind: $Kind",
  "- state: registered",
  "- executor: $Executor",
  "- risk: $Risk",
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
$lines += Convert-ToMarkdownList -Items $touchedFiles
$lines += @(
  "",
  "## Existing Ops To Check"
)
$lines += $opsInventory
$lines += @(
  "",
  "## Read Routing"
)
$lines += Convert-ToMarkdownList -Items $readHints
$lines += @(
  "",
  "## Execution Assignment",
  "",
  "- executor: $Executor",
  "- subagent: 必要なら `knowledge/docs/meta/subagent-brief.md` に従って、タスク用仮ゴールを別で渡す",
  "",
  "## Finish Gate"
)
$lines += Convert-ToMarkdownList -Items $finishHints
$lines += @(
  "",
  "## MergeGate Mapping",
  "",
  "| 作法 | このwork cardでの対応 |",
  "|---|---|",
  "| register work | このファイルを作る |",
  "| record impact | `Impact` と `Touched Files` に残す |",
  "| assign execution | `Execution Assignment` に残す |",
  "| verify completion | `Finish Gate` に残す |",
  "",
  "## Notes",
  "",
  "- このファイルは作業ログであり、正本仕様ではない。",
  "- 長期の採用理由は `knowledge/docs/decisions/` へ移す。"
)

$content = (($lines -join [Environment]::NewLine) + [Environment]::NewLine)

if ($NoWrite) {
  Write-Output $content
  return
}

New-Item -ItemType Directory -Force -Path $workRoot | Out-Null
Set-Content -LiteralPath $outputPath -Value $content -Encoding UTF8
Write-Output "impact-orchestrator: wrote $(Get-RelativePath -Path $outputPath)"
