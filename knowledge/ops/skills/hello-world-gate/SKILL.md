---
name: hello-world-gate
description: Biz-compilerで、ハロワやっといて/ハロワ見て/ハロワ更新しといて/githubあげといて/GitHub上げて/pushして等の依頼が出た時に使う。Hello,world.md更新、検査、日本語commit、GitHub pushまでを単一gateで行う。
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

外から叩くコマンドは1つだけ。`hello-world-gate.ps1` は、ハロワ更新、検査、必要なら日本語commit、GitHub push、post-checkまでを一気通貫で行う。

変更がなければ、更新・検査だけして「commit/push不要」として正常終了する。

## 発話トリガー

次のような言い方が出たら、このSkillを使う。

| ユーザーの言い方 | 解釈 | 実行 |
|---|---|---|
| `ハロワやっといて` | ハロワ更新、検査、必要ならGitHubへ反映 | `hello-world-gate.ps1` |
| `ハロワ見て` / `ハロワ確認して` | ハロワ更新、検査、必要ならGitHubへ反映 | `hello-world-gate.ps1` |
| `ハロワ更新しといて` | ハロワ更新、検査、必要ならGitHubへ反映 | `hello-world-gate.ps1` |
| `githubあげといて` / `GitHub上げて` | ハロワ更新・検査込みでGitHubへ反映 | `hello-world-gate.ps1` |
| `pushして` / `pushしといて` | ハロワ更新・検査込みでGitHubへ反映 | `hello-world-gate.ps1` |

GitHubへ上げる依頼は、必ずハロワ更新込みとして扱う。人間に `ハロワ更新してからgithubあげて` と二段で言わせない。

`githubあげといて` と言われた時に、別の `commit-push-gate` を探したり作ったりしない。Biz-compilerでは `hello-world-gate.ps1` が唯一の出口である。

## コマンド

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
```

やること:

1. 現在状態から `Hello,world.md` を再生成する。
2. `Hello,world.md` が現在状態と一致するか検査する。
3. 変更がなければ正常終了する。
4. 変更があれば `git add -A` する。
5. 日本語commit messageでcommitする。
6. `git push` する。
7. post-checkする。

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

- ルート構成、ルートファイル説明
- 読み込み順、first-read files
- `Hello,world.md`
- `AGENTS.md`、`SOUL.md`、`USER.md`、`COMPASS.md`、`MEMORY.md`
- `template/` のphase構成、Hello Worldに載るtemplate asset
- `knowledge/` の構成、pending/approved件数、Hello Worldに載るops asset
- `output/` の業務IDルール、実際の `output/` 配下ディレクトリ
- このSkill自身、または `hello-world-gate.ps1`
- GitHubへ変更をpushする時

## gateが止めるもの

このgateは次を検出したら失敗する。

- 必須ルートディレクトリ/ファイルの欠落
- 禁止ルートディレクトリの存在
- `template/` の必須phase欠落
- 同意ビューassetの欠落
- `output/` のプレースホルダ、または命名違反の業務フォルダ
- 再生成後も `Hello,world.md` が現在状態と一致しない状態
- 変更があるのに日本語commit message情報が足りない状態
- push失敗

## やらないこと

- 外向けに `check`、`sync`、`publish` の複数コマンドを分けない。
- Biz-compiler側に `commit-push-gate` Skillを作らない。
- `knowledge/ops/` 直下に `.ps1` を置かない。
- GitHub反映前の日記ファイルを必須にしない。必要な記録は日本語commit messageへ集約する。
- Codex Desktopの `::git-*` directive は出さない。

## 報告

完了報告では、ハロワ更新・検査結果、commit/pushした場合はcommit hashとbranch、残リスクだけを短く書く。

