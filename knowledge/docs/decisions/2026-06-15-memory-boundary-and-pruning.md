# 2026-06-15: MEMORY.md を正本重複から切り離す

## Status
Accepted

## Context

`MEMORY.md` に現在構成、決定済み一覧、読み込み順、次アクション候補、各フォルダの役割が集まり、`Hello,world.md`、`AGENTS.md`、`knowledge/docs/decisions/`、`knowledge/docs/meta/README.md` と重複していた。

初期読み込み対象である `MEMORY.md` が正本の劣化コピーになると、トークンを増やすだけでなく、古い状態や古い判断を再注入する危険がある。

## Decision

`MEMORY.md` は、正本化前だが初期読み込みで落とすと困る短い常時注意だけを置く。

`MEMORY.md` に置かないもの:

- 現在構成、root tree、template/output/knowledgeの説明
- 読み込み順、禁止事項、配置ルール、gate運用
- 決定済み一覧、採用理由、却下理由
- メタ土台の状態、依存、次アクション
- 作業候補やphase-local不足物

これらはそれぞれ `Hello,world.md`、`AGENTS.md`、`knowledge/docs/decisions/`、`knowledge/docs/meta/README.md`、`template/phase-local-missing.md` を正本にする。

`knowledge-curation` は、`MEMORY.md` を格上げ先としてだけでなく整理対象として扱う。正本重複を見つけたら、Memoryから削るか正本へ移す。

## Consequences

- 初期読み込みトークンを減らせる。
- `MEMORY.md` が古い現在地を語る事故を避けられる。
- 決定や構成の正本が分散しにくくなる。
- Memory更新時は「足す」より先に「既存正本の重複を消す」判断が必要になる。
