# Hello World Gate をrepo-local Skillにする

- Status: Accepted
- Date: 2026-06-14

## Context

`hello-world-gate.ps1` は、`Hello,world.md` が現在状態を嘘なく返すための運用コマンドとして作られた。

しかし、コマンドだけでは「いつ最新状態へ更新するのか」が作業者へ伝わらない。ユーザーは、ハロワゲートをSkillとして扱い、実行タイミングまで規律化することを求めた。

一方で、このSkillはBiz-compilerリポジトリ専用であり、グローバルSkillとして置く意味はない。

## Decision

`knowledge/ops/skills/hello-world-gate/SKILL.md` を追加する。

これはBiz-compiler repo-local Skillであり、`C:\Users\khsub\.agents\skills` や `C:\Users\khsub\.codex\skills` には置かない。

このSkillは、次を定義する。

- どの変更でハロワゲートを使うか
- いつ `sync` を実行するか
- いつ `check` を実行するか
- `check` 失敗時に完了扱いしないこと

## Timing Rule

- `sync` は、`Hello,world.md` に載る状態を変えた後、同じターンで実行する。
- `check` は、現在地を信じる前と、完了報告前に実行する。
- read-only説明では通常 `check` のみ。`check` がstaleで落ちた場合に限り、正当な状態更新として `sync` する。

## Consequences

- ハロワゲートは、単なるコマンドではなく作業規律として扱える。
- Biz-compiler外の作業へ誤爆しない。
- 後続agentは、`AGENTS.md` とrepo-local Skillを読めば、最新状態更新のタイミングを判断できる。
