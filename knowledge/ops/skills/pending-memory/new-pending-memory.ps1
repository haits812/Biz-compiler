param(
  [Parameter(Mandatory=$true)]
  [string]$Title,

  [Parameter(Mandatory=$false)]
  [string]$Evidence = "",

  [Parameter(Mandatory=$false)]
  [string]$ProposedChange = "",

  [Parameter(Mandatory=$false)]
  [string]$Risk = ""
)

$ErrorActionPreference = "Stop"

$knowledgeRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..\..")
$targetDir = Join-Path $knowledgeRoot "pending\memory"
New-Item -ItemType Directory -Force -Path $targetDir | Out-Null

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$slug = $Title.ToLowerInvariant() -replace '[^a-z0-9\p{IsHiragana}\p{IsKatakana}\p{IsCJKUnifiedIdeographs}]+', '-'
$slug = $slug.Trim('-')
if ([string]::IsNullOrWhiteSpace($slug)) {
  $slug = "memo"
}
if ($slug.Length -gt 48) {
  $slug = $slug.Substring(0, 48).Trim('-')
}

$path = Join-Path $targetDir "$timestamp-$slug.md"
$content = @"
# $Title

## Target
MEMORY.md

## Proposed Change
$ProposedChange

## Evidence
$Evidence

## Risk
$Risk
"@

Set-Content -LiteralPath $path -Value $content -Encoding UTF8
Write-Output $path

