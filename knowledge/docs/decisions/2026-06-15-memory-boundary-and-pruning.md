# 2026-06-15: MEMORY.md を普段メモ兼整理対象にする

## Status
Accepted

## Context

`MEMORY.md` に現在構成、決定済み一覧、読み込み順、次アクション候補、各フォルダの役割が集まり、`Hello-world.md`、`AGENTS.md`、`knowledge/docs/decisions/`、`knowledge/docs/meta/README.md` と重複していた。

一方で、会話のたびに `journal` / `pending` / `decision` / `USER` / `AGENTS` / `MEMORY` を厳密に振り分ける運用は重い。分類判断が重いと、そもそもメモが残らない。

## Decision

`MEMORY.md` は、普段の会話で出た「覚えといて」をまず置くメモとして残す。

ただし、`MEMORY.md` は次の正本にはしない。

- 現在構成、root tree、template/output/knowledgeの説明
- 読み込み順、禁止事項、配置ルール、gate運用
- 決定済み一覧、採用理由、却下理由
- メタ土台の状態、依存、次アクション
- 長い会話履歴や作業ログ

これらはそれぞれ `Hello-world.md`、`AGENTS.md`、`knowledge/docs/decisions/`、`knowledge/docs/meta/README.md`、`knowledge/journal/` を正本にする。

`knowledge-curation` は、`MEMORY.md` を格上げ先としてだけでなく整理対象として扱う。Memoryに置いた普段メモは、定期的に `USER.md`、`SOUL.md`、`COMPASS.md`、`AGENTS.md`、`knowledge/docs/decisions/`、`knowledge/pending/`、`knowledge/journal/`、各 `knowledge/docs/*`、または廃棄へ振り分ける。

会話履歴そのものを残す場合は `knowledge/journal/` に置く。journalは履歴置き場であり、正式なルールや決定ではない。

## Consequences

- 普段の「覚えといて」を入れる場所が `MEMORY.md` に一本化される。
- 新しい `memory-inbox.md` のような中間ファイルを増やさずに済む。
- `MEMORY.md` が肥大化するリスクは残るため、`knowledge-curation` による定期掃除を運用に含める。
- Memory更新時は「足す」だけでなく「既存正本へ移す/削る」判断が必要になる。
