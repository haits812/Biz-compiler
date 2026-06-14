# MEMORY.md

> このファイルは、初期読み込みで落とすと困る短い注意だけを置く常時メモリである。正本の索引、現在構成の一覧、決定履歴、次アクション台帳ではない。

## 役割境界

- 現在構成、root tree、template、output、knowledge、pending件数は `Hello,world.md` が正本。
- 読み込み順、禁止事項、配置ルール、gate運用は `AGENTS.md` が正本。
- 判断の背景、採用理由、却下理由は `knowledge/docs/decisions/` が正本。
- メタ土台の状態、併読、依存、次アクションは `knowledge/docs/meta/README.md` が正本。
- 作業種別ごとの追加読み込みは `knowledge/docs/README.md` が正本。
- 用語境界は `knowledge/docs/lexicon.md` が正本。

## 常時注意

- `MEMORY.md` に正本の要約を増やさない。ここへ入れる前に、既存正本へ入れるべきか、Decisionへ残すべきか、pendingへ置くべきかを先に判断する。
- 正本化した内容は、同じターンでここから削る。
- ここに残すのは、正本化するほどではないが次回の初動で落とすと困る短い注意だけ。
- 現時点で、他の初期読み込み正本に追加して常時保持すべきプロジェクト状態はない。

## 一時メモの逃がし先

- 迷う候補: `knowledge/pending/`
- 背景理由: `knowledge/docs/decisions/`
- 作業過程: `knowledge/journal/`
- メタ土台の状態や次候補: `knowledge/docs/meta/README.md`
- phase-localな不足物: `template/phase-local-missing.md` または該当 `template/<phase>/`
