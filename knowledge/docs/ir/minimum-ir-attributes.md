# Minimum IR Attributes

- Status: Extracted from `COMPASS.md`
- Date: 2026-06-14
- Read when: IR、contract、schema、manifest、同意ビューJSONを作る/変更する時

## Purpose

この文書は、`COMPASS.md` から逃がしたIR要求である。

`COMPASS.md` は「観測済みの契約と未検証仮説を混ぜない」というheadingだけを持つ。実際にIRやschemaへ落とす時は、この文書を読む。

## Minimum Attributes

IRには最低限、次の属性を持たせる。

| Attribute | Meaning |
|---|---|
| `provenance` | `observed` / `hypothesized` / `negotiated` / `derived` |
| `confidence` | 0から1、または `low` / `medium` / `high` |
| `evidence` | 観測ログ、ヒアリング、文書、shadow run、差戻しなどの根拠 |
| `counter_evidence` | 既知の反例、near-miss、未確認領域 |
| `irreversibility` | `reversible` / `costly-reversible` / `irreversible` |
| `scope` | `in-scope` / `out-of-scope` / `external` / `sensitive` |
| `gate_policy` | `none` / `report-after` / `HITL-confirm` / `N-interface` / `human-only` |
| `promotion_rule` | 自律レベル昇格の条件 |
| `demotion_rule` | 降格・停止の条件 |

## Non-Negotiable Separation

観測済みの契約と未検証の推測を同じ型で流さない。

特に、次の混同を避ける。

- 本人の説明と観測ログ
- To-Be案と運用実績
- 同意ビュー上の粗い表示と実行時に必要なpayload
- report-afterと責任移譲
- 型一致と意味一致

## Practical Reading Rule

この文書は、すべての会話開始時に読むものではない。

読むのは、次の作業に入る時である。

- IRのschemaを作る/変える時
- manifestやcontractの項目を決める時
- 同意ビューJSONと実行IRの関係を触る時
- 自律レベル、gate、scope、provenance、confidenceを機械可読にする時
