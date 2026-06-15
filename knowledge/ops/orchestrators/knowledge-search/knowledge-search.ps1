param(
  [Parameter(Position=0, Mandatory=$false)]
  [ValidateSet("index", "rebuild", "search", "status")]
  [string]$Command = "search",

  [Parameter(Position=1, Mandatory=$false)]
  [string]$Query = "",

  [Parameter(Mandatory=$false)]
  [int]$Limit = 10,

  [Parameter(Mandatory=$false)]
  [ValidateSet("all", "root", "knowledge_docs", "knowledge_pending", "knowledge_journal", "knowledge_ops", "template", "output", "other")]
  [string]$Source = "all",

  [Parameter(Mandatory=$false)]
  [switch]$Json
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$scriptPath = Join-Path $PSScriptRoot "knowledge_search.py"
$dbPath = Join-Path $repoRoot "knowledge\.index\knowledge.sqlite"

$python = Get-Command python -ErrorAction SilentlyContinue
if (-not $python) {
  $python = Get-Command py -ErrorAction SilentlyContinue
}
if (-not $python) {
  throw "Python is required for knowledge-search but was not found on PATH."
}

$argsList = @(
  $scriptPath,
  $Command,
  "--repo-root", $repoRoot,
  "--db-path", $dbPath,
  "--limit", [string]$Limit,
  "--source", $Source
)

if ($Json) {
  $argsList += "--json"
}

if (-not [string]::IsNullOrWhiteSpace($Query)) {
  $argsList += @("--query", $Query)
}

& $python.Source @argsList
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}