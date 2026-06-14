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

このコマンドは、ハロワ更新、検査、`git add -A`、日本語commit、`git push`、post-checkを順番に実行する。変更がなければcommit/push不要として正常終了する。

## skills/pending-memory/

未承認のMemory/Compass/Decision更新候補を作成・確認・承認・却下・適用済みにする。

```powershell
.\knowledge\ops\skills\pending-memory\new-pending-memory.ps1 -Title "即時メモのタイトル" -Evidence "どの発話・作業から出たか" -ProposedChange "残したい内容"

.\knowledge\ops\skills\pending-memory\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\pending-memory\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "MEMORY.mdへ反映済み"
```

`approve` は候補を `knowledge/pending/approved/` へ移すだけで、正式ファイルを自動編集しない。正式反映では、対象ファイルの役割と既存記述を読んでから文脈込みで編集する。

