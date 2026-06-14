# Knowledge Ops

このディレクトリは、Biz-compiler開発運用の知識レイヤーを操作する repo-local Skill を置く場所である。

`knowledge/ops/` 直下に `.ps1` は置かない。実行スクリプトは、それを使うSkillのフォルダに `SKILL.md` と同居させる。

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
