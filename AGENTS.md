# AGENTS.md

このリポジトリは Biz-compiler を実装していくための作業場である。作業者は、個別のUI・スキーマ・Skill・ランタイム実装に入る前に、必ず `Hello-world.md`、`SOUL.md`、`USER.md`、`COMPASS.md`、`knowledge/docs/lexicon.md`、`MEMORY.md` を読み、Biz-compilerの判断順序と現在の開発状態に沿って設計すること。

## Global Rules (Windows)

### apply_patch 禁止（非交渉）

`apply_patch` を使わない。Windows絶対パス（`d:/...` / `D:\...`）でプロセスがハングする既知バグがある。

代替:

| やりたいこと | 使うべき手段 |
|---|---|
| ファイルの差し戻し | `git restore --source=HEAD -- <files>` |
| ファイルの上書き | 環境に `write_file` がある場合は `write_file`。ない場合は、現在内容を読んだうえで単一のPowerShell書き込みで全体を上書きする |
| 部分編集 | 小さい差分でも、対象ファイル全体を読んでから全体を書き直す |

やらないこと:

- `apply_patch` にWindows絶対パスを渡す
- ハング回避のために `.claude/settings.json` やdenyリストを編集する
- 読んでいない既存ファイルを推測で上書きする

### Codex Desktop unsafe directive 禁止（非交渉）

返答に `::git-stage{...}` / `::git-commit{...}` / `::git-push{...}` / 未文書化の `::git-*` directive を出さない。

gitのstage / commit / push結果は、通常の文章またはbacktick付きコマンド名で報告する。Windows cwd属性を含むgit directiveはCodex Desktopのmarkdown/review parserを壊す既知リスクがある。

## 読み込み順

作業前に、常時読むものと必要時だけ追加で読むものを分ける。

常時読むもの:

1. `AGENTS.md`
2. `Hello-world.md`
3. `SOUL.md`
4. `USER.md`
5. `COMPASS.md`
6. `knowledge/docs/lexicon.md`
7. `MEMORY.md`

必要時だけ追加で読むもの:

- 現時点の要求全体、要求変更、要求定義との照合を扱う場合は `knowledge/docs/requirements/Biz-compiler_要求定義.md`
- UI同意ビュー・契約JSONを触る場合は `template/50-consent/pipeline-flowchart/pipeline-flowchart.html`
- 過去の決定理由が必要な場合は `knowledge/docs/decisions/`

各ファイルの役割:

- `Hello-world.md`: Biz-compilerの現在地を返す最小自己記述。repo-local Skillとops entrypointもここで確認する。構成変更時は同じターンで更新する。
- `SOUL.md`: このリポジトリで作業するagentの対話姿勢。汎用コンサル人格ではなく、Biz-compilerを一緒に作る聞き取り型の共同設計者としての振る舞いを定義する。
- `USER.md`: このリポジトリで主に話しかけてくる相手の作業モデル。個人プロフィールの保存場所ではなく、会話・設計・実装の進め方を合わせるための前提を置く。
- `COMPASS.md`: 作業者やsubagentへ思考の指向性を渡す direction packet。テンプレート、asset、具体例より先に読む。
- `knowledge/docs/lexicon.md`: 用語定義と概念境界。`IR` / `contract` / `manifest` / `gate` / `approval` / `validation` などを混同しないため、通常作業の初期に読む。
- `MEMORY.md`: 普段の会話で出た「覚えといて」をまず置くメモ。定期的に `knowledge-curation` で掃除する。現在構成、決定履歴、次アクション台帳の正本にはしない。
- `knowledge/docs/requirements/Biz-compiler_要求定義.md`: 必要時だけ読む現時点の要求定義本体。通常作業の初期読み込みには含めない。
- `template/50-consent/pipeline-flowchart/pipeline-flowchart.html`: 同意ビューの再利用サンプル。

`COMPASS.md` はL1、`knowledge/docs/lexicon.md` は常時読むL2、要求定義内のIPO/ENCRS/BPR等は要求確認時だけ追加で読むL2、HTMLやJSONテンプレートはL3として扱う。L3を先に読んで業務設計を型にはめない。

`map.md` を将来導入する場合、それは全体像・配置・読み方を理解するための地図であり、`MEMORY.md` とは別物として扱う。ユーザーが出したファイル名や概念を、確認なしに別の既存ファイルへ言い換えない。

## 追加読み込みルーティング

`COMPASS.md` は全作業者に渡すheadingであり、詳細仕様の置き場ではない。Compassから逃がした詳細は、作業種別に応じて `knowledge/docs/README.md` のread routingに従って追加で読む。

| 作業種別 | 追加で読む場所 |
|---|---|
| メタ土台、配置判断、状態分類、session/subagent briefを扱う | `knowledge/docs/meta/` |
| 用語・概念境界を扱う | `knowledge/docs/lexicon.md` |
| IR / schema / manifest / contract を触る | `knowledge/docs/ir/` |
| 要求全体、要求変更、要求定義との照合を扱う | `knowledge/docs/requirements/` |
| phase設計 / ENCRS / 検証ループを扱う | `knowledge/docs/method/` |
| 判断例・反例・比較ケースが必要 | `knowledge/docs/casebook.md` |
| eval / fresh executor / shadow run を設計する | `knowledge/docs/evaluation.md` |
| 過去の決定理由が必要 | `knowledge/docs/decisions/` |

subagentや別作業者へ重い作業を渡す時は、`Hello-world.md`、`SOUL.md`、`USER.md`、`COMPASS.md`、`knowledge/docs/lexicon.md`、`MEMORY.md` に加え、作業種別に該当する追加読み込み先だけを渡す。

## Knowledge Ops Registry / Skill / Hook / Orchestrator の確認

新しい repo-local Skill、hook adapter、orchestrator、command、tool を作る前に、必ず `Hello-world.md` の `Ops Entrypoints` と `knowledge/ops/registry.md` を確認する。似た役割がある場合は、別資産を増やさず既存入口へ統合する。

作業対象がコード、ドキュメント、Skill、ops、templateを変更する場合は、編集前に `impact-orchestrator` で作業の意図、影響、Markdown参照impact、読むもの、完了gateを切る。`-Files` を渡した場合はfile lockも取る。短い質問回答、読み取りだけ、対象なしのGitHub確認では不要。

過去の会話、作業メモ、決定、ユーザー設定を探す時は `knowledge-search` を使う。ユーザーが「前にこんな会話しなかったっけ？」「前にもこれ話した？」「あの時どう決めたっけ？」「似た話、前にしてない？」のように自然文で聞いた場合も、コマンド名を待たずに `knowledge-search` を発火する。`knowledge/.index/knowledge.sqlite` はMarkdown正本から生成する検索indexであり、直接編集しない。indexが古い場合は `knowledge-search.ps1 index` で再生成する。

```powershell
.\knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1 `
  -Title "作業名" `
  -Kind "ops" `
  -Intent "何をしたいか" `
  -Impact "どこへ効くか" `
  -Files "AGENTS.md;knowledge/ops/registry.md" `
  -Executor "codex" `
  -Risk "medium"
```

ops資産を追加・改名・削除した場合は、同じターンで次を同期する。

- 対象Skillの `SKILL.md` frontmatter: `name` と `description`
- orchestrator / hook / command / tool のREADMEまたは説明
- `knowledge/ops/registry.md` の棚卸し表
- `knowledge/journal/work/locks.json` とwork cardの状態。作業完了時は `impact-orchestrator -Complete` でlockを解放する
- `knowledge/ops/README.md` の説明とコマンド例
- `Hello-world.md` の `Ops Entrypoints` と `Repo-local Skills`: 手編集せず `hello-world-gate.ps1` で再生成する

## 実装方針

Biz-compilerは、業務をそのままAIへ丸投げするツールではない。業務をIPO単位に分解し、automation / Skill / orchestrator / human / external / approval gateへ再配置し、運用しながら検証・再コンパイルする仕組みとして実装する。

実装では、見えるUIより先に契約とIRを重視する。フロー図は合意のための表示であり、正本は機械可読な契約データである。UIだけで安全に見える状態を作らず、実行時制約・schema・manifest・監査ログへ接続できる形を優先する。

業務設計は仮説として扱う。本人の説明、As-Is手順、蒸留物、綺麗なフロー図は、それだけでは真実ではない。fresh executor、shadow run、運用ログ、near-miss、差戻し、反例探索で検証する。

## Compiler Repo / Output Repo Boundary

このリポジトリは、Biz-compilerという汎用業務コンパイラを作る場所である。個別業務ごとのSkill、automation、adapter、運用手順は、このリポジトリの直下に溜め込むものではなく、Biz-compilerが生成・整備する成果物リポジトリ側に置く。

このリポジトリに置くのは、業務をコンパイルするためのphase contract、IR、schema、validator、同意ビュー、サンプル、共通テンプレート、開発運用ルールである。成果物の中にSkillができることはあり得るが、それはコンパイラ本体のSkillではなく、特定業務の実行資産である。

Curatorや棚卸しの発想も、compiler repoとoutput repoで分ける。このリポジトリでは設計資産、要求、Compass、IR、サンプル、pending候補を棚卸しする。出力先リポジトリでは、生成されたSkill、workflow、adapter、業務固有テンプレートを棚卸しする。

Hermesのnarrow waistはそのまま移植しない。Biz-compilerにおける細い腰は、core toolの少なさではなく、10番台以降のphaseごとに凍結される契約とIRである。工程の境界が安定していれば、結果的にcoreは細く保たれる。

## Hello World Gate ルール

- `Hello-world.md` は Biz-compiler の現在地を返すスモークテストである。
- **Hello World は嘘をつかない。** ルート構成、読み込み順、`template/`、`knowledge/`、`output/` の業務ID生成ルールを変えたら、ハロワゲートを通す。
- ハロワゲート運用はrepo-local Skill `knowledge/ops/skills/hello-world-gate/SKILL.md` に従う。グローバルSkillとしてインストールしない。
- 外から叩くコマンドは `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` ひとつだけにする。
- このコマンドは `Hello-world.md` の再生成、検査、必要なら日本語commit、GitHub push、post-checkまで一気通貫で行う。
- ユーザーが `ハロワやっといて`、`ハロワ見て`、`ハロワ確認して`、`ハロワ更新しといて` と言ったら、このSkillを発火する。
- ユーザーが `githubあげといて`、`GitHub上げて`、`pushして`、`pushしといて` と言ったら、まず `git status --short --branch` で対象有無を見る。ローカル差分も未push commitもなく `main...origin/main` が同期済みなら、gate本体は実行せず `対象ないよ。main と origin/main は同期済み。` と返す。対象がある場合だけ、このSkillを発火し、ハロワ更新込みで扱う。
- commit message は日本語で、`理由`、`確認`、`残リスク` を含める。
- Biz-compiler側に `commit-push-gate` Skillを作らない。DeckPilot側の名前と混ぜない。
- `knowledge/ops/registry.md` は Skill / hooks / orchestrators / commands / tools の棚卸し正本である。ops資産を変えたら同じターンで更新し、ハロワゲートを通す。
- `knowledge/ops/` 直下に `.ps1` を置かない。Skill実行体は `knowledge/ops/skills/<skill-name>/`、hook adapterは `knowledge/ops/hooks/`、orchestrator実行体は `knowledge/ops/orchestrators/<orchestrator-name>/` に説明ファイルと同居させる。
- `Hello-world.md` は read の入口であり、decide / act の入口ではない。判断は `COMPASS.md`、実行は phase command / template / output 側の責務とする。
- 実際にコンパイルしている個別業務の状態は `Hello-world.md` に入れない。`output/Biz-001-業務名/` 側の ledger / artifact / event log に置く。

## ディレクトリ構成ルール

人間が見る主要導線は、数字phaseを主語にした `template/` と `output/` に寄せる。確定/未承認/作業ログなどの知識系は `knowledge/` にまとめる。業務実行時に使う横断部品はリポジトリ直下へ散らさず、`template/_shared/` に入れる。

基本形:

```text
template/
  _shared/
    internal/
    scripts/
  00-entry/
  10-source-intake/
  20-decompose-encrs/
  ...
  50-consent/
    pipeline-flowchart/
  ...
  80-operation/

output/
  Biz-001-業務名/  # 業務作成時に採番して作る。プレースホルダは置かない。
    _shared/
    00-entry/
    10-source-intake/
    20-decompose-encrs/
    ...
    80-operation/

knowledge/
  docs/
  pending/
  journal/
  ops/
  .index/  # generated SQLite search index
```

守ること:

- `template/` は業務フォルダの原型として扱う。業務作成時に `output/Biz-001-業務名/` へコピーされる前提で置く。
- `template/<数字phase>` は、各phaseの雛形置き場として扱う。
- `template/_shared/` は、phase横断で業務フォルダ内から使う内部部品、runner、validator、tool、実行スクリプトの置き場とする。
- `template/50-consent/pipeline-flowchart/pipeline-flowchart.html` はフェーズ50同意ビューのテンプレート資産として扱う。`samples/` には置かない。
- `output/` は業務ごとの実行成果物置き場である。業務を作るタイミングで `Biz-001-業務名` のように採番したフォルダを作り、その配下に `template/` と同じ数字phase構成を作る。
- `output/` 直下に `example-business-id`、`_business-id`、サンプル業務、プレースホルダ業務フォルダを作らない。
- `knowledge/` はこのリポジトリを作るための知識置き場である。`docs/`、`pending/`、`journal/`、知識管理用 `ops/` は混ぜずに `knowledge/` 配下で分ける。
- `knowledge/.index/` は生成SQLite検索index置き場であり、Markdown正本ではない。`*.sqlite` はcommitしない。
- リポジトリ直下に `docs/`、`pending/`、`journal/`、`samples/`、`internal/`、`scripts/`、`schemas/`、`runner/`、`tools/`、`validators/`、`phase-packs/` を増やさない。
- 会話UIやCLIの説明は、まず `template/<phase>` と `output/Biz-001-業務名/<phase>` を主語にする。`template/_shared/` と `knowledge/` は補助構造であり、人間向けの主要導線にしない。

## 開発運用メモリ

このリポジトリでは、開発中の学びを次の層に分ける。

- `MEMORY.md`: 普段の短い「覚えといて」メモ。未整理メモを含んでよいが、定期的に `knowledge-curation` で掃除する。現在構成、決定済み一覧、次アクション台帳、正本の要約は置かない。
- `knowledge/docs/decisions/`: 背景と理由を含む設計・運用上の決定記録。
- `knowledge/journal/`: 会話履歴、セッションログ、試行錯誤、未整理メモ。
- `knowledge/pending/`: AIや作業者が提案したが、まだ正式反映していない更新。

`MEMORY.md` は普段メモとして使ってよいが、肥大化させない。現在構成は `Hello-world.md`、作業規約は `AGENTS.md`、決定履歴は `knowledge/docs/decisions/`、メタ台帳は `knowledge/docs/meta/README.md` を正本にする。正本化した内容は `knowledge-curation` で `MEMORY.md` から削る。

### 即時メモを主機構にする

会話や作業が長くなると、セッション終盤で初期の重要点を正確に保持できないことがある。したがって、開発運用メモリは「最後にまとめて思い出す」方式に依存しない。

次回以降も効きそうだが、その場で分類判断が重い内容は、まず `MEMORY.md` に短く置いてよい。明らかな会話履歴や作業過程そのものは `knowledge/journal/`、判断に迷う候補は `knowledge/pending/`、背景理由つきの採用/却下は `knowledge/docs/decisions/`、作業規約は `AGENTS.md`、判断方位は `COMPASS.md`、ユーザーの作業モデルは `USER.md` に置く。後で `knowledge-curation` が `MEMORY.md` を整理する。

即時メモのトリガー:

- ユーザーが「これでいこう」「採用」「それは違う」と方針を確定・訂正した。
- 今後の実装順序、配置、読み込み順、禁止事項が決まった。
- 同じ失敗を避けるための制約や注意が出た。
- Compass、Decision、AGENTSなどの正本に昇格しそうな判断priorや設計理由が出た。
- 長い会話で後から忘れそうだが、次回以降も効く内容が出た。分類に迷う場合は、まず `MEMORY.md` に短く置く。

final前の更新要否確認は保険であり、主機構ではない。

未承認のpending候補を作るときは、`knowledge/ops/skills/knowledge-curation/new-pending-update.ps1` を使う。分類に迷う短い普段メモは、まず `MEMORY.md` に置いてよい。

### Pending approval workflow

未確定のMemory、Compass、Decision更新は `knowledge/pending/` に置く。人間が確認して正式反映してよいと判断したものは、`knowledge/ops/skills/knowledge-curation/pending-review.ps1 approve` で `knowledge/pending/approved/` へ移す。

`approved` は「正式ファイルへ反映済み」ではない。承認後、agentまたは作業者が文脈を読んで `MEMORY.md`、`COMPASS.md`、`knowledge/docs/decisions/` などへ反映する。反映後に `knowledge/ops/skills/knowledge-curation/pending-review.ps1 applied` で `knowledge/journal/pending-applied/` へ移す。却下する場合は `knowledge/ops/skills/knowledge-curation/pending-review.ps1 reject` で `knowledge/journal/pending-rejected/` へ移す。

機械的に `Proposed Change` を本文へ追記しない。正式反映では、既存ファイルの役割、重複、語彙の区別を確認してから編集する。

よく使うコマンド:

```powershell
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "MEMORY.mdへ反映済み"
```

## 設計原則

- 不可逆な外部作用は、効率や実績だけでfull-autoにしない。
- 自律レベル、gate、executor、データ種別、scopeの危険な組み合わせはスキーマで拒否する方向に寄せる。
- 蒸留物には `provenance` と `confidence` を持たせ、観測済み契約と未検証仮説を混ぜない。
- N-interfaceは所有権ではなく、他人・他部署・社外との共有インターフェース変更として扱う。
- `store != show` を守る。図に出すのは粗い契約、実装に必要な詳細はノードpayloadに保持する。
- As-Is手順は必ずdispositionを持つ。削除、自動化、結合、人手維持の行き先がない孤児を残さない。
- 70/80の運用ループを後回しの飾りにしない。drift、改善案、eval、承認、昇降格、監査がBiz-compilerの価値の中心である。
- 実装前に、対象変更がCompass、IR、同意ビュー、運用ループのどこへ影響するかを確認する。

## 実装時の優先順位

1. 契約データとスキーマ
2. 危険な組み合わせの拒否、scope境界、承認ゲート
3. 同意ビューなどの表示
4. 実行ランタイム、ログ、監査、昇降格
5. 個別Skillや自動化スクリプト

この順序は固定ではないが、UIやデモの見栄えを理由に、IR・安全制約・運用ループを曖昧にしない。

## ドキュメント編集

- 日本語を基本とし、`IPO`、`IR`、`gate`、`provenance` などの既に定着した英語用語は維持する。
- Compassにテンプレート、具体例、語彙定義、IR詳細、方法論を詰め込みすぎない。具体例は `knowledge/docs/casebook.md`、語彙定義は `knowledge/docs/lexicon.md`、IR詳細は `knowledge/docs/ir/`、方法論は `knowledge/docs/method/` へ分ける。
- 要求定義を変更した場合は、変更がCompass、IR、同意ビュー、運用ループのどこに効くかを明示する。
- リスク指摘を「単なる未実装」として流さない。意図的な未固定領域か、安全制約として今すぐ固定すべき領域かを分ける。
- ユーザーが出した言葉、ファイル名、概念の区別を勝手に潰さない。補完が必要な場合は推測として扱う。
- 作業中に即時メモのトリガーが出たら、終盤を待たずに該当する記憶レイヤーへ反映する。
- メタ土台を整備・追加・分割・廃止したら、同じターンで `knowledge/docs/meta/README.md` を更新する。
- 作業後、`MEMORY.md` に重複や古いメモを溜めすぎていないか、`knowledge/docs/decisions/`、`knowledge/journal/`、`knowledge/pending/` の更新漏れがないか確認する。

## `template/50-consent/pipeline-flowchart/pipeline-flowchart.html` 編集

- 単一HTML・外部依存なしを維持する。
- 正本は `<script type="application/json">` 内の契約JSONとし、DOMやSVGを手で正本化しない。
- As-Is / To-Be / Final の版差分が、同じ担当レーン上で人間作業からAI/automationへ移ることを示すようにする。
- O→Iの型チェックは表示だけでなく、将来の構造スキーマ参照へ拡張しやすい形に保つ。
- 対象外scopeは表示上の薄い帯だけで終わらせず、manifest allowlistや実行時制御へ接続する前提で扱う。

## 完了報告

作業後は、変更したファイル、確認したこと、未確認のリスクを短く報告する。テストや表示確認をしていない場合は、していないと明示する。
