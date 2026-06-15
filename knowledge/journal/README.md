# Journal

このディレクトリは、会話履歴、作業セッションのログ、試行錯誤、長い検討過程を置く場所である。

## 役割

`journal` は、履歴そのものを後から追うための置き場である。

- 会話の流れを丸ごと残したい時に使う。
- 作業ログ、試行錯誤、比較検討、長い未整理メモを置く。
- ここに置いた時点では、正式なルール、決定、Memoryではない。
- 普段の短い「覚えといて」メモは、まず `MEMORY.md` に置いてよい。
- 後から `knowledge-curation` で、Decision、pending、AGENTS、COMPASS、USER、MEMORY、または廃棄へ振り分ける。

## 使い方

- 1セッションまたは1テーマごとに `YYYY-MM-DD-<topic>.md` を作る。
- 会話履歴を丸ごと残す必要がある場合は、要約ではなく履歴としてここへ置く。
- 次回以降も効く短いメモは、必要なら `MEMORY.md` へ切り出す。
- 背景理由つきで採用/却下が決まった判断は `knowledge/docs/decisions/` へ昇格する。

## 書かないもの

- 永続的な作業規約。これは `AGENTS.md`。
- 判断prior。これは `COMPASS.md`。
- ユーザーの作業モデル。これは `USER.md`。
- 要求定義本文。これは `knowledge/docs/requirements/`。
- 現在構成。これは `Hello-world.md`。
