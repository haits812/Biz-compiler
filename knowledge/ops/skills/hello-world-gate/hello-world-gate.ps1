param(
  [Parameter(Mandatory=$false)]
  [string]$Subject = "",

  [Parameter(Mandatory=$false)]
  [string]$Reason = "",

  [Parameter(Mandatory=$false)]
  [string]$Verified = "",

  [Parameter(Mandatory=$false)]
  [string]$Risks = "",

  [Parameter(Mandatory=$false)]
  [string]$Type = "運用",

  [Parameter(Mandatory=$false)]
  [switch]$NoPush
)

$ErrorActionPreference = "Stop"

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..\..\..")).Path
$helloPath = Join-Path $repoRoot "Hello-world.md"

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
$requiredRootFiles = @("README.md", "setup.md", ".gitignore", "AGENTS.md", "Hello-world.md", "SOUL.md", "USER.md", "COMPASS.md", "MEMORY.md")
$rootDirOrder = @("template", "output", "knowledge")
$rootFileOrder = @("README.md", "setup.md", ".gitignore", "AGENTS.md", "Hello-world.md", "COMPASS.md", "MEMORY.md", "SOUL.md", "USER.md")
$templateDirOrder = @("_shared", "00-entry", "10-source-intake", "20-decompose-encrs", "30-route-executor", "40-ir-freeze", "50-consent", "60-validation", "70-improvement", "80-operation")
$knowledgeDirOrder = @("docs", "pending", "journal", "ops", ".index")

$rootDescriptions = @{
  "template" = "業務フォルダの原型"
  "output" = "業務ごとの成果物置き場。実業務作成まで空"
  "knowledge" = "確定知識・pending・journal・管理ops"
  "README.md" = "GitHub入口。正本はHello World"
  "setup.md" = "clone後の初期セットアップ入口"
  ".gitignore" = "生成物除外"
  "AGENTS.md" = "作業規約と読み込み順"
  "Hello-world.md" = "現在地。このファイル"
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
  "ops" = "repo-local skills / hooks / orchestrators / registry"
  ".index" = "生成SQLite検索index。正本ではない"
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
    (Join-Path $pendingRoot "decisions"),
    (Join-Path $pendingRoot "skills")
  )

  $approvedDirs = @(
    (Join-Path $pendingRoot "approved\memory"),
    (Join-Path $pendingRoot "approved\compass"),
    (Join-Path $pendingRoot "approved\decisions"),
    (Join-Path $pendingRoot "approved\skills")
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

function Get-RepoLocalSkillLines {
  $skillsRoot = Join-Path $repoRoot "knowledge\ops\skills"
  $skillLines = @()

  if (-not (Test-Path -LiteralPath $skillsRoot -PathType Container)) {
    return @("- None")
  }

  $skillDirs = @(Get-ChildItem -LiteralPath $skillsRoot -Directory -Force | Sort-Object Name)
  foreach ($dir in $skillDirs) {
    $skillPath = Join-Path $dir.FullName "SKILL.md"
    $name = $dir.Name
    $description = "repo-local Skill"

    if (Test-Path -LiteralPath $skillPath -PathType Leaf) {
      $skillText = Get-Content -LiteralPath $skillPath -Raw
      $nameMatch = [regex]::Match($skillText, '(?m)^name:\s*(.+?)\s*$')
      $descriptionMatch = [regex]::Match($skillText, '(?m)^description:\s*(.+?)\s*$')
      if ($nameMatch.Success) {
        $name = $nameMatch.Groups[1].Value.Trim()
      }
      if ($descriptionMatch.Success) {
        $description = $descriptionMatch.Groups[1].Value.Trim()
      }
    }

    $skillLines += "- ${name}: $description"
    $skillLines += "  - path: $(Get-RelativePath -Path $dir.FullName)/"

    $scriptFiles = @(Get-ChildItem -LiteralPath $dir.FullName -File -Filter "*.ps1" -Force | Sort-Object Name)
    if ($scriptFiles.Count -gt 0) {
      $scriptList = ($scriptFiles | ForEach-Object { Get-RelativePath -Path $_.FullName }) -join ", "
      $skillLines += "  - commands: $scriptList"
    }
  }

  if ($skillLines.Count -eq 0) {
    return @("- None")
  }

  return $skillLines
}

function Get-OpsEntrypointLines {
  return @(
    "- ops overview: knowledge/ops/README.md",
    "- registry: knowledge/ops/registry.md",
    "- owner docs rule: ops資産を使う/変更する時はregistryの後に対象のREADME.mdまたはSKILL.mdを読む",
    "- skills: knowledge/ops/skills/",
    "  - hello-world-gate docs: knowledge/ops/skills/hello-world-gate/SKILL.md",
    "  - hello-world-gate command: knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1",
    "  - knowledge-curation docs: knowledge/ops/skills/knowledge-curation/SKILL.md",
    "  - empirical-prompt-tuning docs: knowledge/ops/skills/empirical-prompt-tuning/SKILL.md",
    "  - paper-write docs: knowledge/ops/skills/paper-write/SKILL.md",
    "  - skill-creator-gate docs: knowledge/ops/skills/skill-creator-gate/SKILL.md",
    "  - skill-creator-gate proposal command: knowledge/ops/skills/skill-creator-gate/new-skill-proposal.ps1",
    "  - skill-creator-gate validation command: knowledge/ops/skills/skill-creator-gate/validate-repo-skill.ps1",
    "  - web-research-to-report docs: knowledge/ops/skills/web-research-to-report/SKILL.md",
    "- hooks: knowledge/ops/hooks/README.md",
    "  - codex-pre-work: knowledge/ops/hooks/codex-pre-work.ps1",
    "  - claude-code-pre-work: knowledge/ops/hooks/claude-code-pre-work.ps1",
    "  - pre-publish: knowledge/ops/hooks/pre-publish.ps1",
    "- orchestrators: knowledge/ops/orchestrators/",
    "  - impact-orchestrator docs: knowledge/ops/orchestrators/impact-orchestrator/README.md",
    "  - impact-orchestrator command: knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1",
    "  - knowledge-search docs: knowledge/ops/orchestrators/knowledge-search/README.md",
    "  - knowledge-search command: knowledge/ops/orchestrators/knowledge-search/knowledge-search.ps1",
    "- knowledge index: knowledge/.index/README.md (SQLite DBは生成物。commitしない)",
    "- work ledger: knowledge/journal/work/",
    "  - active locks: knowledge/journal/work/locks.json"
  )
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
    if ($fileName -eq "Hello-world.md" -and -not (Test-Path -LiteralPath $filePath -PathType Leaf)) {
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

  $requiredOpsFiles = @(
    "knowledge\ops\README.md",
    "knowledge\ops\registry.md",
    "knowledge\ops\hooks\README.md",
    "knowledge\ops\hooks\codex-pre-work.ps1",
    "knowledge\ops\hooks\claude-code-pre-work.ps1",
    "knowledge\ops\hooks\pre-publish.ps1",
    "knowledge\ops\orchestrators\impact-orchestrator\README.md",
    "knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1",
    "knowledge\ops\orchestrators\knowledge-search\README.md",
    "knowledge\ops\orchestrators\knowledge-search\knowledge-search.ps1",
    "knowledge\ops\orchestrators\knowledge-search\knowledge_search.py",
    "knowledge\.index\README.md",
    "knowledge\journal\work\README.md",
    "knowledge\journal\work\locks.json"
  )
  foreach ($relativePath in $requiredOpsFiles) {
    $filePath = Join-Path $repoRoot $relativePath
    if (-not (Test-Path -LiteralPath $filePath -PathType Leaf)) {
      $errors.Add("Required ops file is missing: $($relativePath.Replace("\", "/"))")
    }
  }

  $opsRootPath = Join-Path $repoRoot "knowledge\ops"
  if (Test-Path -LiteralPath $opsRootPath -PathType Container) {
    $directOpsScripts = @(Get-ChildItem -LiteralPath $opsRootPath -File -Filter "*.ps1" -Force)
    foreach ($script in $directOpsScripts) {
      $errors.Add("Do not place .ps1 directly under knowledge/ops: $(Get-RelativePath -Path $script.FullName)")
    }
  }
  if ($errors.Count -gt 0) {
    throw ($errors -join [Environment]::NewLine)
  }
}

function New-HelloWorldContent {
  $date = Get-Date -Format "yyyy-MM-dd"
  $pendingCounts = Get-PendingCounts
  $repoLocalSkillLines = Get-RepoLocalSkillLines
  $opsEntrypointLines = Get-OpsEntrypointLines

  $rootDirs = Sort-ByPreferredOrder -Items @(Get-ChildItem -LiteralPath $repoRoot -Directory -Force | Where-Object { $_.Name -ne ".git" }) -PreferredOrder $rootDirOrder
  $rootFiles = Sort-ByPreferredOrder -Items @(Get-ChildItem -LiteralPath $repoRoot -File -Force) -PreferredOrder $rootFileOrder
  $rootEntries = @($rootDirs + $rootFiles)
  $rootTree = Format-TreeLines -RootLabel "<repo-root>/" -Entries $rootEntries -Descriptions $rootDescriptions

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
    $opsFiles = @(
      Get-ChildItem -LiteralPath $opsPath -File -Recurse -Force |
        Where-Object {
          $_.FullName -notmatch "[\\/]__pycache__[\\/]" -and
          $_.Extension -notin @(".pyc", ".pyo", ".pyd")
        } |
        Sort-Object FullName
    )
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
    "このファイルは knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1 で同期・検査・commit/pushまで一気通貫する。",
    "",
    "~~~powershell",
    '.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `',
    '  -Type "運用" `',
    '  -Subject "何を変えたか" `',
    '  -Reason "なぜ必要だったか" `',
    '  -Verified "何を確認したか" `',
    '  -Risks "残っている注意点"',
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
    "2. Hello-world.md - 現在地。このファイル",
    "3. SOUL.md - agentの対話姿勢",
    "4. USER.md - ユーザーの作業モデル",
    "5. COMPASS.md - direction packet / heading",
    "6. knowledge/docs/lexicon.md - 用語定義と概念境界",
    "7. MEMORY.md - 常時参照メモリ",
    "",
    "要求定義は、要求全体の確認・要求変更・要求定義との照合が必要な時だけ knowledge/docs/requirements/ から追加で読む。",
    "",
    "## Setup",
    "",
    "clone直後や環境を作り直した時は setup.md を読む。",
    "",
    "setup.md は、必要ツール、hook接続、生成物、knowledge-search index、確認コマンドの入口である。hook一覧は複製せず、knowledge/ops/registry.md と knowledge/ops/hooks/README.md を正本にする。",
    "",
    "## Current Root",
    "",
    "この構成図では、clone先に依存しないようrepo rootを ``<repo-root>/`` と表記する。実パスを確認する時は ``git rev-parse --show-toplevel`` を使う。",
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
    "## Ops Entrypoints",
    "",
    "初期読み込みでは、ここで存在と入口だけを確認する。Skillを作る、hook/orchestrator/command/toolを触る、作業前impact、lock、knowledge searchを扱う時は、まず knowledge/ops/registry.md を読み、その後対象ownerの README.md / SKILL.md を読む。",
    ""
  )
  $lines += $opsEntrypointLines
  $lines += @(
    "",
    "## Natural Language Triggers",
    "",
    "ユーザーが過去の会話・作業メモ・決定・ユーザー設定を探している自然文を出したら、コマンド名を待たずに knowledge-search を使う。",
    "",
    "代表例:",
    "",
    "- 前にこんな会話しなかったっけ？",
    "- 前にもこれ話した？",
    "- あの時どう決めたっけ？",
    "- 似た話、前にしてない？",
    "- その設定どこかに残ってない？",
    "- この話の経緯探して",
    "",
    "動き方:",
    "",
    "- まずユーザーの言葉をそのまま検索語にする。必要なら2〜3語へ分けて再検索する。",
    "- indexが無い、または古い可能性がある時は `knowledge-search.ps1 index` を先に実行する。",
    "- 結果は `path#Lstart-Lend` を根拠として返す。SQLite内の本文を正本にしない。",
    "",
    "## Repo-local Skills",
    "",
    "初期読み込みでは、既存Skillの発火条件を確認してから新しいSkillを作る。似た役割のSkillがあるなら、まず既存Skillへ統合する。",
    "repo-local Skillを追加・改名・削除したら、SKILL.mdのname/description、owner説明、knowledge/ops/README.md、Hello Worldの一覧を同じターンで同期する。",
    ""
  )
  $lines += $repoLocalSkillLines
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
    '.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `',
    '  -Type "運用" `',
    '  -Subject "何を変えたか" `',
    '  -Reason "なぜ必要だったか" `',
    '  -Verified "何を確認したか" `',
    '  -Risks "残っている注意点"',
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
    "- setup.md の環境前提、hook接続、生成物ルール",
    "- 読み込み順",
    "- template/ のphase構成",
    "- knowledge/ の構成",
    "- output/ の業務ID生成ルール",
    "- pending / approved の状態をこのファイルで数える場合",
    "- repo-local Skillを追加・改名・削除した場合",
    "- knowledge/ops/registry.md、hooks、orchestrators、repo-local commands/toolsを変更した場合",
    "- ops資産のowner説明ファイル、またはその読み導線を変更した場合",
    "- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1 が失敗した場合",
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

function Invoke-Git {
  param([Parameter(Mandatory=$true)][string[]]$GitArgs)

  & git @GitArgs
  if ($LASTEXITCODE -ne 0) {
    throw "git command failed: git $($GitArgs -join ' ')"
  }
}

function Get-GitOutput {
  param([Parameter(Mandatory=$true)][string[]]$GitArgs)

  $output = & git @GitArgs
  if ($LASTEXITCODE -ne 0) {
    throw "git command failed: git $($GitArgs -join ' ')"
  }
  return ($output -join [Environment]::NewLine).Trim()
}

function Get-UpstreamBranch {
  $output = & git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>$null
  if ($LASTEXITCODE -ne 0) {
    return ""
  }
  return ($output -join [Environment]::NewLine).Trim()
}

function Get-AheadCount {
  param([Parameter(Mandatory=$true)][string]$Upstream)

  if ([string]::IsNullOrWhiteSpace($Upstream)) {
    return 0
  }

  $count = Get-GitOutput -GitArgs @("rev-list", "--count", "$Upstream..HEAD")
  if ([string]::IsNullOrWhiteSpace($count)) {
    return 0
  }

  return [int]$count
}

function Get-BehindCount {
  param([Parameter(Mandatory=$true)][string]$Upstream)

  if ([string]::IsNullOrWhiteSpace($Upstream)) {
    return 0
  }

  $count = Get-GitOutput -GitArgs @("rev-list", "--count", "HEAD..$Upstream")
  if ([string]::IsNullOrWhiteSpace($count)) {
    return 0
  }

  return [int]$count
}

function Assert-JapaneseText {
  param(
    [Parameter(Mandatory=$true)][string]$Label,
    [Parameter(Mandatory=$true)][string]$Text
  )

  if ([string]::IsNullOrWhiteSpace($Text)) {
    throw "$Label is required for hello-world-gate commit."
  }

  if ($Text -notmatch '[\p{IsHiragana}\p{IsKatakana}\p{IsCJKUnifiedIdeographs}]') {
    throw "$Label must include Japanese text. Hello World Gate commit messages are written in Japanese."
  }
}

function Convert-ToBulletLines {
  param([Parameter(Mandatory=$true)][string]$Text)

  $items = [System.Text.RegularExpressions.Regex]::Split($Text, "\r?\n|;") |
    ForEach-Object { $_.Trim() } |
    Where-Object { $_.Length -gt 0 } |
    ForEach-Object {
      if ($_.StartsWith("- ")) { $_.Substring(2).Trim() } else { $_ }
    }

  if (@($items).Count -eq 0) {
    throw "Commit message section is empty."
  }

  return @($items | ForEach-Object { "- $_" })
}

function New-GateCommitMessage {
  Assert-JapaneseText -Label "Type" -Text $Type
  Assert-JapaneseText -Label "Subject" -Text $Subject
  Assert-JapaneseText -Label "Reason" -Text $Reason
  Assert-JapaneseText -Label "Verified" -Text $Verified
  Assert-JapaneseText -Label "Risks" -Text $Risks

  $lines = @(
    "${Type}: $Subject",
    "",
    "理由:"
  )
  $lines += Convert-ToBulletLines -Text $Reason
  $lines += @(
    "",
    "確認:"
  )
  $verifiedLines = Convert-ToBulletLines -Text $Verified
  $hasHelloCheck = $false
  foreach ($line in $verifiedLines) {
    if ($line -match 'hello-world-gate') {
      $hasHelloCheck = $true
    }
  }
  $lines += $verifiedLines
  if (-not $hasHelloCheck) {
    $lines += "- hello-world-gate: pass"
  }
  $lines += @(
    "",
    "残リスク:"
  )
  $lines += Convert-ToBulletLines -Text $Risks

  return (($lines -join [Environment]::NewLine) + [Environment]::NewLine)
}

function Assert-HelloWorldMatches {
  param([Parameter(Mandatory=$true)][string]$ExpectedContent)

  if (-not (Test-Path -LiteralPath $helloPath -PathType Leaf)) {
    throw "Hello-world.md is missing and could not be generated."
  }

  $actual = Get-Content -LiteralPath $helloPath -Raw
  if ((Normalize-Text -Text $actual) -ne (Normalize-Text -Text $ExpectedContent)) {
    throw "Hello World is stale or inaccurate after regeneration."
  }
}

function Invoke-HelloWorldGate {
  Set-Location -LiteralPath $repoRoot

  $insideWorkTree = Get-GitOutput -GitArgs @("rev-parse", "--is-inside-work-tree")
  if ($insideWorkTree -ne "true") {
    throw "Not inside a git work tree: $repoRoot"
  }

  $branch = Get-GitOutput -GitArgs @("rev-parse", "--abbrev-ref", "HEAD")
  if ($branch -eq "HEAD") {
    throw "Detached HEAD is not allowed for hello-world-gate."
  }

  $remote = Get-GitOutput -GitArgs @("remote", "get-url", "origin")
  if ([string]::IsNullOrWhiteSpace($remote)) {
    throw "Git remote 'origin' is not configured."
  }

  Assert-HelloWorldStructure
  $publishExpected = New-HelloWorldContent
  Set-Content -LiteralPath $helloPath -Value $publishExpected -Encoding UTF8
  Write-Output "hello-world-gate: synced Hello-world.md"

  Assert-HelloWorldMatches -ExpectedContent $publishExpected
  Write-Output "hello-world-gate: check passed"

  $statusBefore = Get-GitOutput -GitArgs @("status", "--porcelain")
  $upstream = Get-UpstreamBranch
  $aheadCount = Get-AheadCount -Upstream $upstream
  $behindCount = Get-BehindCount -Upstream $upstream

  if ($behindCount -gt 0) {
    throw "Current branch is behind $upstream by $behindCount commit(s). Sync before hello-world-gate push."
  }

  if ([string]::IsNullOrWhiteSpace($statusBefore)) {
    if ($aheadCount -gt 0) {
      if ($NoPush) {
        Write-Output "hello-world-gate: NoPush specified. $aheadCount commit(s) are ahead of $upstream."
      } else {
        Write-Output "hello-world-gate: git push origin $branch"
        Invoke-Git -GitArgs @("push", "-u", "origin", $branch)
        Write-Output "hello-world-gate: pushed $aheadCount existing commit(s) to origin/$branch"
      }

      $postExpected = New-HelloWorldContent
      Assert-HelloWorldMatches -ExpectedContent $postExpected
      Write-Output "hello-world-gate: post-check passed"
      Write-Output "hello-world-gate: final status"
      Invoke-Git -GitArgs @("status", "--short", "--branch")
      return
    }

    Write-Output "hello-world-gate: 対象ないよ (no changes or unpushed commits)"
    Write-Output "hello-world-gate: final status"
    Invoke-Git -GitArgs @("status", "--short", "--branch")
    return
  }

  $message = New-GateCommitMessage
  $messagePath = Join-Path ([System.IO.Path]::GetTempPath()) ("hello-world-gate-message-{0}.txt" -f [System.Guid]::NewGuid().ToString("N"))
  Set-Content -LiteralPath $messagePath -Value $message -Encoding UTF8

  try {
    Write-Output "hello-world-gate: git add -A"
    Invoke-Git -GitArgs @("add", "-A")

    & git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
      throw "No staged changes to commit."
    }
    if ($LASTEXITCODE -ne 1) {
      throw "git diff --cached --quiet failed."
    }

    Write-Output "hello-world-gate: git commit -F <message>"
    Invoke-Git -GitArgs @("commit", "-F", $messagePath)

    $commitHash = Get-GitOutput -GitArgs @("rev-parse", "--short", "HEAD")

    if ($NoPush) {
      Write-Output "hello-world-gate: NoPush specified. Commit created but not pushed: $commitHash"
    } else {
      Write-Output "hello-world-gate: git push origin $branch"
      Invoke-Git -GitArgs @("push", "-u", "origin", $branch)
      Write-Output "hello-world-gate: pushed commit $commitHash to origin/$branch"
    }

    $postExpected = New-HelloWorldContent
    Assert-HelloWorldMatches -ExpectedContent $postExpected
    Write-Output "hello-world-gate: post-check passed"

    Write-Output "hello-world-gate: final status"
    Invoke-Git -GitArgs @("status", "--short", "--branch")
  } finally {
    if (Test-Path -LiteralPath $messagePath -PathType Leaf) {
      Remove-Item -LiteralPath $messagePath -Force
    }
  }
}

Invoke-HelloWorldGate
