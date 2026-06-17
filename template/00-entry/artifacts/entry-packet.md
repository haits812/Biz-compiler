# Entry Packet

00-entry の入口判断を一枚にまとめる。

## Identity

| Field | Value |
|---|---|
| business_id_candidate | `<Biz-XXX or pending>` |
| business_name_candidate | `<業務名候補>` |
| entry_type | `existing_work` / `new_work` / `unclear` (`unclear` はdraft/rework専用。handoff不可) |
| intent | `<intent values>` |
| prepared_by | `<作業者>` |
| created_at | `<YYYY-MM-DD>` |

## Target Statement

| Field | Value |
|---|---|
| one_sentence | `<この業務候補を一文で説明>` |
| why_now | `<なぜ今やりたいか>` |
| rough_goal | `<00時点の仮ゴール>` |
| success_guess | `<成功イメージ。仮説でよい>` |

## Actor / Owner Candidates

| Role | Candidate | Evidence / Source Candidate | Confidence | Notes |
|---|---|---|---|---|
| requester | `<依頼者>` | `<本人説明など>` | `low` | `<補足>` |
| actor | `<実行者候補>` | `<source candidate>` | `low` | `<補足>` |
| owner | `<責任者候補>` | `<source candidate>` | `low` | `<不明ならunknown>` |
| approver | `<承認者候補>` | `<source candidate>` | `low` | `<不明ならunknown>` |

## Rough Input / Output

| Item | Value | Confidence | Notes |
|---|---|---|---|
| rough_input | `<何を受け取って始まるか>` | `low` | `<10/20で確認>` |
| rough_output | `<何を出すか>` | `low` | `<10/20で確認>` |
| trigger | `<いつ/何をきっかけに始まるか>` | `low` | `<10で確認>` |
| cadence | `<頻度が分かれば>` | `low` | `<不明ならunknown>` |

## Low Confidence Hypotheses

低言語化ユーザーに対して、00担当が置いた仮説を記録する。ユーザーが同意しても、sourceで確認されるまでは観測済み事実にしない。

| hypothesis_id | Area | Candidate | provenance | claim_type | source_type | source_ref | Confidence | Next Check |
|---|---|---|---|---|---|---|---|---|
| `H-001` | `business_name/target_statement/success_guess/rough_io/scope/owner` | `<こちらが置いた候補>` | `hypothesized` | `hypothesis` | `assumption` | `conversation` | `low` | `<10で確認するsourceまたは00で聞き直すこと>` |

## Entry Notes

- `<入口で残すメモ>`
