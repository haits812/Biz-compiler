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

## Provenance / Claim Source

00でclaimに入れる `provenance` は、IR共通値の `observed` / `hypothesized` / `negotiated` / `derived` だけを使う。本人説明、assistant推測、source候補種別を `provenance` 値にしない。

00の会話由来claimは、原則 `provenance = hypothesized` とする。細かい由来は `claim_type`、`source_type`、`source_ref` に逃がす。

| 00で見たもの | provenance | claim_type | source_type | source_ref | confidence | 00での扱い |
|---|---|---|---|---|---|---|
| その場のユーザー説明 | `hypothesized` | `person_explanation` | `interview` | `conversation` | `low` | 重要な本人説明だが、観測済み事実ではない |
| 実ファイルや画面が渡された | `hypothesized` | `source_candidate` | `file/screen/log/document` | `SC-xxx` | `low` | source候補。10で読まれるまでreview済みにしない |
| 既存decisionやtemplateから機械的に写したメタ情報 | `derived` | `reference_mapping` | `repo_doc/template` | `<path>` | `medium` 以下 | 導出元を残す。入力のconfidenceを超えない |
| 00内で明示合意したscope | `negotiated` | `negotiated_scope` | `conversation` | `conversation` | `medium` 以下 | 合意でありvalidationではない |
| 作業者やassistantの推測 | `hypothesized` | `hypothesis` | `assumption` | `conversation` | `low` | 低confidence仮説として分離する |

`assistant_hypothesis_from_conversation`、`person_explanation`、`user_statement`、`source_candidate` は `provenance` 値として使わない。
