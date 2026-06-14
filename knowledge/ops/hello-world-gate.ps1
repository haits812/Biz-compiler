param(
  [Parameter(Mandatory=$false, Position=0)]
  [ValidateSet("check", "sync", "gate")]
  [string]$Action = "check"
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$helloPath = Join-Path $repoRoot "Hello,world.md"

if ($Action -eq "gate") {
  $Action = "check"
}

$forbiddenRootDirs = @(
  "docs",
  "pending",
  "journal",
  "samples",
  "internal",
  "scripts",
  "schemas",
  "runner",
  "tools",
  "validators",
  "phase-packs"
)

$requiredRootDirs = @("template", "output", "knowledge")
$requiredRootFiles = @("AGENTS.md", "Hello,world.md", "SOUL.md", "USER.md", "COMPASS.md", "MEMORY.md")
$rootDirOrder = @("template", "output", "knowledge")
$rootFileOrder = @("AGENTS.md", "Hello,world.md", "COMPASS.md", "MEMORY.md", "SOUL.md", "USER.md")
$templateDirOrder = @("_shared", "00-entry", "10-source-intake", "20-decompose-encrs", "30-route-executor", "40-ir-freeze", "50-consent", "60-validation", "70-improvement", "80-operation")
$knowledgeDirOrder = @("docs", "pending", "journal", "ops")

$rootDescriptions = @{
  "template" = "業務フォルダの原型"
  "output" = "業務ごとの成果物置き場。実業務作成まで空"
  "knowledge" = "確定知識・pending・journal・管理ops"
  "AGENTS.md" = "作業規約と読み込み順"
  "Hello,world.md" = "現在地。このファイル"
  "COMPASS.md" = "direction packet / heading"
  "MEMORY.md" = "常時参照メモリ"
  "SOUL.md" = "agentの対話姿勢"
  "USER.md" = "ユーザーの作業モデル"
}

$templateDescriptions = @{
  "_shared" = "業務フォルダへコピーされる横断部品"
  "00-entry" = "入口"
  "10-source-intake" = "ソース取得"
  "20-decompose-encrs" = "分解とENCRS"
  "30-route-executor" = "実行者振り分け"
  "40-ir-freeze" = "IR凍結"
  "50-consent" = "生成と同意"
  "60-validation" = "検証"
  "70-improvement" = "改善"
  "80-operation" = "運用"
}

$knowledgeDescriptions = @{
  "docs" = "確定済み要求・決定"
  "pending" = "未承認候補"
  "journal" = "作業ログ・適用/却下ログ"
  "ops" = "knowledgeを操作する管理コマンドとrepo-local skills"
}

function Sort-ByPreferredOrder {
  param(
    [Parameter(Mandatory=$true)]
    [object[]]$Items,

    [Parameter(Mandatory=$true)]
    [string[]]$PreferredOrder
  )

  return @($Items | Sort-Object @{ Expression = {
    $index = [array]::IndexOf($PreferredOrder, $_.Name)
    if ($index -ge 0) { $index } else { 1000 }
  } }, Name)
}

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

function Format-TreeLines {
  param(
    [Parameter(Mandatory=$true)]
    [string]$RootLabel,

    [Parameter(Mandatory=$true)]
    [object[]]$Entries,

    [Parameter(Mandatory=$false)]
    [hashtable]$Descriptions = @{}
  )

  $lines = @($RootLabel)

  for ($i = 0; $i -lt $Entries.Count; $i++) {
    $entry = $Entries[$i]
    $prefix = if ($i -eq ($Entries.Count - 1)) { "└─" } else { "├─" }
    $label = $entry.Name
    if ($entry.PSIsContainer) {
      $label = "$label/"
    }

    $description = ""
    if ($Descriptions.ContainsKey($entry.Name)) {
      $description = "  $($Descriptions[$entry.Name])"
    }

    $lines += "$prefix $label$description"
  }

  return $lines
}

function Get-PendingCounts {
  $pendingRoot = Join-Path $repoRoot "knowledge\pending"

  $pendingDirs = @(
    (Join-Path $pendingRoot "memory"),
    (Join-Path $pendingRoot "compass"),
    (Join-Path $pendingRoot "decisions")
  )

  $approvedDirs = @(
    (Join-Path $pendingRoot "approved\memory"),
    (Join-Path $pendingRoot "approved\compass"),
    (Join-Path $pendingRoot "approved\decisions")
  )

  $pendingCount = 0
  foreach ($dir in $pendingDirs) {
    if (Test-Path -LiteralPath $dir) {
      $pendingCount += @(Get-ChildItem -LiteralPath $dir -File -Filter "*.md" | Where-Object { $_.Name -ne "README.md" }).Count
    }
  }

  $approvedCount = 0
  foreach ($dir in $approvedDirs) {
    if (Test-Path -LiteralPath $dir) {
      $approvedCount += @(Get-ChildItem -LiteralPath $dir -File -Filter "*.md" | Where-Object { $_.Name -ne "README.md" }).Count
    }
  }

  return [pscustomobject]@{
    Pending = $pendingCount
    Approved = $approvedCount
  }
}

function Assert-HelloWorldStructure {
  $errors = New-Object System.Collections.Generic.List[string]

  foreach ($dirName in $requiredRootDirs) {
    $dirPath = Join-Path $repoRoot $dirName
    if (-not (Test-Path -LiteralPath $dirPath -PathType Container)) {
      $errors.Add("Required root directory is missing: $dirName")
    }
  }

  foreach ($fileName in $requiredRootFiles) {
    $filePath = Join-Path $repoRoot $fileName
    if ($fileName -eq "Hello,world.md" -and $Action -eq "sync") {
      continue
    }
    if (-not (Test-Path -LiteralPath $filePath -PathType Leaf)) {
      $errors.Add("Required root file is missing: $fileName")
    }
  }

  foreach ($dirName in $forbiddenRootDirs) {
    $dirPath = Join-Path $repoRoot $dirName
    if (Test-Path -LiteralPath $dirPath -PathType Container) {
      $errors.Add("Forbidden root directory exists: $dirName")
    }
  }

  $outputPath = Join-Path $repoRoot "output"
  if (Test-Path -LiteralPath $outputPath -PathType Container) {
    $outputDirs = @(Get-ChildItem -LiteralPath $outputPath -Directory -Force)
    foreach ($dir in $outputDirs) {
      if ($dir.Name -in @("example-business-id", "_business-id")) {
        $errors.Add("Forbidden placeholder business directory exists: output/$($dir.Name)")
      }
      if ($dir.Name -notmatch '^Biz-\d{3}-.+') {
        $errors.Add("Business output directory must be named like Biz-001-業務名: output/$($dir.Name)")
      }
    }
  }

  $templatePath = Join-Path $repoRoot "template"
  if (Test-Path -LiteralPath $templatePath -PathType Container) {
    foreach ($dirName in $templateDirOrder) {
      if (-not (Test-Path -LiteralPath (Join-Path $templatePath $dirName) -PathType Container)) {
        $errors.Add("Required template directory is missing: template/$dirName")
      }
    }
  }

  $flowchartPath = Join-Path $repoRoot "template\50-consent\pipeline-flowchart\pipeline-flowchart.html"
  if (-not (Test-Path -LiteralPath $flowchartPath -PathType Leaf)) {
    $errors.Add("Required consent view asset is missing: template/50-consent/pipeline-flowchart/pipeline-flowchart.html")
  }

  if ($errors.Count -gt 0) {
    throw ($errors -join [Environment]::NewLine)
  }
}

function New-HelloWorldContent {
  $date = Get-Date -Format "yyyy-MM-dd"
  $pendingCounts = Get-PendingCounts

  $rootDirs = Sort-ByPreferredOrder -Items @(Get-ChildItem -LiteralPath $repoRoot -Directory -Force | Where-Object { $_.Name -ne ".git" }) -PreferredOrder $rootDirOrder
  $rootFiles = Sort-ByPreferredOrder -Items @(Get-ChildItem -LiteralPath $repoRoot -File -Force) -PreferredOrder $rootFileOrder
  $rootEntries = @($rootDirs + $rootFiles)
  $rootTree = Format-TreeLines -RootLabel $repoRoot -Entries $rootEntries -Descriptions $rootDescriptions

  $templatePath = Join-Path $repoRoot "template"
  $templateDirs = Sort-ByPreferredOrder -Items @(Get-ChildItem -LiteralPath $templatePath -Directory -Force) -PreferredOrder $templateDirOrder
  $templateTree = Format-TreeLines -RootLabel "template/" -Entries $templateDirs -Descriptions $templateDescriptions

  $templateFiles = @(Get-ChildItem -LiteralPath $templatePath -File -Recurse -Force | Where-Object { $_.Name -ne ".gitkeep" } | Sort-Object FullName)
  $templateAssetLines = @()
  if ($templateFiles.Count -eq 0) {
    $templateAssetLines += "- None"
  } else {
    foreach ($file in $templateFiles) {
      $templateAssetLines += "- $(Get-RelativePath -Path $file.FullName)"
    }
  }

  $outputPath = Join-Path $repoRoot "output"
  $outputDirs = @()
  if (Test-Path -LiteralPath $outputPath -PathType Container) {
    $outputDirs = @(Get-ChildItem -LiteralPath $outputPath -Directory -Force | Sort-Object Name)
  }

  $outputStateLines = @()
  if ($outputDirs.Count -eq 0) {
    $outputStateLines += "- output/ contains no business folders at last verification."
  } else {
    $outputStateLines += "- output/ business folders at last verification:"
    foreach ($dir in $outputDirs) {
      $outputStateLines += "  - output/$($dir.Name)/"
    }
  }

  $knowledgePath = Join-Path $repoRoot "knowledge"
  $knowledgeDirs = Sort-ByPreferredOrder -Items @(Get-ChildItem -LiteralPath $knowledgePath -Directory -Force) -PreferredOrder $knowledgeDirOrder
  $knowledgeTree = Format-TreeLines -RootLabel "knowledge/" -Entries $knowledgeDirs -Descriptions $knowledgeDescriptions

  $opsPath = Join-Path $repoRoot "knowledge\ops"
  $opsAssetLines = @()
  if (Test-Path -LiteralPath $opsPath -PathType Container) {
    $opsFiles = @(Get-ChildItem -LiteralPath $opsPath -File -Recurse -Force | Sort-Object FullName)
    foreach ($file in $opsFiles) {
      $opsAssetLines += "- $(Get-RelativePath -Path $file.FullName)"
    }
  }
  if ($opsAssetLines.Count -eq 0) {
    $opsAssetLines += "- None"
  }

  $lines = @(
    "# Hello, world",
    "",
    "> Biz-compiler が自分の現在地を嘘なく返すための最小自己記述。",
    ">",
    "> Compass は heading。Hello World は position。",
    "> 位置と方位が揃って、はじめて航行できる。",
    "",
    "## Invariant",
    "",
    "**Hello World は嘘をつかない。**",
    "",
    "ここは read の入口であり、decide / act の入口ではない。判断は COMPASS.md、実行は phase command / template / output 側の責務。",
    "",
    "このファイルが古い可能性があるなら、内容を信じる前に現在のディレクトリ・pending・template構成を確認し、同じターンで更新する。",
    "",
    "## Last Verified",
    "",
    "- Verified at: $date JST",
    "- Verified by: hello-world-gate.ps1",
    "- Scope: Biz-compiler repo self-description only",
    "- Excludes: 実際にコンパイルしている個別業務の状態",
    "",
    "## Gate Command",
    "",
    "このファイルは knowledge/ops/hello-world-gate.ps1 で同期・検査する。",
    "",
    "~~~powershell",
    ".\knowledge\ops\hello-world-gate.ps1 sync   # 現在地を再生成する",
    ".\knowledge\ops\hello-world-gate.ps1 check  # stale / 嘘を検出して失敗する",
    ".\knowledge\ops\hello-world-gate.ps1 gate   # check の別名",
    "~~~",
    "",
    "## What This Repo Is",
    "",
    "Biz-compiler は、業務をそのままAIへ丸投げする道具ではない。",
    "",
    "業務をphaseごとに読み、IPO / gate / scope / executor / artifact / evidence へ分け、AI・automation・human・approvalへ再配置し、運用しながら検証・再コンパイルするための業務設計OSである。",
    "",
    "## Read First",
    "",
    "1. AGENTS.md - 作業規約と読み込み順",
    "2. Hello,world.md - 現在地。このファイル",
    "3. SOUL.md - agentの対話姿勢",
    "4. USER.md - ユーザーの作業モデル",
    "5. COMPASS.md - direction packet / heading",
    "6. MEMORY.md - 常時参照メモリ",
    "7. knowledge/docs/requirements/Biz-compiler_要求定義.md - 要求定義本体",
    "",
    "## Current Root",
    "",
    "~~~text"
  )

  $lines += $rootTree
  $lines += @(
    "~~~",
    "",
    "## Template",
    "",
    "template/ は、業務作成時に output/Biz-001-業務名/ へコピーされる原型である。",
    "",
    "Current phase directories:",
    "",
    "~~~text"
  )

  $lines += $templateTree
  $lines += @(
    "~~~",
    "",
    "Known template assets:"
  )
  $lines += $templateAssetLines

  $lines += @(
    "",
    "## Output",
    "",
    "output/ は、実業務を作るまで空にする。",
    "",
    "業務を作る時だけ、次のように採番して作る。",
    "",
    "~~~text",
    "output/",
    "└─ Biz-001-業務名/",
    "   ├─ _shared/",
    "   ├─ 00-entry/",
    "   ├─ 10-source-intake/",
    "   └─ ...",
    "~~~",
    "",
    "禁止:",
    "",
    "- output/example-business-id/ を作らない",
    "- output/_business-id/ を作らない",
    "- サンプル業務やプレースホルダ業務フォルダを置かない",
    "- 業務フォルダは output/Biz-001-業務名/ の形式で作る",
    "",
    "Current state:"
  )
  $lines += $outputStateLines

  $lines += @(
    "",
    "## Knowledge",
    "",
    "knowledge/ は、このrepoを作るための知識置き場である。",
    "",
    "~~~text"
  )
  $lines += $knowledgeTree
  $lines += @(
    "~~~",
    "",
    "Known knowledge ops assets:"
  )
  $lines += $opsAssetLines
  $lines += @(
    "",
    "Current pending state at last verification:",
    "",
    "- pending items: $($pendingCounts.Pending)",
    "- approved items: $($pendingCounts.Approved)",
    "",
    "確認コマンド:",
    "",
    "~~~powershell",
    ".\knowledge\ops\pending-review.ps1 list -Stage all",
    "~~~",
    "",
    "## What Hello World Must Not Include",
    "",
    "このファイルには、実際にコンパイルしている個別業務の進行状態を含めない。",
    "",
    "それは output/Biz-001-業務名/ 側の phase ledger / artifact / event log の責務である。",
    "",
    "## When To Update",
    "",
    "次を変えたら、同じターンでこのファイルを更新する。",
    "",
    "- ルート直下の構成",
    "- 読み込み順",
    "- template/ のphase構成",
    "- knowledge/ の構成",
    "- output/ の業務ID生成ルール",
    "- pending / approved の状態をこのファイルで数える場合",
    "- knowledge/ops/hello-world-gate.ps1 check が失敗した場合",
    "",
    "## Smoke Test",
    "",
    "AIが何をすればいいか分からない時は、まずここを見る。",
    "",
    "Hello World が現在地を返せないなら、次の作業へ進まない。"
  )

  return (($lines -join [Environment]::NewLine) + [Environment]::NewLine)
}

function Normalize-Text {
  param([Parameter(Mandatory=$true)][string]$Text)

  $cr = [string][char]13
  $lf = [string][char]10
  $crlf = $cr + $lf
  return $Text.Replace($crlf, $lf).Replace($cr, $lf).TrimEnd()
}

Assert-HelloWorldStructure
$expected = New-HelloWorldContent

switch ($Action) {
  "sync" {
    Set-Content -LiteralPath $helloPath -Value $expected -Encoding UTF8
    Write-Output "Synced: $helloPath"
  }

  "check" {
    if (-not (Test-Path -LiteralPath $helloPath -PathType Leaf)) {
      throw "Hello,world.md is missing. Run: .\knowledge\ops\hello-world-gate.ps1 sync"
    }

    $actual = Get-Content -LiteralPath $helloPath -Raw
    if ((Normalize-Text -Text $actual) -ne (Normalize-Text -Text $expected)) {
      Write-Error "Hello World is stale or inaccurate. Run: .\knowledge\ops\hello-world-gate.ps1 sync"
      exit 1
    }

    Write-Output "Hello World gate passed."
  }
}






