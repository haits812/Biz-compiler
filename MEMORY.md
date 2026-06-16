# MEMORY.md

> このファイルは、普段の会話で出た「覚えといて」をまず置くメモである。定期的に `knowledge-curation` で掃除し、正本化・移動・削除する。

## 役割

- 会話中に次回以降も効きそうなことが出たら、まずここに短く置いてよい。
- ここは未整理メモを含む。書いた時点では正式なルール、決定、ユーザーモデルではない。
- 現在構成、読み込み順、禁止事項、決定履歴、メタ台帳の正本にはしない。
- 長い会話履歴を丸ごと残す場合は `knowledge/journal/` に置く。
- 背景理由つきで採用/却下が決まった判断は `knowledge/docs/decisions/` に移す。

## 未整理メモ

- Contract Gate は独立した大きなgateというより、数字phase末尾に入る完了処理/出口チェックとして設計する候補。各phaseで次へ進める契約条件、検収条件、実行者、scope、rollbackなどが揃ったかを確認する処理として後で整理する。

- Revision/Recompile Model（manifest revision、contract patch、approval再取得、gate降格など）は、70/80の運用・改善ループに到達してから整備する。現時点の先行メタ土台からは外し、phase handoff、gate policy、evidence/confidenceを先に扱う。

- PDG / taint analysis は本格的な静的解析として先に実装するより、まず `taint-lite` 的な観点として `skill-creator-gate` や検収/validation gate に残す候補。特に shell、外部送信、secret/env、ファイル削除/上書き、ユーザー入力からcommand stringへの流入、approval bypass などを、成果物の品質チェック項目として扱う方向がよさそう。

- `code-impact` はGitNexus型のフル基盤ではなく、Biz-compilerのメタ土台向けに軽量な永続グラフを生成indexとして持つ方向を本命候補にする。対象は `knowledge/`、`template/`、repo-local ops、root正本の関連ファイル探索で、`output/Biz-*` の個別業務フォルダは原則そのフォルダ内で完結する前提。ハロワゲート時にindex鮮度や再確認対象を見られるとよいが、正本はMarkdown/台帳であり、グラフは補助indexとして扱う。

## 掃除ルール

`knowledge-curation` で定期的にこのファイルを見直し、各メモを次のどれかへ振り分ける。

| 行き先 | 使う時 |
|---|---|
| `AGENTS.md` | 作業規約、読み込み順、禁止事項、配置ルール |
| `USER.md` | ユーザーの作業モデル、嫌う混同、会話上の好み |
| `SOUL.md` | agentの対話姿勢、避ける振る舞い |
| `COMPASS.md` | 判断prior、思考の向き、疑うもの |
| `knowledge/docs/decisions/` | 背景理由つきで採用/却下した判断 |
| `knowledge/pending/` | まだ確定できない候補 |
| `knowledge/journal/` | 長い会話履歴、作業ログ、試行錯誤 |
| `knowledge/docs/*` | 用語、IR、method、metaなどの正本文書 |
| 削除 | 重複、解決済み、誤り、もう効かない内容 |

掃除後、ここには「まだ整理していない短いメモ」だけを残す。
