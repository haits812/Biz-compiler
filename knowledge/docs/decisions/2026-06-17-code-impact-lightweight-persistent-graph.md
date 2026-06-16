# 2026-06-17: code-impactは軽量永続グラフindexとして採用する

## Status

Accepted

## Context

Biz-compilerのメタ土台を触る時、変更対象ファイルだけを見ても、前後で読むべきMarkdown、ops、template、root正本を取りこぼす可能性がある。

`rg` は単発の文字列検索として有効だが、1つの候補からさらに関連候補へ辿る用途では、毎回人間やagentが検索語を組み立て直す必要がある。一方で、GitNexus型のフル基盤、MCP、Web UI、vector search、PDG / taint analysis本格実装までは、現時点のBiz-compilerには重い。

このrepoで必要なのは、安全証明ではなく、作業前に「どの関連ファイルを追加で読むべきか」を軽く出す補助indexである。個別業務成果物の `output/Biz-*` は、原則として業務フォルダ内で完結する前提なので、v0の横断対象から外せる。

## Decision

`code-impact` を、Biz-compilerメタ土台向けのrepo-local軽量永続グラフindexとして採用する。

正本はMarkdown、registry、contract、manifestであり、`knowledge/.index/code-impact.sqlite` は生成indexとして扱う。SQLiteを直接編集しない。

v0の対象は、root正本、`knowledge/`、`template/`、repo-local ops とする。`output/Biz-*` の個別業務フォルダ、MCP、Web UI、vector search、PDG / taint analysis本格解析は対象外にする。

運用上は、検索と生成の2か所へ組み込む。

- 作業登録時: `impact-orchestrator` が `-Files` を受けたら、既定で `code-impact query` を実行し、work cardに関連ファイル候補を残す。
- GitHub反映前: `hello-world-gate` が `code-impact rebuild` を実行し、push前に生成グラフを最新化する。

`code-impact` はコードを壊さないことの証明ではない。候補抽出、risk hint、stale検知の補助であり、最終判断は作業者が正本を読んで行う。

## Consequences

- 作業前に、変更対象からdepth付きで関連ファイル候補を辿れる。
- `impact-orchestrator` のwork cardが、Markdown参照impactだけでなくコード/ops/文書graph候補も持てる。
- rebuildが軽いため、hello-world-gateに組み込んでも運用上の負担は小さい。
- SQLite indexは生成物なので、repo clone後やstale時に再生成する必要がある。
- v0のedgeは静的な近似であり、実行時の完全な依存、データフロー、安全性、taintを保証しない。
- 将来、精度不足が実害になった場合だけ、抽出ルール、validation候補、taint-lite、vector searchなどを追加検討する。