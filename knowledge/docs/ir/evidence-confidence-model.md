# Evidence / Confidence Model v0

- Status: v0
- Date: 2026-06-15
- Read when: `provenance`、`confidence`、`evidence`、`counter_evidence` をIR、contract、validationへ入れる時

## Purpose

この文書は、本人説明、観測ログ、合意、推測、検証結果を同じ強さで扱わないための最小ルールである。

`provenance` は由来であり、`confidence` は信頼度である。由来が明確でも、反例や例外が多ければconfidenceは下がる。

## Provenance Values

| Value | 意味 | 初期confidenceの目安 |
|---|---|---|
| `observed` | 実ファイル、ログ、画面、運用痕跡、実演から観測した | `medium`。複数回・複数sourceなら `high` 候補 |
| `hypothesized` | 会話、推測、未検証のTo-Be案、作業者の仮説 | `low` |
| `negotiated` | 人間と合意した契約、承認、scope、gate | `medium`。合意であり、正しさの検証ではない |
| `derived` | 観測済み情報や契約から導出した | 入力の最弱confidenceを超えない |

## Confidence Bands

| Band | 目安 | 使い方 |
|---|---|---|
| `low` | 反証可能な仮説。単一会話、推測、未観測 | 自動実行しない。HITLや追加観測へ回す |
| `medium` | 一定の根拠はあるが例外や未確認が残る | contract draftやHITL付き実行に使える |
| `high` | 複数根拠、再現、fresh executor / shadow run / 運用で裏付けあり | gate緩和候補にできるが、不可逆性は別に見る |

数値で持つ場合は、v0では次の対応を使う。

| Band | Range |
|---|---|
| `low` | `0.00-0.39` |
| `medium` | `0.40-0.74` |
| `high` | `0.75-1.00` |

## Raise / Lower Rules

| 変化 | 条件 |
|---|---|
| 上げる | 複数sourceで同じ事実が確認できた |
| 上げる | fresh executorが契約だけを見て実行できた |
| 上げる | shadow runで期待出力、例外、差戻し処理が再現した |
| 上げる | 実運用ログで繰り返し成功し、near-missがない |
| 下げる | counter_evidence、near-miss、差戻し、例外が出た |
| 下げる | 本人説明と観測ログが矛盾した |
| 下げる | sourceが古い、担当者依存、口頭のみ、再現不能 |
| 下げる | scopeや外部interfaceが変わった |

## Phase Usage

| Phase | 使い方 |
|---|---|
| `10-source-intake` | sourceごとにprovenanceを付け、事実・本人説明・推測・未確認を分ける |
| `20-decompose-encrs` | As-Is手順とdisposition候補にconfidenceを付け、孤児や暗黙判断を低confidenceとして残す |
| `30-route-executor` | 低confidenceの責務をfull-autoへ回さない。gate policyの入力にする |
| `40-ir-freeze` | `evidence` と `counter_evidence` をIR/contractへ入れ、未検証仮説を分ける |
| `50-consent` | approvalは `negotiated` を作る。validation済みにはしない |
| `60-validation` | fresh executor / shadow run / type checkの結果でconfidenceを上げ下げする |
| `70/80` | 運用ログやnear-missでconfidenceを再評価する。Revision/Recompile Modelは70/80到達後に整備する |

## Evidence Record Minimum

IRやcontractに根拠を持たせる時は、最低限これを残す。

| Field | 意味 |
|---|---|
| `evidence_id` | 根拠のID |
| `source_type` | log / file / interview / observation / approval / validation / shadow-run など |
| `source_ref` | ファイル、ログ、発言、実行結果への参照 |
| `claim` | その根拠が支える主張 |
| `provenance` | `observed` / `hypothesized` / `negotiated` / `derived` |
| `confidence` | `low` / `medium` / `high` または数値 |
| `counter_evidence` | 既知の反例、near-miss、未確認 |
| `last_checked` | 最後に確認した日やrun |

## Non-Negotiable Rules

- approvalはvalidationではない。
- confidenceが高くても、不可逆操作はgate policyで別に見る。
- `derived` は入力の最弱confidenceを超えない。
- evidenceがない主張を `high` にしない。
- 本人説明を軽視しないが、観測済み事実と同じ箱に入れない。
- 同意ビューに出す説明と、実行時IRに残すpayloadの粒度を混ぜない。

## Update Rule

このモデルを変える場合は、`minimum-ir-attributes.md`、`gate-policy-matrix.md`、60-validationの検証観点、80-operationのledger設計へ影響するかを確認する。