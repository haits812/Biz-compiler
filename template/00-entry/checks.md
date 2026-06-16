# 00 Entry Checks

00-entry の出口チェック。10-source-intakeへ渡す前に確認する。

## Entry Checks

| Check | Pass Criteria | Result |
|---|---|---|
| entry type | `existing_work` / `new_work` / `unclear` が記録され、`unclear` なら理由がある | `<pass/defer/rework/stop>` |
| target statement | 業務候補を一文で説明できる | `<pass/defer/rework/stop>` |
| intent | 何をしたいかが粗く分類されている | `<pass/defer/rework/stop>` |
| not a one-off | 単発作業ならBiz-compiler対象外として扱いが明記されている | `<pass/defer/rework/stop>` |

## Material Checks

| Check | Pass Criteria | Result |
|---|---|---|
| existing material path | 既存型はマニュアル、ツール、成果物、ログ、画面などの候補がある | `<pass/defer/rework>` |
| new concept path | 新規型は構想、参考例、想定シナリオ、制約の候補がある | `<pass/defer/rework>` |
| source candidates | 10で最初に確認するsource候補がある | `<pass/defer/rework>` |
| missing materials | ない/取れない/未確認の材料が記録されている | `<pass/defer/rework>` |

## Scope Checks

| Check | Pass Criteria | Result |
|---|---|---|
| scope in | 対象に含めるものが粗く分かる | `<pass/defer/rework>` |
| scope out | 対象外が粗く分かる、または未確認として残っている | `<pass/defer/rework>` |
| undecided scope | 境界が曖昧なものを隠していない | `<pass/defer/rework>` |
| scope creep | 便利だから混ぜたものを別候補として扱えている | `<pass/defer/rework>` |

## Risk Checks

| Check | Pass Criteria | Result |
|---|---|---|
| external impact | 他部署、社外、顧客、共有interface変更候補を確認した | `<pass/defer/rework>` |
| sensitive data | 個人情報、契約情報、機密情報候補を確認した | `<pass/defer/rework>` |
| irreversible action | 外部送信、発注、確定、削除、権限変更候補を確認した | `<pass/defer/rework>` |
| responsibility | 間違えた時の責任者/停止者が不明なら不明として残した | `<pass/defer/rework>` |

## Phase Boundary Checks

| Check | Pass Criteria | Result |
|---|---|---|
| no 20 work | As-Is詳細分解を00で完了していない | `<pass/rework>` |
| no 30 work | executor / automation / Skill routingを00で決めていない | `<pass/rework>` |
| no 40+ work | IR、consent、validation、operation設計を00で固定していない | `<pass/rework>` |
| later notes | 後続phaseの話を `later-phase-notes.md` に送っている | `<pass/defer/rework>` |

## Gate Decision

| Field | Value |
|---|---|
| result | `pass` / `defer` / `rework` / `stop` |
| reason | `<判断理由>` |
| next_phase | `10-source-intake` |
| rework_target | `00-entry` / `none` |
| deferred_items | `<10で検証する未確認事項>` |
| stop_reason | `<stopの場合の理由>` |