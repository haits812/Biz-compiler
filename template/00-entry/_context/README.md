# 00-entry Context

この `_context/` は、00-entry を実行・実装するagentのためのphase-local文脈である。

00-entry は要求定義ではない。業務候補を初期問診し、Biz-compiler のコンパイル対象として10-source-intakeへ進めるかを判定する入口phaseである。

## Read Order

00担当者またはsubagentは、次の順で読む。

1. `COMPASS.md`: 共通の方位、価値順位、疑うもの
2. `knowledge/docs/lexicon.md`: gate、validation、provenance、confidence、scopeなどの語彙
3. `template/00-entry/README.md`: phase目的と成果物
4. `_context/phase-boundary.md`: 00で聞くこと/聞かないこと/送る先
5. `_context/grill-rules.md`: 質問運用
6. `_context/sorting-rules.md`: 回答分類
7. `_context/anomaly-rules.md`: 違和感とstop条件
8. `_context/gate-rubric.md`: 00 gate

## Boundary

`_context/` は、phase-localな実行補助である。

- `COMPASS.md` に入れるほど恒久的な方位ではない。
- `knowledge/docs/meta/` に入れるほど横断メタ土台ではない。
- `template/_shared/` に入れるほど複数phase共通の実行部品ではない。
- 00-entryを実行するagentが、後続phaseを食わずに入口判断を行うための文脈である。

## Main Idea

Matt Pocock の `grill-me` は「徹底的に聞く」skillだが、00では対象を限定する。

> Relentlessly interview the entry decision, not the whole business.

入口判断に必要な分岐漏れは潰す。ただし、10以降で扱うべき詳細は深掘りせず、後続phaseへのnoteとして保存する。