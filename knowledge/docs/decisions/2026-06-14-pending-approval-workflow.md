# pending approval workflow を採用する

- Status: Accepted
- Date: 2026-06-14

## Context

会話が長くなると、重要な訂正や決定候補を失うことがある。一方で、agentが推測した内容を即座に `MEMORY.md` や `COMPASS.md` へ直書きすると、未確認の脚色が正式文脈に混ざる。

Hermesのmemory/skill write approvalの発想を参考に、このリポジトリでもpending候補を人間が確認してから正式反映する流れを持つ。

## Decision

`knowledge/pending/` を未承認候補の置き場、`knowledge/pending/approved/` を人間が正式反映を認めた候補の置き場、`knowledge/journal/pending-applied/` と `knowledge/journal/pending-rejected/` を監査ログ置き場とする。

`pending-review.ps1` を追加し、次の操作を提供する。

- `list`: knowledge/pending/approved候補を一覧する。
- `show`: 候補の内容を見る。
- `approve`: 未承認候補を `knowledge/pending/approved/` へ移す。
- `reject`: 候補を `knowledge/journal/pending-rejected/` へ移す。
- `applied`: approved候補を正式ファイルへ反映後、`knowledge/journal/pending-applied/` へ移す。

`approve` は正式ファイルを自動編集しない。正式反映は、対象ファイルの役割と既存記述を読んでから文脈込みで行う。

## Consequences

- 重要な候補を即時に失わず、かつ未確認の推測を正式文脈へ混ぜにくくなる。
- 承認済みと反映済みを分けるため、作業者は `knowledge/pending/approved/` の滞留を確認する必要がある。
- 自動追記ではないため、反映時には人間またはagentの判断が必要になる。

