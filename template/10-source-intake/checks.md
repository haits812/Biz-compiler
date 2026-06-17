# 10 Source Intake Checks

10-source-intake の出口チェック。20-decompose-encrs へ渡す前に確認する。

## Source Checks

| Check | Pass Criteria | Result |
|---|---|---|
| source inventory exists | `artifacts/source-inventory.md` が埋まっている | `<pass/defer/rework>` |
| source IDs | 主要sourceに一意な `source_id` がある | `<pass/defer/rework>` |
| source status | `target` / `collected` / `reviewed` / `unavailable` が分かる | `<pass/defer/rework>` |
| source class | 主要sourceまたはclaimに `primary` / `secondary` / `hearsay` / `assumption` 相当の分類がある | `<pass/defer/rework>` |
| input/output examples | 入力例と出力例がある、または欠落理由がある | `<pass/defer/rework>` |
| failure traces | 差戻し、例外、near-missの有無を確認した | `<pass/defer/rework>` |

## Claim Separation Checks

| Check | Pass Criteria | Result |
|---|---|---|
| observed facts separated | 観測済み事実が本人説明と分かれている | `<pass/defer/rework>` |
| hypotheses visible | 推測やTo-Be仮説が確定扱いになっていない | `<pass/defer/rework>` |
| unconfirmed visible | 未確認事項が一覧化されている | `<pass/defer/rework>` |
| counter evidence | 反例、矛盾、near-missが空でも確認済みとして記録されている | `<pass/defer/rework>` |
| final artifact reverse-engineering | 最終成果物だけから作業実態を逆算していない、または逆算であることを明記している | `<pass/defer/rework>` |

## Evidence / Confidence Checks

| Check | Pass Criteria | Result |
|---|---|---|
| provenance assigned | 主要claimに `provenance` がある | `<pass/defer/rework>` |
| confidence assigned | 主要claimに `confidence` がある | `<pass/defer/rework>` |
| low confidence gated | low confidenceの主要claimが20で確定扱いされない | `<pass/defer/rework>` |
| derived claims bounded | `derived` claimが入力の最弱confidenceを超えていない | `<pass/defer/rework>` |
| subjective claims bounded | 本人断定、権限者説明、ベテラン経験、善意、代理/伝聞が observed fact に昇格していない | `<pass/defer/rework>` |

## Scope / Risk Checks

| Check | Pass Criteria | Result |
|---|---|---|
| scope boundary | in-scope / out-of-scope が見える | `<pass/defer/rework>` |
| external candidate | 他部署・社外・共有interface変更候補が見える | `<pass/defer/rework>` |
| sensitive candidate | personal / contract / sensitive data候補が見える | `<pass/defer/rework>` |
| gate notes | gate-policy-matrix上の注意があれば記録済み | `<pass/defer/rework>` |
| permission / authorization | 権限、閲覧範囲、source利用許可、外部連絡条件が必要なものは未確認のまま進んでいない | `<pass/defer/rework/stop>` |
| actor separation | 実担当者、source holder、owner、承認者が区別されている | `<pass/defer/rework>` |

## Completion Reviewer Subagent

10の実行担当とは別の reviewer が、次を確認する。

| Review Lens | Pass Criteria | Result |
|---|---|---|
| inventory | source inventory があり、主要sourceの状態が分かる | `<pass/defer/rework>` |
| claim provenance | 各claimに source_id、provenance、confidence がある | `<pass/defer/rework>` |
| primary separation | `primary` / `secondary` / `hearsay` / `assumption` 相当の区別がある | `<pass/defer/rework>` |
| real worker | 実作業者またはsource holderへ接続できている | `<pass/defer/rework>` |
| owner / approver | owner、承認者、利用許可者が必要なclaimで区別されている | `<pass/defer/rework>` |
| permission | 権限、閲覧範囲、利用許可、外部連絡条件が未確認なら未確認として残っている | `<pass/defer/rework>` |
| no reverse-only | 最終成果物だけから作業実態を確定していない | `<pass/defer/rework>` |
| no subjective promotion | 本人断定、役職、経験、善意、代理説明を観測済み事実にしていない | `<pass/defer/rework>` |
| defer split | 20へ渡せるdeferと、10/00へ戻すreworkが分かれている | `<pass/defer/rework>` |

## Gate Decision

| Field | Value |
|---|---|
| result | `pass` / `defer` / `rework` / `stop` |
| reason | `<判断理由>` |
| next_phase | `20-decompose-encrs` |
| rework_target | `10-source-intake` / `00-entry` / `none` |
| deferred_items | `<未確認のまま渡す項目>` |
| reviewer_result | `<completion reviewer subagent の判定>` |
| reviewer_notes | `<20へ渡す前の注意、差戻し理由>` |
