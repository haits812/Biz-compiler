---
name: hello-world-gate
description: Use when Biz-compiler repository work may affect Hello,world.md, current-state self-description, root/template/knowledge/output layout, pending counts, or when publishing repo changes through the Hello World gate.
---

# Hello World Gate

## 範囲

これは Biz-compiler リポジトリ専用の repo-local Skill。グローバルSkillにはしない。

実行体はこのSkillフォルダ内に置く。

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1
```

## 役割

`Hello,world.md` を嘘にしない。

さらに、GitHubへ上げる時もこのgateを通す。Biz-compilerでは `commit-push-gate` という別Skill名を作らない。commit/pushまで含めて `hello-world-gate` が担当する。

## コマンド

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 check
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 sync
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 gate
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 publish `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
```

- `check`: 現在の `Hello,world.md` が実際の構成と一致するか検査する。
- `sync`: 現在の構成から `Hello,world.md` を再生成する。
- `gate`: `check` の別名。
- `publish`: `sync`、`check`、`git add -A`、日本語commit、`git push`、post-checkを順番に実行する。

## いつ使うか

次に触る、または影響しそうな時は使う。

- ルート構成、ルートファイル説明
- 読み込み順、first-read files
- `Hello,world.md`
- `AGENTS.md`、`SOUL.md`、`USER.md`、`COMPASS.md`、`MEMORY.md`
- `template/` のphase構成、Hello Worldに載るtemplate asset
- `knowledge/` の構成、pending/approved件数、Hello Worldに載るops asset
- `output/` の業務IDルール、実際の `output/` 配下ディレクトリ
- このSkill自身、または `hello-world-gate.ps1`
- GitHubへ変更をpushする時

## 必須の流れ

通常作業:

1. リポジトリルート `D:\local\Biz-compiler` で作業する。
2. 現在地を信じる必要があるなら先に `check` する。
3. 変更する。
4. `Hello,world.md` に載る状態を変えたなら同じターンで `sync` する。
5. 完了前に必ず `check` を通す。

GitHubへ上げる時:

1. 変更を終える。
2. `publish` を使う。
3. commit messageは日本語で、`理由`、`確認`、`残リスク` を含める。
4. `publish` が失敗したら完了扱いにしない。

## publish のcommit message

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

## syncするタイミング

`sync` は変更後に実行する。先に実行しても意味がない。

同じターンで `sync` する例:

- root、`template/`、`knowledge/`、`output/` 配下の追加・移動・削除
- first-read filesの意味や説明の変更
- pending/approved状態の変更
- `COMPASS.md` の役割説明やread routingの変更
- `hello-world-gate.ps1` の生成ロジック変更

説明だけのread-only作業なら通常は `check` のみ。`check` がstaleで落ちた時だけ、構造違反でないことを確認して `sync` する。

## gateが止めるもの

`check` は次を検出したら失敗する。

- 必須ルートディレクトリ/ファイルの欠落
- 禁止ルートディレクトリの存在
- `template/` の必須phase欠落
- 同意ビューassetの欠落
- `output/` のプレースホルダ、または命名違反の業務フォルダ
- 実際の現在状態と `Hello,world.md` の差分

## やらないこと

- Biz-compiler側に `commit-push-gate` Skillを作らない。
- `knowledge/ops/` 直下に `.ps1` を置かない。
- `publish` 前の日記ファイルを必須にしない。必要な記録は日本語commit messageへ集約する。
- Codex Desktopの `::git-*` directive は出さない。

## 報告

完了報告では、`sync` 実行有無、`check` 結果、pushした場合はcommit hashとbranch、残リスクだけを短く書く。
