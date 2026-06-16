# Hello World Gate をrepo-local Skillにする

- Status: Accepted
- Date: 2026-06-14

## Context

`hello-world-gate.ps1` は、`Hello-world.md` が現在状態を嘘なく返すための運用コマンドとして作られた。

しかし、コマンドだけでは「いつ最新状態へ更新するのか」が作業者へ伝わらない。ユーザーは、ハロワゲートをSkillとして扱い、実行タイミングまで規律化することを求めた。

一方で、このSkillはBiz-compilerリポジトリ専用であり、グローバルSkillとして置く意味はない。

## Decision

`knowledge/ops/skills/hello-world-gate/SKILL.md` を追加する。

これはBiz-compiler repo-local Skillであり、ユーザー環境のグローバルSkill置き場には置かない。

このSkillは、次を定義する。

- どの変更でハロワゲートを使うか
- 外から叩くコマンドを `hello-world-gate.ps1` ひとつにすること
- ハロワ更新、検査、必要なら日本語commit、GitHub push、post-checkまで一気通貫で行うこと
- gate失敗時に完了扱いしないこと
- GitHubへ上げる依頼はハロワ更新込みとして扱うこと

## Timing Rule

- `Hello-world.md` に載る状態を変えたら、同じターンで `hello-world-gate.ps1` を実行する。
- 現在地を信じる前と、完了報告前に、必要なら `hello-world-gate.ps1` を実行する。
- read-only説明でも、ハロワが古い可能性を見つけた場合は同じgateで更新・検査する。
- GitHubへ上げる時は、ハロワ更新を別工程にせず同じgateで行う。

## Consequences

- ハロワゲートは、単なるコマンドではなく作業規律として扱える。
- Biz-compiler外の作業へ誤爆しない。
- 後続agentは、`AGENTS.md` とrepo-local Skillを読めば、最新状態更新とGitHub反映のタイミングを判断できる。
