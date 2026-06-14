# Decision Records

このディレクトリは、Biz-compiler開発中の重要な決定を残す場所である。

## 目的

- なぜその構成・制約・設計を選んだのかを後から追えるようにする。
- `MEMORY.md` に入りきらない背景を退避する。
- 要求定義と実装の間にある設計判断を、会話ログだけに埋もれさせない。

## 書くもの

- ディレクトリ構成や読み込み順の決定。
- IR、schema、manifest、runtime、approval gateに関わる決定。
- Compass、Lexicon、Casebookの分離方針。
- リスク指摘への対応方針。

## 書かないもの

- その日の細かい作業ログ。これは `knowledge/journal/` に置く。
- 未承認の提案。これは `knowledge/pending/` に置く。
- 長い要求定義本文。これは `knowledge/docs/requirements/` に置く。

## 推奨フォーマット

```md
# YYYY-MM-DD: <決定タイトル>

## Status
Accepted / Proposed / Superseded

## Context
何が問題だったか。

## Decision
何を決めたか。

## Consequences
良い影響、悪い影響、後で見直す条件。
```

