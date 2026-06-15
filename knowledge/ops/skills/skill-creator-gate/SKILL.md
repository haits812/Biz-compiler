---
name: skill-creator-gate
description: Use when Biz-compiler repoで新しいrepo-local Skillを作る、既存Skillを改修する、作業をSkill化する、スキル作って/Skill作って/この流れをSkillにして/creator gate/skill-creator-gate/meta-skill-creator流用と言われた時。OpenSquillaのmeta-skill-creator作法を、repo-local Skillのproposal、衝突確認、trigger設計、作成、登録、検査へ移植する。
---

# Skill Creator Gate

## 範囲

これは Biz-compiler リポジトリ専用の repo-local Skill。グローバルSkillにはしない。

目的は、repo-local Skillを安全に増やすことである。OpenSquillaの `meta-skill-creator` の作法を参考にするが、OpenSquilla runtime、`meta_invoke`、`kind: meta`、`composition.steps` は導入しない。

このSkillは creator でも gate でもある。Skill案を調査し、必要なら `knowledge/pending/skills/` にproposalを作り、承認後は `knowledge/ops/skills/<skill-name>/` へ正式Skillを作り、registry / ops README / Hello World まで同期する。

## 発話トリガー

次のような依頼で使う。

- `スキル作って`
- `Skill作って`
- `この流れをSkillにして`
- `repo-local Skillにして`
- `skill-creator-gate`
- `meta-skill-creator流用で作って`
- `OpenSquillaのmeta-skill-creatorに則ってSkill作って`
- `この作業、毎回やるからSkill化して`
- `既存Skillと被らないように作って`
- `Skillのdescription直して`
- `Skillの発火条件を整理して`

引用された会話ログ、古いprompt、Web UI dump、Skill一覧に上記語が含まれているだけなら発火しない。ユーザーが「作る」「Skill化する」「改修する」と現在依頼している時だけ使う。

## OpenSquillaから流用する作法

| OpenSquilla meta-skill-creator | Biz-compiler skill-creator-gate |
|---|---|
| repeated multi-skill collaboration pattern | 繰り返し出る作業・会話・運用パターン |
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

## 判断順

### 1. Intent intake

まず、Skill化したい作業を次の型で取る。

| 項目 | 聞くこと |
|---|---|
| outcome | 何ができるSkillにしたいか |
| context | どのrepo、どのフォルダ、どの資産を扱うか |
| standard | 良い結果の条件は何か |
| triggers | ユーザーが自然に何と言ったら発火するか |
| expected output | Skill実行後に何が残るべきか |
| constraints | やってはいけないこと、外部作用、承認が必要なこと |

不足していても、既存会話から十分に推測できる場合は止まらず仮説として進める。推測はproposalに `Assumptions` として残す。

### 2. Pattern fit

Skill化してよい候補は次を満たす。

- 繰り返し発生する。
- 手順、読むもの、出力、検査がある程度安定している。
- descriptionで自然言語発火できる。
- 既存Skill / orchestrator / hook / docsルールだけでは足りない。
- review、audit、再利用、失敗防止の価値がある。

次はSkill化しない。

- 1回だけの質問。
- ただのファイル配置ルール。これは `AGENTS.md` や `knowledge/docs/*` に置く。
- 決まった順序の実行だけが必要な処理。これは orchestrator 候補。
- 外部環境の自動発火だけが必要な処理。これは hook adapter 候補。
- deterministicな単発変換だけ。これは script / tool 候補。

### 3. Inventory / collision check

新規Skillを作る前に必ず読む。

1. `Hello-world.md` の `Repo-local Skills` と `Ops Entrypoints`
2. `knowledge/ops/registry.md`
3. `knowledge/ops/README.md`
4. 近いownerの `SKILL.md` または `README.md`
5. 必要なら `rg` で既存trigger、同名、似た役割を検索する

重複しそうなら、新規作成より既存Skillの拡張を優先する。

### 4. Classification

| 判定 | 行き先 |
|---|---|
| agentに読ませる手順、判断、triggerが中心 | repo-local Skill |
| 手順固定、複数ステップ、状態/lock/検査が中心 | orchestrator |
| Codex / Claude Code など環境別の自動発火 | hook adapter |
| 恒久ルール、読み込み順、配置規約 | `AGENTS.md` / `knowledge/docs/*` |
| deterministicな処理だけ | owner配下の `.ps1` / 将来 `template/_shared/` |
| 個別業務の実行資産 | output repo側。compiler repo直下には置かない |
| まだ判断不能 | `knowledge/pending/skills/` proposal |

### 5. Proposal first

迷いがある場合、またはユーザーが明示的に「まず案」と言った場合は、正式Skillを作らずproposalを作る。

```powershell
.\knowledge\ops\skills\skill-creator-gate\new-skill-proposal.ps1 `
  -Name "skill-name" `
  -Intent "何をSkill化したいか" `
  -Triggers "自然文1;自然文2" `
  -Steps "intake;inventory;design;validate" `
  -Validation "何を確認するか" `
  -CollisionCheck "既存Skillとの関係" `
  -Risk "残リスク"
```

proposalは `knowledge/pending/skills/` に置く。人間が承認したら `knowledge/ops/skills/knowledge-curation/pending-review.ps1 approve` で `approved/skills` へ移せる。承認後にagentが正式Skillへ反映し、`applied` にする。

### 6. Skill design

正式Skillの最小構成はこれ。

```text
knowledge/ops/skills/<skill-name>/
└─ SKILL.md
```

必要な時だけ同居scriptを置く。

```text
knowledge/ops/skills/<skill-name>/
├─ SKILL.md
├─ some-command.ps1
└─ references/  # 必要になった時だけ
```

設計ルール:

- Skill名は lowercase letters / digits / hyphen のみ。
- フォルダ名とfrontmatter `name` は一致させる。
- frontmatterは `name` と `description` だけにする。
- `description` に発火条件を書く。bodyだけに「いつ使うか」を書かない。
- `SKILL.md` は500行未満を目安にする。
- 詳細が長い時は `references/` に逃がし、SKILL本文からいつ読むかを明記する。
- repo-local Skillに `README.md` は作らない。owner説明は `SKILL.md` に集約する。
- scriptはそのSkillフォルダ内に置く。`knowledge/ops/` 直下へ `.ps1` を置かない。
- 外部hook、deny rule、グローバル設定は勝手に編集しない。

### 7. Creation

正式作成する時は次を行う。

1. `knowledge/ops/skills/<skill-name>/` を作る。
2. `SKILL.md` を作る。
3. 必要な `.ps1` を同居させる。
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
- proposal: 作った/作ってない
- created/updated skill: <name>
- collision check: pass / note
- validation: pass / note
- synced: registry, ops README, Hello World
- commit: <hash>  # pushした場合
- residual risk: ...
```