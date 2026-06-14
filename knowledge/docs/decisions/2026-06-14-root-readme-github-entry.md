# Root README をGitHub入口にする

- Status: Accepted
- Date: 2026-06-14

## Context

GitHubにpushした状態を見ると、リポジトリ直下にREADMEがなく、初見でBiz-compilerの入口が分からない。

一方で、現在状態の正本は `Hello,world.md` であり、READMEに最新構成や詳細仕様を詰めると二重管理になる。

## Decision

ルートに `README.md` を置く。

READMEはGitHub上の入口として、Biz-compilerの短い説明、まず読むファイル、基本構成、Hello World Gateの使い方だけを書く。

現在状態の正本は引き続き `Hello,world.md` とし、READMEはそこへ誘導する。

## Consequences

- GitHub上でリポジトリの目的と入口が分かる。
- 詳細仕様や現在状態をREADMEへ重複させず、Hello Worldの一貫性を保てる。
- ルートファイルが増えるため、`hello-world-gate.ps1` のroot file order/descriptionにも `README.md` を追加する。
