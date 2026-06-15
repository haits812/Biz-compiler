# 10 Source Intake Contract

> Copy this file into `output/Biz-001-業務名/10-source-intake/contract.md` when an actual business is created.

## Contract Identity

| Field | Value |
|---|---|
| phase_id | `10-source-intake` |
| contract_version | `v0` |
| business_id | `<Biz-XXX>` |
| business_name | `<業務名>` |
| prepared_by | `<作業者>` |
| last_updated | `<YYYY-MM-DD>` |
| gate_result | `draft` |

## Scope From 00

| Field | Value |
|---|---|
| in_scope | `<対象に含めるもの>` |
| out_of_scope | `<対象外>` |
| external_or_sensitive_candidates | `<他部署、社外、個人情報、契約情報など>` |
| initial_goal | `<仮ゴール>` |
| source_candidates_from_00 | `<00から渡されたsource候補>` |

## Source Intake Contract

| Contract Item | Required State |
|---|---|
| source inventory | 主要sourceが `source_id` 付きで登録されている |
| source status | `target` / `collected` / `reviewed` / `unavailable` が分かる |
| fact separation | `observed_fact` / `person_explanation` / `hypothesis` / `unconfirmed` が分かれている |
| provenance | 各主張に `observed` / `hypothesized` / `negotiated` / `derived` の由来がある |
| confidence | 各主張に `low` / `medium` / `high` がある |
| evidence | 主張を支えるsource_idまたはログ参照がある |
| counter_evidence | 反例、未確認、矛盾、near-missが記録されている |
| handoff | 20へ渡すsource packetが作られている |

## Evidence Policy

| Claim Type | provenance | Initial confidence | Notes |
|---|---|---|---|
| observed_fact | `observed` | `medium` | 複数sourceまたは再現で `high` 候補 |
| person_explanation | `hypothesized` | `low` | 本人説明は重要だが観測済みではない |
| negotiated_scope | `negotiated` | `medium` | 合意でありvalidationではない |
| derived_claim | `derived` | 入力の最弱confidence以下 | 導出元を必ず残す |
| unconfirmed | `hypothesized` | `low` | 20へ渡す場合はdefer理由が必要 |

## Gate Result

| Field | Value |
|---|---|
| result | `pass` / `defer` / `rework` / `stop` |
| reason | `<判断理由>` |
| rework_target | `10-source-intake` / `00-entry` / `none` |
| deferred_items | `<deferする未確認項目>` |
| next_phase | `20-decompose-encrs` |
| gate_policy_notes | `<gate-policy-matrix上の注意>` |

## Handoff Minimum

10から20へ渡す最小情報は次の通り。

- source inventoryへの参照
- observed facts一覧
- person explanation一覧
- hypotheses / unconfirmed一覧
- source不足と追加観測候補
- scope外、external、sensitive候補
- confidenceが低いが20で扱う必要がある項目
