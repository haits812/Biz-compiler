# Pending Updates

このディレクトリは、AIまたは作業者が提案したが、まだ正式反映していない更新を置く場所である。

## サブディレクトリ

- `memory/`: `MEMORY.md` へ反映する候補。
- `compass/`: `COMPASS.md` へ反映する候補。
- `decisions/`: `knowledge/knowledge/docs/decisions/` へ昇格する候補。
- `approved/`: 人間が正式反映を認めたが、まだ対象ファイルへ反映済みとは限らない候補。

## ルール

- 会話終盤のレビューに依存しない。重要な学びや決定候補が出たら、その場でpendingに置く。
- 背景レビューや作業後レビューが何かを学んでも、直接 `COMPASS.md` や `MEMORY.md` を肥大化させない。
- 迷うものはまず `knowledge/pending/` に置く。
- 人間が確認してから、正式なファイルへ移す。
- 承認された候補は `knowledge/pending/approved/` へ移す。正式ファイルへ反映したら `knowledge/journal/pending-applied/` へ移す。
- 却下したものは `knowledge/journal/pending-rejected/` に残す。
- 機械的に `Proposed Change` を本文へ追記しない。反映時は対象ファイルの役割、重複、語彙の区別を確認する。

## 置くべきもの

- まだ確定していないが、次回以降に効きそうな方針。
- `MEMORY.md` に入れるには長い、または確信度が足りない事実。
- `COMPASS.md` に入れるか検討したい判断prior。
- ADR化するほど重要そうだが、背景整理がまだ足りない決定。

## 推奨フォーマット

```md
# <提案タイトル>

## Target
MEMORY.md / COMPASS.md / knowledge/docs/decisions

## Proposed Change
反映したい内容。

## Evidence
どの会話・作業・失敗・決定から出たか。

## Risk
誤って反映した場合の悪影響。
```

## レビュー補助

```powershell
.\knowledge\ops\skills\pending-memory\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\pending-memory\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\skills\pending-memory\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "正式ファイルへ反映済み"
```




