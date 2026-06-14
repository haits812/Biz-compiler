# Biz-compiler

Biz-compiler は、人間の業務をそのままAIへ丸投げする道具ではない。

業務をphaseごとに読み、IPO / gate / scope / executor / artifact / evidence へ分け、AI、automation、human、approvalへ再配置し、運用しながら検証・再コンパイルするための業務設計OSである。

## まず読む

このREADMEはGitHub上の入口であり、現在状態の正本ではない。

作業者は次を読む。

1. `AGENTS.md` - 作業規約と読み込み順
2. `Hello,world.md` - 現在地。構成とgateの正本
3. `SOUL.md` - agentの対話姿勢
4. `USER.md` - ユーザーの作業モデル
5. `COMPASS.md` - 思考の指向性 / heading
6. `MEMORY.md` - 常時参照メモリ
7. `knowledge/docs/requirements/Biz-compiler_要求定義.md` - 要求定義本体

## リポジトリの役割

このリポジトリは、Biz-compiler本体を作る場所である。

置くもの:

- 業務をコンパイルするためのphase contract、IR、schema、validator
- 同意ビュー、共通テンプレート、要求定義、設計判断
- 開発運用のrepo-local Skillとgate

置かないもの:

- 個別業務ごとの実行Skill、adapter、workflowの溜め込み
- `output/` 直下のサンプル業務フォルダ
- root直下の `docs/`、`pending/`、`journal/`、`scripts/` などの散らばった管理フォルダ

## 現在の基本構成

```text
template/   業務フォルダの原型
output/     業務ごとの成果物置き場。実業務作成まで空
knowledge/  確定知識、pending、journal、repo-local ops
```

`output/` は、業務を作る時だけ `output/Biz-001-業務名/` のように採番して作る。

## Gate

`Hello,world.md` は現在地を返すスモークテストである。

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 check
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 sync
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 publish `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
```

構成を変えたら `sync` と `check` を通す。GitHubへ上げる時は `publish` を使い、日本語commit messageに `理由`、`確認`、`残リスク` を残す。

## Status

このリポジトリは構想・要求定義・運用ルールを固めながら実装している開発作業場である。

最新状態は `Hello,world.md` を見る。
