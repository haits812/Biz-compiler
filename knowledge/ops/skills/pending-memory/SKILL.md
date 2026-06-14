---
name: pending-memory
description: Use when Biz-compiler repository work needs to create, review, approve, reject, or mark applied pending Memory/Compass/Decision update candidates.
---

# Pending Memory

## 範囲

これは Biz-compiler リポジトリ専用の repo-local Skill。グローバルSkillにはしない。

実行体はこのSkillフォルダ内に置く。

## 役割

未確定のMemory、Compass、Decision更新候補を `knowledge/pending/` で扱う。

正式ファイルへいきなり直書きせず、迷うものはpendingへ置く。承認、却下、適用済みの移動もこのSkillのコマンドで行う。

## コマンド

即時メモ候補を作る:

```powershell
.\knowledge\ops\skills\pending-memory\new-pending-memory.ps1 `
  -Title "即時メモのタイトル" `
  -Evidence "どの発話・作業から出たか" `
  -ProposedChange "残したい内容"
```

pendingを確認・移動する:

```powershell
.\knowledge\ops\skills\pending-memory\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\pending-memory\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "正式ファイルへ反映済み"
```

## 注意

- `approve` は正式反映ではない。`knowledge/pending/approved/` へ移すだけ。
- 正式反映では、対象ファイルの役割、重複、語彙の区別を読んでから編集する。
- 反映後に `applied` で `knowledge/journal/pending-applied/` へ移す。
- 却下は `reject` で `knowledge/journal/pending-rejected/` へ移す。
