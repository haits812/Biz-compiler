# 2026-06-14: 開発運用用の記憶レイヤーを分離する

## Status
Accepted

Refined by: `2026-06-15-memory-boundary-and-pruning.md`

## Context

Biz-compilerをこれから会話しながら実装していくにあたり、重要な判断や学びを毎回失わない仕組みが必要になった。ただし、Biz-compiler本体の業務メモリと、このリポジトリを作るための開発運用メモリは別物である。

Hermes Agentの設計では、`SOUL.md`、project context、`MEMORY.md` / `USER.md`、session search、skillsを分けている。この分離は本リポジトリにも有効である。

## Decision

開発運用用の記憶レイヤーを次のように分ける。

- `AGENTS.md`: 作業者/agent向けのリポジトリ規約。
- `COMPASS.md`: Biz-compiler開発における判断prior。
- `MEMORY.md`: 正本化前の短い常時注意。現在構成や決定履歴は置かない。
- `knowledge/docs/decisions/`: 決定記録。
- `knowledge/journal/`: セッションログや未整理の検討過程。
- `knowledge/pending/`: 未承認の更新提案。

`MEMORY.md` は小さく保ち、正本化できる内容は `Hello,world.md`、`AGENTS.md`、`knowledge/docs/decisions/`、`knowledge/docs/meta/README.md`、`knowledge/journal/` へ移す。

## Consequences

- 次回以降のagentは `MEMORY.md` で、正本化前の短い常時注意だけを確認できる。現在構成は `Hello,world.md`、決定済み事項は `knowledge/docs/decisions/` を正本にする。
- Compassが肥大化しにくくなる。
- 未承認の自動更新を `knowledge/pending/` に隔離できる。
- 手動で更新しないと陳腐化するため、作業完了時に `MEMORY.md` の重複削除と `knowledge/docs/decisions/` の更新要否を確認する必要がある。
