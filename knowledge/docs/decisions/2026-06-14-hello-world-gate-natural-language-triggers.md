# Hello World Gate の自然言語トリガーを定義する

- Status: Accepted
- Date: 2026-06-14

## Context

ハロワゲートは、作業者が明示的なコマンド名を打つ時だけでなく、会話中の短い依頼からも発火してほしい。

特に `ハロワやっといて`、`githubあげといて` のような言い方は、ユーザー側では明確にgate実行を意味している。

## Decision

`knowledge/ops/skills/hello-world-gate/SKILL.md` に発話トリガーを追加する。

外向けの実行はすべて `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` に接続する。

- `ハロワやっといて`: ハロワ更新、検査、必要なら日本語commitとGitHub pushまで行う。
- `ハロワ見て` / `ハロワ確認して`: ハロワ更新、検査、必要なら日本語commitとGitHub pushまで行う。
- `ハロワ更新しといて`: ハロワ更新、検査、必要なら日本語commitとGitHub pushまで行う。
- `githubあげといて` / `GitHub上げて` / `pushして` / `pushしといて`: ハロワ更新・検査込みで、日本語commitとGitHub pushまで行う。

`githubあげといて` と言われても、Biz-compiler側に別の `commit-push-gate` を探したり作ったりしない。出口は `hello-world-gate.ps1` に一本化する。

GitHubへ上げる依頼はハロワ更新込みとして扱い、人間に `ハロワ更新してからgithubあげて` と二段で依頼させない。

## Consequences

- 次回以降のagentが短い依頼を正しくgateに接続しやすくなる。
- コマンド名を知らない人間側の自然な言い方でも運用が回る。
- `commit-push-gate` というDeckPilot側の名前を再導入しにくくなる。
