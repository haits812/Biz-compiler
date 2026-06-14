# 2026-06-15: lexicon を初期読み込みへ格上げする

## Status
Accepted

## Context

Biz-compilerでは、今後の数字phase作業をmain agentがsubagentへ委譲する前提が強い。main agentが `IR`、`contract`、`manifest`、`gate`、`approval`、`validation`、`ledger`、`registry` などの語彙境界を最初に握っていないと、subagent briefや成果物契約の時点でズレる。

これまで `knowledge/docs/lexicon.md` は条件付きread routingだったが、IR/schema v0やphase設計に入る前に、通常作業の初期で読む必要がある。

## Decision

`knowledge/docs/lexicon.md` を通常作業の初期読み込みへ格上げする。

読み込み順は次を基本にする。

1. `AGENTS.md`
2. `Hello,world.md`
3. `SOUL.md`
4. `USER.md`
5. `COMPASS.md`
6. `knowledge/docs/lexicon.md`
7. `MEMORY.md`
8. `knowledge/docs/requirements/Biz-compiler_要求定義.md`

subagentや別作業者へ重い作業を渡す時も、`knowledge/docs/lexicon.md` を必須セットに含める。

## Consequences

- main agentがsubagent briefを書く前に、語彙境界を揃えられる。
- `approval` と `validation`、`contract` と `manifest`、`IR` と consent view JSON などの混同を早い段階で防げる。
- 初期読み込みトークンは増えるが、phase作業やIR/schema作業での手戻りを減らすための固定コストとして扱う。
- 詳細なIR/schema構造は引き続き `knowledge/docs/ir/` に置き、`lexicon.md` へ詰め込まない。