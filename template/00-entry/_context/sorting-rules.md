# 00 Sorting Rules

00-entry では、ユーザー回答を要求定義としてまとめない。10-source-intakeへ渡すための入口情報として分類する。

## Entry Type

| entry_type | 意味 | 10への渡し方 |
|---|---|---|
| `existing_work` | すでに運用、手順、成果物、ツール、担当者、実例のどれかがある業務 | 現物source候補を中心に渡す |
| `new_work` | まだ実運用されていない構想、新規業務、これから作る仕組み | 仮説、参考例、想定シナリオ、制約を検証材料として渡す |
| `unclear` | 既存か新規か判断できない | 00で追加質問。原則10へ進めない |

`mixed` は独立typeにしない。既存業務を受け取った時点で改善、自動化、再配置は後続で必ず検討するため、既存部分があるなら `existing_work` として扱う。

## Intent Values

既存業務でよくあるintent:

- `automate`
- `improve`
- `redesign`
- `reduce_manual_work`
- `add_ai_support`
- `stabilize_operation`

新規業務でよくあるintent:

- `create_new_operation`
- `design_workflow`
- `validate_idea`
- `prepare_launch`
- `standardize_before_operation`

intentは複数選んでよい。ただし00では解決策を決めない。

## Classification Boxes

| Box | 入れるもの | Artifact |
|---|---|---|
| business_candidate | 業務名候補、短い説明 | `entry-packet.md` |
| actor_owner_candidate | 依頼者、担当者、利用者、承認者候補 | `entry-packet.md` |
| rough_goal | なぜ今やりたいか、成功イメージ | `entry-packet.md` |
| scope_in | 対象に含めるもの | `scope-memo.md` |
| scope_out | 対象外にするもの | `scope-memo.md` |
| undecided_scope | まだ境界が曖昧なもの | `scope-memo.md` |
| material_candidates | 10で確認する資料・現物・参考・構想 | `source-candidates.md` |
| rough_input_output | 入力/出力の粗い見立て | `entry-packet.md` |
| initial_risk_hints | 外部影響、不可逆操作、sensitiveなど | `initial-risk-memo.md` |
| unknowns | 00では未確認のまま残すもの | `handoff.md` |
| later_phase_notes | 後続phaseで扱う話 | `later-phase-notes.md` |
| stop_reason | 00で止める理由 | `checks.md` / `contract.md` |

## Provenance

00の情報は多くが本人説明または仮説である。`observed` と断定しない。

| 入力 | 00での扱い |
|---|---|
| その場のユーザー説明 | `person_explanation` / low confidence |
| 実ファイルや画面が渡された | `source_candidate`。review済みではない |
| 既存decisionやtemplateと照合できた | `derived` / medium以下 |
| 作業者の推測 | `hypothesis` / low confidence |