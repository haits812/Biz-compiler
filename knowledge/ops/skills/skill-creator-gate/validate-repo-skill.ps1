param(
  [Parameter(Mandatory=$true)]
  [string]$SkillName
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$skillRoot = Join-Path $repoRoot "knowledge\ops\skills"
$skillDir = Join-Path $skillRoot $SkillName
$skillFile = Join-Path $skillDir "SKILL.md"
$registryFile = Join-Path $repoRoot "knowledge\ops\registry.md"
$opsReadmeFile = Join-Path $repoRoot "knowledge\ops\README.md"

$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]

if ($SkillName -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$') {
  $errors.Add("SkillName must use lowercase letters, digits, and single hyphens: $SkillName")
}

if (-not (Test-Path -LiteralPath $skillDir -PathType Container)) {
  $errors.Add("Skill directory is missing: knowledge/ops/skills/$SkillName")
}

if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
  $errors.Add("SKILL.md is missing: knowledge/ops/skills/$SkillName/SKILL.md")
} else {
  $text = Get-Content -LiteralPath $skillFile -Raw
  if (-not $text.StartsWith("---")) {
    $errors.Add("SKILL.md must start with YAML frontmatter on line 1.")
  }

  $nameMatch = [regex]::Match($text, '(?m)^name:\s*(.+?)\s*$')
  $descriptionMatch = [regex]::Match($text, '(?m)^description:\s*(.+?)\s*$')

  if (-not $nameMatch.Success) {
    $errors.Add("SKILL.md frontmatter must include name.")
  } elseif ($nameMatch.Groups[1].Value.Trim() -ne $SkillName) {
    $errors.Add("SKILL.md name must match folder name. Expected '$SkillName', found '$($nameMatch.Groups[1].Value.Trim())'.")
  }

  if (-not $descriptionMatch.Success) {
    $errors.Add("SKILL.md frontmatter must include description.")
  } else {
    $description = $descriptionMatch.Groups[1].Value.Trim()
    if ($description.Length -lt 40) {
      $warnings.Add("Description is short. Include trigger-rich 'Use when...' context.")
    }
    if ($description -notmatch 'Use when|使う|作る|依頼|言われた時|時') {
      $warnings.Add("Description may not expose enough trigger language for natural activation.")
    }
  }

  if (Test-Path -LiteralPath (Join-Path $skillDir "README.md") -PathType Leaf) {
    $warnings.Add("repo-local Skill owner explanation should usually live in SKILL.md, not README.md.")
  }
}

$scripts = @()
if (Test-Path -LiteralPath $skillDir -PathType Container) {
  $scripts = @(Get-ChildItem -LiteralPath $skillDir -File -Filter "*.ps1" -Force)
}
foreach ($script in $scripts) {
  $tokens = $null
  $parseErrors = $null
  [System.Management.Automation.Language.Parser]::ParseFile($script.FullName, [ref]$tokens, [ref]$parseErrors) | Out-Null
  if ($parseErrors.Count -gt 0) {
    $errors.Add("PowerShell parse failed: $($script.FullName)")
    foreach ($parseError in $parseErrors) {
      $errors.Add("  $($parseError.Message)")
    }
  }
}

if (Test-Path -LiteralPath $registryFile -PathType Leaf) {
  $registry = Get-Content -LiteralPath $registryFile -Raw
  $registryNeedle = "``$SkillName``"
  if ($registry -notmatch [regex]::Escape($registryNeedle)) {
    $warnings.Add("knowledge/ops/registry.md does not mention $registryNeedle.")
  }
}

if (Test-Path -LiteralPath $opsReadmeFile -PathType Leaf) {
  $opsReadme = Get-Content -LiteralPath $opsReadmeFile -Raw
  if ($opsReadme -notmatch [regex]::Escape($SkillName)) {
    $warnings.Add("knowledge/ops/README.md does not mention $SkillName.")
  }
}

if ($errors.Count -gt 0) {
  Write-Output "validate-repo-skill: failed"
  $errors | ForEach-Object { Write-Output "ERROR: $_" }
  if ($warnings.Count -gt 0) {
    $warnings | ForEach-Object { Write-Output "WARN: $_" }
  }
  exit 1
}

Write-Output "validate-repo-skill: passed for $SkillName"
if ($warnings.Count -gt 0) {
  $warnings | ForEach-Object { Write-Output "WARN: $_" }
}