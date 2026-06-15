# Hello World のファイル名を Hello-world.md に変更する

## Context

カンマ入りの旧ファイル名は概念としては分かりやすいが、Windows PowerShellや一部のコマンド引数ではカンマが配列区切りとして扱われやすく、読み取り・lock・impact指定で余計な注意が必要になっていた。

ユーザーは、ファイル名そのものに強いこだわりがないなら、影響範囲を確認したうえでハイフン名へ寄せてよいと判断した。

## Decision

ルートのHello World正本ファイル名を `Hello-world.md` に変更する。

概念名は引き続き `Hello World` と呼ぶ。repo-local gate名も `hello-world-gate` のままとする。

## Consequences

- 初期読み込み順、README、AGENTS、COMPASS、lexicon、meta台帳、ops registry、hello-world-gate実装内の参照を `Hello-world.md` へ統一する。
- 旧ファイル名のパス参照は残さない。
- Hello World Gate は `Hello-world.md` を生成・検査・commit/pushする。
- `-Files` は引き続きセミコロン区切りにする。これは複数ファイル指定の明示性のためであり、Hello Worldファイル名のカンマ回避だけに依存しない。