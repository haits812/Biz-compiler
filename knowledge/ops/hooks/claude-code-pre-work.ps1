[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [string]$Title = $env:BIZ_WORK_TITLE,

  [Parameter(Mandatory=$false)]
  [string]$Kind = $(if ($env:BIZ_WORK_KIND) { $env:BIZ_WORK_KIND } else { "hook" }),

  [Parameter(Mandatory=$false)]
  [string]$Intent = $env:BIZ_WORK_INTENT,

  [Parameter(Mandatory=$false)]
  [string]$Impact = $env:BIZ_WORK_IMPACT,

  [Parameter(Mandatory=$false)]
  [string[]]$Files = @($env:BIZ_WORK_FILES),

  [Parameter(Mandatory=$false)]
  [ValidateSet("low", "medium", "high", "unknown")]
  [string]$Risk = $(if ($env:BIZ_WORK_RISK) { $env:BIZ_WORK_RISK } else { "medium" }),

  [Parameter(Mandatory=$false)]
  [switch]$NoWrite,

  [Parameter(Mandatory=$false)]
  [switch]$NoLock,

  [Parameter(Mandatory=$false)]
  [switch]$Force
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($Title)) {
  $Title = "claude-code-pre-work"
}

$orchestrator = Join-Path $PSScriptRoot "..\orchestrators\impact-orchestrator\impact-orchestrator.ps1"
$args = @{
  Title = $Title
  Kind = $Kind
  Intent = $Intent
  Impact = $Impact
  Files = $Files
  Executor = "claude-code"
  Risk = $Risk
}
if ($NoWrite) { $args.NoWrite = $true }
if ($NoLock) { $args.NoLock = $true }
if ($Force) { $args.Force = $true }

& $orchestrator @args
