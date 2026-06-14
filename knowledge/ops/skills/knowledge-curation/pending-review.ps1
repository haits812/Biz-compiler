param(
  [Parameter(Mandatory=$false, Position=0)]
  [ValidateSet("list", "show", "approve", "reject", "applied")]
  [string]$Action = "list",

  [Parameter(Mandatory=$false)]
  [string]$Id = "",

  [Parameter(Mandatory=$false)]
  [ValidateSet("pending", "approved", "all")]
  [string]$Stage = "pending",

  [Parameter(Mandatory=$false)]
  [string]$Reason = ""
)

$ErrorActionPreference = "Stop"

$knowledgeRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..\..")
$pendingRoot = Join-Path $knowledgeRoot "pending"
$journalRoot = Join-Path $knowledgeRoot "journal"

function Get-PendingSources {
  param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("pending", "approved", "all")]
    [string]$SourceStage = $Stage
  )

  $sources = @(
    @{ Stage = "pending"; Category = "memory"; Dir = Join-Path $pendingRoot "memory"; IdPrefix = "memory" },
    @{ Stage = "pending"; Category = "compass"; Dir = Join-Path $pendingRoot "compass"; IdPrefix = "compass" },
    @{ Stage = "pending"; Category = "decisions"; Dir = Join-Path $pendingRoot "decisions"; IdPrefix = "decisions" },
    @{ Stage = "approved"; Category = "memory"; Dir = Join-Path $pendingRoot "approved\memory"; IdPrefix = "approved/memory" },
    @{ Stage = "approved"; Category = "compass"; Dir = Join-Path $pendingRoot "approved\compass"; IdPrefix = "approved/compass" },
    @{ Stage = "approved"; Category = "decisions"; Dir = Join-Path $pendingRoot "approved\decisions"; IdPrefix = "approved/decisions" }
  )

  foreach ($source in $sources) {
    if ($SourceStage -ne "all" -and $source.Stage -ne $SourceStage) {
      continue
    }
    if (-not (Test-Path -LiteralPath $source.Dir)) {
      continue
    }

    Get-ChildItem -LiteralPath $source.Dir -File -Filter "*.md" |
      Where-Object { $_.Name -ne "README.md" } |
      ForEach-Object {
        $title = $_.BaseName
        $titleMatch = Select-String -LiteralPath $_.FullName -Pattern '^#\s+(.+)$' -List -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($titleMatch -and $titleMatch.Matches.Count -gt 0) {
          $title = $titleMatch.Matches[0].Groups[1].Value
        }

        [pscustomobject]@{
          Id = "$($source.IdPrefix)/$($_.Name)"
          Stage = $source.Stage
          Category = $source.Category
          Title = $title
          Path = $_.FullName
          LastWriteTime = $_.LastWriteTime
        }
      }
  }
}

function Resolve-PendingItem {
  param([string]$ItemId)

  if ([string]::IsNullOrWhiteSpace($ItemId)) {
    throw "-Id is required for action '$Action'. Use 'list' first."
  }

  $items = @(Get-PendingSources -SourceStage "all")
  $matches = @($items | Where-Object {
    $_.Id -eq $ItemId -or
    $_.Id.Replace('\\', '/') -eq $ItemId.Replace('\\', '/') -or
    $_.Path -eq $ItemId -or
    (Split-Path -Leaf $_.Path) -eq $ItemId
  })

  if ($matches.Count -eq 0) {
    throw "No pending item matched '$ItemId'. Use 'list -Stage all'."
  }
  if ($matches.Count -gt 1) {
    $ids = ($matches | ForEach-Object { $_.Id }) -join ", "
    throw "Multiple pending items matched '$ItemId': $ids"
  }

  return $matches[0]
}

function Get-UniqueDestinationPath {
  param(
    [string]$Directory,
    [string]$FileName
  )

  New-Item -ItemType Directory -Force -Path $Directory | Out-Null
  $candidate = Join-Path $Directory $FileName
  if (-not (Test-Path -LiteralPath $candidate)) {
    return $candidate
  }

  $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
  $base = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
  $ext = [System.IO.Path]::GetExtension($FileName)
  return (Join-Path $Directory "$base-$stamp$ext")
}

function Add-ResolutionHeader {
  param(
    [string]$Content,
    [string]$Status,
    [string]$SourceId,
    [string]$ReasonText
  )

  $resolvedAt = Get-Date -Format "yyyy-MM-ddTHH:mm:ssK"
  return @"
<!--
Status: $Status
ResolvedAt: $resolvedAt
SourceId: $SourceId
Reason: $ReasonText
-->

$Content
"@
}

switch ($Action) {
  "list" {
    $items = @(Get-PendingSources -SourceStage $Stage)
    if ($items.Count -eq 0) {
      Write-Output "No pending items for stage '$Stage'."
      break
    }

    $items |
      Sort-Object Stage, Category, LastWriteTime |
      Select-Object Id, Stage, Category, Title, LastWriteTime |
      Format-Table -AutoSize
  }

  "show" {
    $item = Resolve-PendingItem -ItemId $Id
    Write-Output "Id: $($item.Id)"
    Write-Output "Stage: $($item.Stage)"
    Write-Output "Category: $($item.Category)"
    Write-Output "Path: $($item.Path)"
    Write-Output ""
    Get-Content -LiteralPath $item.Path -Raw
  }

  "approve" {
    $item = Resolve-PendingItem -ItemId $Id
    if ($item.Stage -ne "pending") {
      throw "Only items in pending stage can be approved. Current stage: $($item.Stage)"
    }

    $destDir = Join-Path $pendingRoot "approved\$($item.Category)"
    $dest = Get-UniqueDestinationPath -Directory $destDir -FileName (Split-Path -Leaf $item.Path)
    $content = Get-Content -LiteralPath $item.Path -Raw
    $approved = Add-ResolutionHeader -Content $content -Status "approved" -SourceId $item.Id -ReasonText $Reason
    Set-Content -LiteralPath $dest -Value $approved -Encoding UTF8
    Remove-Item -LiteralPath $item.Path
    Write-Output "Approved: $($item.Id) -> $dest"
    Write-Output "Next: reflect the approved content into its formal target, then run: .\knowledge\ops\skills\knowledge-curation\pending-review.ps1 applied -Id 'approved/$($item.Category)/$(Split-Path -Leaf $dest)'"
  }

  "reject" {
    $item = Resolve-PendingItem -ItemId $Id
    $destDir = Join-Path $journalRoot "pending-rejected\$($item.Category)"
    $dest = Get-UniqueDestinationPath -Directory $destDir -FileName (Split-Path -Leaf $item.Path)
    $content = Get-Content -LiteralPath $item.Path -Raw
    $rejected = Add-ResolutionHeader -Content $content -Status "rejected" -SourceId $item.Id -ReasonText $Reason
    Set-Content -LiteralPath $dest -Value $rejected -Encoding UTF8
    Remove-Item -LiteralPath $item.Path
    Write-Output "Rejected: $($item.Id) -> $dest"
  }

  "applied" {
    $item = Resolve-PendingItem -ItemId $Id
    if ($item.Stage -ne "approved") {
      throw "Only approved items can be marked applied. Current stage: $($item.Stage)"
    }

    $destDir = Join-Path $journalRoot "pending-applied\$($item.Category)"
    $dest = Get-UniqueDestinationPath -Directory $destDir -FileName (Split-Path -Leaf $item.Path)
    $content = Get-Content -LiteralPath $item.Path -Raw
    $applied = Add-ResolutionHeader -Content $content -Status "applied" -SourceId $item.Id -ReasonText $Reason
    Set-Content -LiteralPath $dest -Value $applied -Encoding UTF8
    Remove-Item -LiteralPath $item.Path
    Write-Output "Applied: $($item.Id) -> $dest"
  }
}
