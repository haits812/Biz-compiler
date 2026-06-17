# Fact Register

10-source-intake で扱う主張台帳。観測済み事実、本人説明、推測、未確認を混ぜない。

## Claim Type Values

| claim_type | 意味 | provenance | initial confidence |
|---|---|---|---|
| `observed_fact` | sourceから観測した事実 | `observed` | `medium` |
| `person_explanation` | 本人が説明した内容 | `hypothesized` | `low` |
| `hypothesis` | 作業者の仮説、To-Be案、解釈 | `hypothesized` | `low` |
| `negotiated_scope` | 合意したscopeや扱い | `negotiated` | `medium` |
| `derived` | 他claimから導出した主張 | `derived` | 入力の最弱confidence以下 |
| `unconfirmed` | まだ確認していないが重要な項目 | `hypothesized` | `low` |

## Source Class On Claims

claimは、supporting source の性質も見る。

| source_class | claimでの扱い |
|---|---|
| `primary` | observed_fact候補。ただしscopeや例外があればconfidenceを上げすぎない |
| `secondary` | observed_factの補助、またはperson_explanation/hypothesisの裏取り候補 |
| `hearsay` | person_explanation または unconfirmed。observed_factへ昇格しない |
| `assumption` | hypothesis。source確認まで low confidence |

## Claims

| claim_id | claim_type | statement | source_ids | source_class | provenance | confidence | source_holder | owner | approver_or_permission | counter_evidence | status | used_by_20 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `C-001` | `observed_fact` | `<主張>` | `<S-001>` | `primary` | `observed` | `medium` | `<source holder>` | `<owner>` | `<承認/許可>` | `<none/反例>` | `open` | `yes` |

## Status Values

| status | 意味 |
|---|---|
| `open` | 10内で扱い中 |
| `ready-for-20` | 20へ渡せる |
| `deferred` | 未確認のまま制約付きで渡す |
| `needs-owner` | owner、承認者、利用許可の確認が足りない |
| `needs-source` | source不足 |
| `contradicted` | 反例や矛盾がある |
| `out-of-scope` | 00へ戻す、または対象外として扱う |

## Counter Evidence

| counter_id | related_claim_id | source_id | note | effect_on_confidence |
|---|---|---|---|---|
| `CE-001` | `<C-001>` | `<S-002>` | `<矛盾、例外、near-miss>` | `lower to low` |
