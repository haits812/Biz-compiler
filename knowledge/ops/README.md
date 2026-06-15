# Knowledge Ops

このディレクトリは、Biz-compiler開発運用の ops 資産を置く場所である。

対象は repo-local Skill、hook adapter、orchestrator、command、tool の棚卸しと実行入口である。正本台帳は `knowledge/ops/registry.md` に置く。

`knowledge/ops/` 直下に `.ps1` は置かない。実行スクリプトは、それを所有する Skill または orchestrator のフォルダに同居させる。

## Registry

新しい Skill / hook / orchestrator / command / tool を作る前に、まず次を確認する。

```powershell
Get-Content -Raw .\knowledge\ops\registry.md
```

似た役割がある場合は、別資産を増やさず既存入口へ統合する。

## Sync Rule

次を追加・改名・削除した場合は、このREADMEと `knowledge/ops/registry.md` を同じターンで更新する。

- repo-local Skill
- hook adapter
- orchestrator
- command / script
- tool

最後に `hello-world-gate.ps1` を通し、`Hello,world.md` のops entrypointとKnown knowledge ops assetsを再生成する。

## skills/hello-world-gate/

`Hello,world.md` を現在状態に同期・検査し、GitHubへ上げる時もこのgateでcommit/pushする。

外から叩くコマンドは1つだけ。

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
```

このコマンドは、ハロワ更新、検査、`git add -A`、日本語commit、`git push`、post-checkを順番に実行する。GitHub/push依頼では、先に `git status --short --branch` で対象有無を見る。対象がなければgate本体を実行せず `対象ないよ。main と origin/main は同期済み。` と返す。

## skills/knowledge-curation/

`MEMORY.md`、`knowledge/pending/`、`knowledge/journal/`、`knowledge/docs/decisions/` などの知識候補を整理するSkillである。

未承認候補の作成・確認・承認・却下・適用済み化もここで扱う。`pending` は状態名であり、別Skill名にはしない。

```powershell
.\knowledge\ops\skills\knowledge-curation\new-pending-update.ps1 -Title "即時メモのタイトル" -Target "MEMORY.md" -Evidence "どの発話・作業から出たか" -ProposedChange "残したい内容"

.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "MEMORY.mdへ反映済み"
```

`approve` は候補を `knowledge/pending/approved/` へ移すだけで、正式ファイルを自動編集しない。正式反映では、対象ファイルの役割と既存記述を読んでから文脈込みで編集する。

## orchestrators/impact-orchestrator/

MergeGateの作法を参考に、編集前に作業の目的、影響、読むもの、既存ops資産、実行者、完了gateを1枚に切るorchestratorである。

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

`-NoWrite` を付けると、work cardを作らず内容だけ確認できる。

## hooks/

hookは環境別adapterであり、正本ではない。Codex / Claude Code などへ移植する場合も、hook本体は repo-local orchestrator / Skill を呼ぶだけにする。

現時点では実hook設定を自動編集しない。
