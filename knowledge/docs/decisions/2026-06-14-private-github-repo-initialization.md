# Private GitHub repository を初期化する

- Status: Accepted
- Date: 2026-06-14

## Context

Biz-compilerの変更をコミットできるようにするため、private GitHub repository を作成する。

この時点ではローカルフォルダはまだgit repositoryではなかった。

## Decision

GitHub上に private repository `haits812/Biz-compiler` を作成し、作業者のローカルclone先を `main` branch のgit repositoryとして初期化する。

Gitは空ディレクトリを追跡しないため、`output/` 以外の空ディレクトリには `.gitkeep` を置いて構成を保持する。

`output/` は「実業務作成まで空にする」ルールを優先し、`.gitkeep` も置かない。

## Consequences

- GitHub上でも `template/` などの空phaseディレクトリを保持できる。
- `output/` はGitHub上には空ディレクトリとして表示されないが、ローカル運用上は空のまま保持する。
- 初回以降のcommit/pushは、Biz-compiler用のcommit gateを別途設計する必要がある。
