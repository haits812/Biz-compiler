[CmdletBinding()]
param(
  [Parameter(Position=0, Mandatory=$false)]
  [ValidateSet("index", "rebuild", "status", "query")]
  [string]$Command = "query",

  [Parameter(Mandatory=$false)]
  [string[]]$Files = @(),

  [Parameter(Mandatory=$false)]
  [int]$Depth = 2,

  [Parameter(Mandatory=$false)]
  [ValidateSet("markdown", "json")]
  [string]$Format = "markdown",

  [Parameter(Mandatory=$false)]
  [int]$Limit = 60,

  [Parameter(Mandatory=$false)]
  [switch]$AllowStale
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$scriptPath = Join-Path $PSScriptRoot "code_impact.py"
$dbPath = Join-Path $repoRoot "knowledge\.index\code-impact.sqlite"

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
  $python = Get-Command py -ErrorAction SilentlyContinue
}
if (-not $python) {
  throw "Python is required for code-impact but was not found on PATH."
}

$fileArg = ($Files -join ";")

$argsList = @(
  $scriptPath,
  $Command,
  "--repo-root", $repoRoot,
  "--db-path", $dbPath,
  "--depth", [string]$Depth,
  "--format", $Format,
  "--limit", [string]$Limit
)

if (-not [string]::IsNullOrWhiteSpace($fileArg)) {
  $argsList += @("--files", $fileArg)
}

if ($AllowStale) {
  $argsList += "--allow-stale"
}

& $python.Source @argsList
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}