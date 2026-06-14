# Knowledge Ops

このディレクトリは、Biz-compiler開発運用の知識レイヤーを操作する管理コマンドを置く場所である。業務実行時に `output/Biz-001-業務名/` へコピーされるスクリプトではない。

## skills/

Biz-compilerリポジトリ内だけで効くrepo-local運用Skillを置く。グローバルSkill置き場ではない。

- `skills/hello-world-gate/SKILL.md`: `Hello,world.md` をいつ `sync/check` するかを定義する。
## hello-world-gate.ps1

`Hello,world.md` を現在のルート構成・template構成・output状態・pending件数から同期し、staleや禁止構成を検出する。

```powershell
.\knowledge\ops\hello-world-gate.ps1 sync
.\knowledge\ops\hello-world-gate.ps1 check
.\knowledge\ops\hello-world-gate.ps1 gate
```

`sync` は `Hello,world.md` を再生成する。`check` / `gate` は、現在状態と `Hello,world.md` の差分、禁止ルートフォルダ、`template/` phase欠落、`output/` のプレースホルダ/命名違反を検出して失敗する。
## new-pending-memory.ps1

即時メモ候補を `knowledge/pending/memory/` に作る。

```powershell
.\knowledge\ops\new-pending-memory.ps1 -Title "即時メモのタイトル" -Evidence "どの発話・作業から出たか" -ProposedChange "残したい内容"
```

正式採用する前に、人間が内容を確認する。

## pending-review.ps1

`knowledge/pending/` の候補を確認し、承認・却下・適用済みへ進める。

```powershell
.\knowledge\ops\pending-review.ps1 list -Stage all
.\knowledge\ops\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "MEMORY.mdへ反映済み"
```

`approve` は候補を `knowledge/pending/approved/` へ移すだけで、正式ファイルを自動編集しない。正式反映では、対象ファイルの役割と既存記述を読んでから文脈込みで編集する。






