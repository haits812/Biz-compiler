# Hello World Gate がcommit/pushまで担当する

- Status: Accepted
- Date: 2026-06-14

## Context

Biz-compilerには `Hello,world.md` を嘘にしないgateが必要である。

一方で、DeckPilot由来の `commit-push-gate` という名前をBiz-compiler側に持ち込むと、どのgateが正式な作業出口なのか分かりにくくなる。

また、`knowledge/ops/` 直下に `.ps1` を並べると、どのSkillに属する実行体なのかが見えない。

## Decision

Biz-compilerでは、commit/push込みのGitHub反映も `hello-world-gate` が担当する。

`commit-push-gate` というrepo-local Skillは作らない。

実行体はSkillフォルダに同居させる。

```text
knowledge/ops/
  README.md
  skills/
    hello-world-gate/
      SKILL.md
      hello-world-gate.ps1
    pending-memory/
      SKILL.md
      new-pending-memory.ps1
      pending-review.ps1
```

外向けコマンドは `hello-world-gate.ps1` ひとつだけにする。このコマンドは、ハロワ更新、検査、`git add -A`、日本語commit、`git push`、post-checkを順番に実行する。

## Consequences

- Biz-compilerの出口gateが `hello-world-gate` に一本化される。
- `commit-push-gate` というDeckPilot側の名前と混ざらない。
- `.ps1` の所属がSkillフォルダから分かる。
- GitHubへ上げる時の作業意味・確認・残リスクは、日本語commit messageへ残す。
