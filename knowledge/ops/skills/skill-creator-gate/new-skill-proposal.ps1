param(
  [Parameter(Mandatory=$true)]
  [string]$Name,

  [Parameter(Mandatory=$true)]
  [string]$Intent,

  [Parameter(Mandatory=$false)]
  [ValidateSet("repo-local-skill", "orchestrator", "hook-adapter", "docs-rule", "script", "not-needed", "unknown")]
  [string]$Type = "repo-local-skill",

  [Parameter(Mandatory=$false)]
  [string]$Triggers = "",

  [Parameter(Mandatory=$false)]
  [string]$Steps = "",

  [Parameter(Mandatory=$false)]
  [string]$Validation = "",

  [Parameter(Mandatory=$false)]
  [string]$CollisionCheck = "",

  [Parameter(Mandatory=$false)]
  [string]$Risk = "",

  [Parameter(Mandatory=$false)]
  [string]$Assumptions = ""
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$targetDir = Join-Path $repoRoot "knowledge\pending\skills"
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

function Convert-ToSlug {
  param([string]$Value)

  $slug = $Value.ToLowerInvariant() -replace '[^a-z0-9\p{IsHiragana}\p{IsKatakana}\p{IsCJKUnifiedIdeographs}]+', '-'
  $slug = $slug.Trim('-')
  if ([string]::IsNullOrWhiteSpace($slug)) {
    $slug = "skill-proposal"
  }
  if ($slug.Length -gt 56) {
    $slug = $slug.Substring(0, 56).Trim('-')
  }
  return $slug
}

function Convert-ToList {
  param([string]$Value)

  $items = [System.Text.RegularExpressions.Regex]::Split($Value, "\r?\n|;") |
    ForEach-Object { $_.Trim() } |
    Where-Object { $_.Length -gt 0 } |
    ForEach-Object {
      if ($_.StartsWith("- ")) { $_ } else { "- $_" }
    }

  if (@($items).Count -eq 0) {
    return "- TBD"
  }

  return ($items -join [Environment]::NewLine)
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$slug = Convert-ToSlug -Value $Name
$path = Join-Path $targetDir "$timestamp-$slug.md"

$content = @"
# $Name

## Target
knowledge/ops/skills/$slug/

## Proposal Type
$Type

## Intent
$Intent

## Triggers
$(Convert-ToList -Value $Triggers)

## Proposed Steps
$(Convert-ToList -Value $Steps)

## Validation Gates
$(Convert-ToList -Value $Validation)

## Collision Check
$CollisionCheck

## Assumptions
$Assumptions

## Risk
$Risk

## Source Pattern
OpenSquilla `meta-skill-creator` の proposal-first / trigger surface / collision check / validation gate 作法を、Biz-compiler の repo-local Skill 作成へ移植する。

## Review Rule
このproposalは正式Skillではない。人間が承認した後、`knowledge/ops/skills/<skill-name>/`、`knowledge/ops/registry.md`、`knowledge/ops/README.md`、`Hello-world.md` へ反映する。
"@

Set-Content -LiteralPath $path -Value $content -Encoding UTF8
Write-Output $path