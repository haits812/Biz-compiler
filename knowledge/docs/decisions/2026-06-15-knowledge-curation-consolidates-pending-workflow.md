# knowledge-curation に pending 運用を統合する

- Status: Accepted
- Date: 2026-06-15

## Context

`knowledge-curation` は、Memory、pending、journal、decisions、Markdown正本への振り分けを扱うSkillである。

一方で、別に `pending-memory` Skillを置くと、実態は同じ知識整理なのに「どちらを使うのか」が人間側に分かりにくい。特に、`MEMORY.md` を普段メモの入口に戻した後は、pending候補の作成・承認も knowledge curation の一部として扱う方が自然である。

## Decision

Biz-compilerでは、知識整理系Skillを `knowledge-curation` に一本化する。

`pending` は未承認候補の状態名として残すが、`pending-memory` というSkillやフォルダは作らない。

実行体は `knowledge/ops/skills/knowledge-curation/` に置く。

```text
knowledge/ops/skills/knowledge-curation/
  SKILL.md
  new-pending-update.ps1
  pending-review.ps1
```

`new-pending-update.ps1` は `MEMORY.md`、`COMPASS.md`、`knowledge/docs/decisions` への未承認候補を作る。`pending-review.ps1` は `pending`、`approved`、`applied`、`rejected` の運用状態を進める。

## Consequences

- 人間側の導線は `knowledge-curation` だけ見ればよくなる。
- `pending` は状態・置き場の名前として残るため、承認前後の監査ログは維持できる。
- 過去の `pending-memory` 参照は `knowledge-curation` のpending運用へ読み替える。
- 今後、似た知識整理Skillを増やす前に、まず `knowledge-curation` の分類・コマンドで足りるか確認する。
