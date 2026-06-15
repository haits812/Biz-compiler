[CmdletBinding()]
param(
  [Parameter(Mandatory=$false)]
  [string]$Type = "運用",

  [Parameter(Mandatory=$false)]
  [string]$Subject = $env:BIZ_PUBLISH_SUBJECT,

  [Parameter(Mandatory=$false)]
  [string]$Reason = $env:BIZ_PUBLISH_REASON,

  [Parameter(Mandatory=$false)]
  [string]$Verified = $env:BIZ_PUBLISH_VERIFIED,

  [Parameter(Mandatory=$false)]
  [string]$Risks = $env:BIZ_PUBLISH_RISKS,

  [Parameter(Mandatory=$false)]
  [switch]$NoPush
)

$ErrorActionPreference = "Stop"

$gate = Join-Path $PSScriptRoot "..\skills\hello-world-gate\hello-world-gate.ps1"
$args = @{
  Type = $Type
  Subject = $Subject
  Reason = $Reason
  Verified = $Verified
  Risks = $Risks
}
if ($NoPush) { $args.NoPush = $true }

& $gate @args
