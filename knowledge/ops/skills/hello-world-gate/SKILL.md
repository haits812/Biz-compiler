---
name: hello-world-gate
description: Use when Biz-compilerでハロワやっといて/ハロワ見て/ハロワ更新しといて/githubあげといて/GitHub上げて/pushして等の依頼が出た時。
---

# Hello World Gate

## 範囲

これは Biz-compiler リポジトリ専用の repo-local Skill。グローバルSkillにはしない。

実行体はこのSkillフォルダ内に置く。

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1
```

## 役割

`Hello-world.md` を嘘にしない。GitHubへ上げる前に `code-impact` の生成graphも最新化する。

外から叩くgateコマンドは1つだけ。`hello-world-gate.ps1` は、ハロワ更新、検査、必要なら日本語commit、GitHub push、post-checkまでを一気通貫で行う。

ただし、会話で `githubあげといて` / `pushして` と言われた場合は、先に対象有無を見る。上げる対象がなければgate本体を実行せず、「対象ないよ」と返す。

## 読み込み順の扱い

first-read files は `AGENTS.md`、`Hello-world.md`、`SOUL.md`、`USER.md`、`COMPASS.md`、`knowledge/docs/lexicon.md`、`MEMORY.md` までとする。

`knowledge/docs/requirements/` は初期読み込みに含めない。要求全体確認、要求変更、要求定義との照合が必要な時だけ追加で読む。

ops資産は、`Hello-world.md` では存在と入口だけを見る。実際に使う・変更する時は `knowledge/ops/registry.md` を読んだうえで、対象ownerの `README.md` / `SKILL.md` まで読む。`impact-orchestrator` を使う時は `knowledge/ops/orchestrators/impact-orchestrator/README.md` がowner説明である。

## 発話トリガー

次のような言い方が出たら、このSkillを使う。

| ユーザーの言い方 | 解釈 | 実行 |
|---|---|---|
| `ハロワやっといて` | ハロワ更新、検査、必要ならGitHubへ反映 | `hello-world-gate.ps1` |
| `ハロワ見て` / `ハロワ確認して` | ハロワ更新、検査、必要ならGitHubへ反映 | `hello-world-gate.ps1` |
| `ハロワ更新しといて` | ハロワ更新、検査、必要ならGitHubへ反映 | `hello-world-gate.ps1` |
| `githubあげといて` / `GitHub上げて` | まず対象確認。対象があればハロワ更新・検査込みでGitHubへ反映 | `git status --short --branch` → 必要なら `hello-world-gate.ps1` |
| `pushして` / `pushしといて` | まず対象確認。対象があればハロワ更新・検査込みでGitHubへ反映 | `git status --short --branch` → 必要なら `hello-world-gate.ps1` |

GitHubへ上げる依頼は、対象がある場合だけハロワ更新込みとして扱う。人間に `ハロワ更新してからgithubあげて` と二段で言わせない。

`githubあげといて` と言われた時に、別の `commit-push-gate` を探したり作ったりしない。Biz-compilerでは `hello-world-gate.ps1` が唯一の出口である。

## GitHub/push依頼の事前判定

`githubあげといて` / `GitHub上げて` / `pushして` / `pushしといて` の時は、まず次だけを見る。

```powershell
git status --short --branch
```

判定:

- ローカル差分がなく、未push commitもなく、`main...origin/main` が同期済みなら、`hello-world-gate.ps1` を実行しない。`対象ないよ。main と origin/main は同期済み。` と返す。
- ローカル差分、staged差分、untracked file、または `[ahead N]` があるなら、`hello-world-gate.ps1` を実行する。
- `[behind N]` や diverged がある場合は、push対象ではなく同期問題として報告する。ローカル差分がある状態でbehind/divergedなら、勝手にpushへ進まない。

対象なしは正常系である。対象なしの時に、日付更新や確認目的だけで `Hello-world.md` を動かさない。

## コマンド

対象がある時だけ実行する。

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
```

やること:

1. 現在状態から `Hello-world.md` を再生成する。
2. `Hello-world.md` が現在状態と一致するか検査する。
3. `code-impact rebuild` を実行し、メタ土台の関連ファイルgraphを最新化する。
4. ローカル差分がなければ、未push commitの有無を見る。
5. 未push commitがあればpushする。
6. ローカル差分があれば `git add -A` する。
7. 日本語commit messageでcommitする。
8. `git push` する。
9. post-checkする。

## commit message

変更がある場合は、commit message用の引数を日本語で渡す。

必須形:

```text
<種別>: <何を変えたか>

理由:
- なぜ必要だったか

確認:
- 何を確認したか
- hello-world-gate: pass

残リスク:
- 未確認のこと
- 残っている注意点
```

英語の技術語、ファイルパス、`git`、`IR`、`schema` などは混ざってよい。ただし文章としては日本語で読む前提にする。

## いつ発火するか

次に触る、または影響しそうな時は発火する。

- ルート構成、ルートファイル説明、setup.mdの環境前提
- 読み込み順、first-read files
- `Hello-world.md`
- `AGENTS.md`、`setup.md`、`SOUL.md`、`USER.md`、`COMPASS.md`、`knowledge/docs/lexicon.md`、`MEMORY.md`
- `template/` のphase構成、Hello Worldに載るtemplate asset
- `knowledge/` の構成、pending/approved件数、Hello Worldに載るops asset
- repo-local Skillの追加・改名・削除、`SKILL.md` frontmatter、同居 `.ps1`、`knowledge/ops/README.md`
- `knowledge/ops/registry.md`、hooks、orchestrators、repo-local commands/tools、work locks、knowledge search indexルールの追加・変更
- ops資産のowner説明ファイル、またはその読み導線の追加・変更
- `output/` の業務IDルール、実際の `output/` 配下ディレクトリ
- このSkill自身、または `hello-world-gate.ps1`
- GitHubへ変更をpushする時。ただし対象なしなら実行しない

## gateが止めるもの

このgateは次を検出したら失敗する。

- 必須ルートディレクトリ/ファイルの欠落
- 禁止ルートディレクトリの存在
- `template/` の必須phase欠落
- 同意ビューassetの欠落
- `output/` のプレースホルダ、または命名違反の業務フォルダ
- 再生成後も `Hello-world.md` が現在状態と一致しない状態
- 変更があるのに日本語commit message情報が足りない状態
- code-impact rebuild 失敗
- push失敗

## やらないこと

- 外向けに `check`、`sync`、`publish` の複数コマンドを分けない。
- GitHub/push依頼で対象がない時に、確認目的だけでgate本体を実行しない。
- Biz-compiler側に `commit-push-gate` Skillを作らない。
- `knowledge/ops/` 直下に `.ps1` を置かない。Skill実行体は `knowledge/ops/skills/<skill-name>/`、hook adapterは `knowledge/ops/hooks/`、orchestrator実行体は `knowledge/ops/orchestrators/<orchestrator-name>/` に同居させる。
- `knowledge/.index/*.sqlite` と `__pycache__/`、`*.pyc` をcommitしない。Markdown正本やPython sourceから再生成する生成物として扱う。`code-impact.sqlite` は gate 中に更新されても生成物としてcommitしない。
- hook一覧を `setup.md` に複製しない。setupは `knowledge/ops/registry.md` と `knowledge/ops/hooks/README.md` へ誘導する。
- GitHub反映前の日記ファイルを必須にしない。必要な記録は日本語commit messageへ集約する。
- Codex Desktopの `::git-*` directive は出さない。

## 報告

対象なしなら `対象ないよ。main と origin/main は同期済み。` と短く返す。

commit/pushした場合は、ハロワ更新・検査結果、commit hashとbranch、残リスクだけを短く書く。
