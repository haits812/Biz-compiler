# MergeGate型 impact orchestrator と ops registry を採用する

## Status

Adopted 2026-06-15

## Context

Biz-compilerでは、repo-local Skill、hook、orchestrator、command、toolが今後増える。初期読み込みですべてを全文読ませると重いが、存在を知らないと似たものを重複して作る。

また、作業前に「どこへ効くか」「何を読むべきか」「どのgateで終えるか」を切らないと、Skill追加やhook追加が場当たり的になりやすい。

MergeGateは、AI実装を直接担うのではなく、register work、record impact、assign execution、verify completionのgateを置く発想が強い。Biz-compilerではCLI本体を導入せず、この作法だけをrepo-localに移植する。

## Decision

`knowledge/ops/registry.md` を、repo-local Skill / hook adapter / orchestrator / command / tool のMarkdown台帳にする。

`knowledge/ops/orchestrators/impact-orchestrator/` に、作業前の影響確認を行う repo-local orchestrator を置く。実行体は `impact-orchestrator.ps1` とし、work cardを `knowledge/journal/work/` に出す。

hookは環境別adapterとして扱い、現時点では実hook設定を自動編集しない。CodexやClaude Codeへ移植する場合も、hook本体は repo-local orchestrator / Skill を呼ぶだけにする。

## Consequences

- 新しいops資産を作る前に、既存の Skill / hook / orchestrator / command / tool を棚卸しできる。
- 作業前にimpactとread routingを1枚にできる。
- `Hello-world.md` はops entrypointの存在だけを示し、詳細は `knowledge/ops/registry.md` へ逃がせる。
- file lock、branch/PR state、hook自動設定はまだ実装しない。必要になった時にregistryへ追加する。
