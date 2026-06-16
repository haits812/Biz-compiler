# Scope Memo

00-entry 時点のscopeメモ。ここでは粗く切る。詳細なAs-Is分解や責務分解は20以降で扱う。

## Scope In

| item_id | Item | Reason | Confidence |
|---|---|---|---|
| `SI-001` | `<対象に含めるもの>` | `<理由>` | `low` |

## Scope Out

| item_id | Item | Reason | Confidence |
|---|---|---|---|
| `SO-001` | `<対象外にするもの>` | `<理由>` | `low` |

## Undecided Scope

| item_id | Item | Why undecided | Next check |
|---|---|---|---|
| `SU-001` | `<まだ境界が曖昧なもの>` | `<理由>` | `<10で確認するsource>` |

## Scope Creep Candidates

| item_id | Item | Why it may be separate | Handling |
|---|---|---|---|
| `SC-001` | `<便利だから混ぜたくなるもの>` | `<別業務かもしれない理由>` | `out_of_scope` / `undecided` / `split candidate` |