---
name: skill-creator-gate
description: Use when Biz-compiler repoで新しいrepo-local Skillを作る、既存Skillを改修する、作業をSkill化する、やりたいことを元にどれをSkill化するか組み立てる、スキル作って/Skill作って/この流れをSkillにして/この仕事をSkill化できるか/creator gate/skill-creator-gate/meta-skill-creator流用と言われた時。やりたいことの聞き取り、Skill候補整理、多工程Skill設計、標準skill-creator作法による実装、repo-local登録、検査まで行う。
---

# Skill Creator Gate

## 範囲

これは Biz-compiler リポジトリ専用の repo-local Skill。グローバルSkillにはしない。

目的は、ユーザーの「やりたいこと」から、どの部分をSkill化するべきかを判断し、必要なrepo-local Skillを安全に実装することである。

これは gate でよい。gate の役割は、Skillを増やす前に、作るべき単位、既存資産との衝突、発火条件、検査、登録を通すことにある。ただし、gateの中核は「登録手続き」ではなく、Skill実装前の聞き取り、Skill化対象の整理、Skill設計である。

OpenSquillaの `meta-skill-creator` からは、多工程の作業を trigger / steps / validation gates / collision checks へ落とす作法を参考にする。OpenSquilla runtime、`meta_invoke`、`kind: meta`、`composition.steps` は導入しない。

標準 `skill-creator` からは、SKILL.mdの書き方、trigger-rich description、progressive disclosure、scripts / references / assets の切り分け、検証の作法を流用する。

このSkillは creator でも gate でもある。やりたいことを聞き取り、Skill化候補を整理し、必要なら `knowledge/pending/skills/` にproposalを作り、承認後または確度が高い場合は `knowledge/ops/skills/<skill-name>/` へ正式Skillを作り、registry / ops README / Hello World まで同期する。

## 発話トリガー

次のような依頼で使う。

- `スキル作って`
- `Skill作って`
- `この流れをSkillにして`
- `この仕事をSkill化できるか見て`
- `やりたいことを元にどれをSkill化するか組み立てて`
- `普段やってる仕事をヒアリングしてSkillにして`
- `repo-local Skillにして`
- `skill-creator-gate`
- `creator gate`
- `meta-skill-creator流用で作って`
- `OpenSquillaのmeta-skill-creatorに則ってSkill作って`
- `この作業、毎回やるからSkill化して`
- `既存Skillと被らないように作って`
- `Skillのdescription直して`
- `Skillの発火条件を整理して`

引用された会話ログ、古いprompt、Web UI dump、Skill一覧に上記語が含まれているだけなら発火しない。ユーザーが「作る」「Skill化する」「改修する」「どれをSkill化するか組み立てる」と現在依頼している時だけ使う。

## 何を作るSkillか

このSkillが作るのは、単なる短い手順メモではない。

ユーザーのやりたいことや普段の作業から、次を含む多工程Skillを設計できるようにする。これは標準skill-creatorの「ユーザー意図からSkillを作る」前提と同じであり、Biz-compilerでは工程が多いSkillでも崩れないように明示する。

| 要素 | Skillに落とす内容 |
|---|---|
| intake | 何を聞けば作業を始められるか |
| source read | どの資料、ファイル、ログ、Web情報を見るか |
| workflow structure | 入力、判断、作業、出力、例外をどう並べるか |
| routing | Skill / script / orchestrator / human / docs rule のどれに逃がすか |
| steps | 実行順、分岐、確認点、成果物の形 |
| guardrails | 禁止事項、未確認事項の扱い、外部作用の制限 |
| validation | 動いたと言える条件、テストプロンプト、出力確認 |
| handoff | 人間確認、他Skill、orchestrator、テンプレートへの受け渡し |

## 流用する作法

### OpenSquillaから流用するもの

| OpenSquilla meta-skill-creator | Biz-compiler skill-creator-gate |
|---|---|
| repeated multi-skill collaboration pattern | やりたいことや普段の仕事を多工程Skillとして扱える形にする |
| MetaSkill proposal | `knowledge/pending/skills/` のrepo-local Skill proposal |
| triggers / description | `SKILL.md` frontmatterのtrigger-rich description |
| steps / validation gates | Skill本文の段階手順、禁止事項、検査 |
| collision checks | `Hello-world.md`、`knowledge/ops/registry.md`、既存owner docの棚卸し |
| review / accept | pending approve後に正式Skill化 |
| auditability | work card、pending proposal、registry、Hello World、commit message |

流用しないもの:

- `meta_invoke`
- OpenSquilla CLI / runtime
- `kind: meta`
- `composition.steps` のYAML形式そのもの
- MetaSkill catalog向けの商品都合

### 標準skill-creatorから流用するもの

| 標準skill-creator | Biz-compilerでの扱い |
|---|---|
| SKILL.md anatomy | frontmatter `name` / `description` と本文構造を守る |
| description as trigger | 発火条件はbodyではなくdescriptionに入れる |
| progressive disclosure | 長い詳細は `references/`、決定的処理はscriptへ逃がす |
| scripts / references / assets | 繰り返し書くコード、参照資料、出力素材を分ける |
| concrete examples | 実例プロンプトでSkillの使われ方を確認する |
| validation / iteration | 作って終わりにせず、検査と改善を行う |

## 判断順

### 1. Outcome-first intake

最初から「どんなSkillを作るか」を聞かない。まず、ユーザーがやりたいことを聞く。

| 項目 | 聞くこと |
|---|---|
| outcome | 最終的に何ができるようになりたいか |
| current work | 今はどうやっているか、または初回ならどう進めたいか |
| inputs | 何を受け取るか、どの資料やファイルを見るか |
| outputs | 何が残れば成功か |
| decisions | 途中で何を判断しているか |
| exceptions | 迷うケース、失敗しやすいケース、例外 |
| review | 人間確認が必要な箇所 |
| constraints | やってはいけないこと、外部作用、承認が必要なこと |
| standard | 良い結果の条件は何か |

不足していても、既存会話から十分に推測できる場合は止まらず仮説として進める。推測はproposalやSkill本文に `Assumptions` として残す。

### 2. Skill workflow shaping

Skillとして実装できるように、やりたいことを次の観点で整理する。

| 単位 | 見るもの |
|---|---|
| input | 人間入力、ファイル、外部情報、過去ログ |
| read | 追加で読むべきrepo内外の資料 |
| transform | 変換、抽出、要約、分類、生成 |
| decision | 判断、分岐、優先順位、リスク評価 |
| action | ファイル作成、コマンド実行、外部作用 |
| output | 成果物、メモ、proposal、レポート、コード |
| validation | 検査、テスト、レビュー、反例確認 |
| handoff | 次のSkill、orchestrator、人間、templateへの受け渡し |

この段階で、1つの多工程Skillにするか、複数Skill / script / orchestrator に分けるかを仮決めする。

### 3. Skillization planning

整理した観点をもとに、何をSkillにし、何を別資産に逃がすかを決める。

| 判定 | 行き先 |
|---|---|
| agentに読ませる手順、判断、trigger、文脈理解が中心 | repo-local Skill |
| 多工程だが、判断や文脈理解をSkill本文で扱える | 多工程repo-local Skill |
| 手順固定、状態/lock/検査、決まった順序の実行が中心 | orchestrator |
| 環境別の自動発火が中心 | hook adapter |
| deterministicな単発変換だけ | script / tool |
| 恒久ルール、読み込み順、配置規約 | `AGENTS.md` / `knowledge/docs/*` |
| phase-localな業務雛形 | `template/<phase>/` |
| 個別業務の実行資産 | output repo側。compiler repo直下には置かない |
| まだ判断不能 | `knowledge/pending/skills/` proposal |

Skill化してよい候補は次を満たす。

- 自然文で発火させる価値がある。
- 毎回読み直すべき手順、判断、出力契約がある。
- 人間が会話で依頼しそうな単位になっている。
- 標準手順だけでなく、失敗しやすい判断や禁止事項を含む。
- 検証プロンプトまたは確認観点を作れる。

次はSkill単体にしない。

- ただのファイル配置ルール。
- ただの固定コマンド列。
- ただの小さい変換script。
- 一回だけの相談。
- triggerが自然文として立たないもの。

### 4. Inventory / collision check

新規Skillを作る前に必ず読む。

1. `Hello-world.md` の `Repo-local Skills` と `Ops Entrypoints`
2. `knowledge/ops/registry.md`
3. `knowledge/ops/README.md`
4. 近いownerの `SKILL.md` または `README.md`
5. 必要なら `rg` で既存trigger、同名、似た役割を検索する

重複しそうなら、新規作成より既存Skillの拡張を優先する。

### 5. Skill implementation design

Skillを作る時は、標準skill-creatorの作法を使って実装する。

設計するもの:

| 項目 | 内容 |
|---|---|
| name | lowercase / digits / hyphen の短い名前 |
| description | 何をするか、いつ使うか、自然文triggerを含む |
| workflow | intake、read、analyze、write、validateなどの工程 |
| required reads | 必ず読むrepo内ファイルやreference |
| outputs | 作るファイル、返す説明、更新する台帳 |
| guardrails | 禁止事項、外部作用、承認が必要な処理 |
| scripts | 繰り返し書く決定的処理があれば同居script化 |
| references | 長い背景、schema、例、手順は必要時だけ読む形で分離 |
| test prompts | 実際に発火する依頼例、発火してはいけない近接例 |
| validation | 構文、実行、出力、registry/Hello World同期の確認 |

多工程Skillにする場合も、OpenSquillaの `kind: meta` にはしない。Biz-compilerでは、工程を `SKILL.md` の手順、必要なscript、必要なreferencesに落とす。

### 6. Proposal first

迷いがある場合、またはユーザーが明示的に「まず案」と言った場合は、正式Skillを作らずproposalを作る。

```powershell
.\knowledge\ops\skills\skill-creator-gate\new-skill-proposal.ps1 `
  -Name "skill-name" `
  -Intent "何をSkill化したいか" `
  -Triggers "自然文1;自然文2" `
  -Steps "intake;shape;design;validate" `
  -Validation "何を確認するか" `
  -CollisionCheck "既存Skillとの関係" `
  -Risk "残リスク"
```

proposalは `knowledge/pending/skills/` に置く。人間が承認したら `knowledge/ops/skills/knowledge-curation/pending-review.ps1 approve` で `approved/skills` へ移せる。承認後にagentが正式Skillへ反映し、`applied` にする。

### 7. Creation

正式Skillの最小構成はこれ。

```text
knowledge/ops/skills/<skill-name>/
└─ SKILL.md
```

必要な時だけ同居scriptやreferenceを置く。

```text
knowledge/ops/skills/<skill-name>/
├─ SKILL.md
├─ some-command.ps1
└─ references/
```

作成ルール:

- Skill名は lowercase letters / digits / hyphen のみ。
- フォルダ名とfrontmatter `name` は一致させる。
- frontmatterは `name` と `description` だけにする。
- `description` に発火条件を書く。bodyだけに「いつ使うか」を書かない。
- `SKILL.md` は500行未満を目安にする。
- 詳細が長い時は `references/` に逃がし、Skill本文からいつ読むかを明記する。
- repo-local Skillに `README.md` は作らない。owner説明は `SKILL.md` に集約する。
- scriptはそのSkillフォルダ内に置く。`knowledge/ops/` 直下へ `.ps1` を置かない。
- 外部hook、deny rule、グローバル設定は勝手に編集しない。

正式作成する時は次を行う。

1. `knowledge/ops/skills/<skill-name>/` を作る。
2. `SKILL.md` を作る。
3. 必要な `.ps1` や `references/` を同居させる。
4. scriptを追加したらPowerShell AST parseで検査する。
5. `validate-repo-skill.ps1 -SkillName <skill-name>` を実行する。

```powershell
.\knowledge\ops\skills\skill-creator-gate\validate-repo-skill.ps1 -SkillName "skill-name"
```

### 8. Integration

Skillを正式作成・改修したら、同じターンで次を同期する。

- `knowledge/ops/registry.md`
- `knowledge/ops/README.md`
- `Hello-world.md` は手編集せず `hello-world-gate.ps1` で再生成する
- 必要なら `AGENTS.md`
- pending proposalを使った場合は `pending-review.ps1 applied`

`Hello-world.md` に出ないSkillは、存在しないのと同じ扱いになる。作っただけで終わらない。

### 9. Validation

完了前に最低限確認する。

```powershell
.\knowledge\ops\skills\skill-creator-gate\validate-repo-skill.ps1 -SkillName "skill-name"
git diff --check
rg -n "skill-name|trigger語|owner説明" Hello-world.md knowledge/ops AGENTS.md
```

GitHubへ上げる場合は最後に `hello-world-gate.ps1` を通す。

## 禁止事項

- OpenSquillaの `meta_invoke` 実行基盤を作らない。
- `kind: meta` / `composition.steps` をBiz-compiler repo-local Skillのfrontmatterへ持ち込まない。
- Skill実装部分を、registry登録手続きだけに矮小化しない。
- やりたいことを聞かずに、最初からSkill名とファイル構成だけを決めない。
- proposalなしで不確かなSkillを正式配置しない。
- 既存Skillと被るものを名前だけ変えて増やさない。
- triggerが曖昧なまま作らない。
- `description` なし、またはbodyを読まないと発火条件が分からないSkillを作らない。
- `knowledge/ops/` 直下に `.ps1` を置かない。
- repo-local SkillをグローバルSkillとしてインストールしない。
- `output/` 側に作るべき業務固有Skillをcompiler repoへ置かない。

## 完了報告

報告では次だけ短く出す。

```text
skill-creator-gate:
- intake/workflow shaping: やった/省略理由
- skillization plan: Skill / orchestrator / script / docs rule / output repo
- proposal: 作った/作ってない
- created/updated skill: <name>
- collision check: pass / note
- validation: pass / note
- synced: registry, ops README, Hello World
- commit: <hash>  # pushした場合
- residual risk: ...
```
