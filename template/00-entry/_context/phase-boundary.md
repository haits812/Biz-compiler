# 00 Phase Boundary

00-entry の仕事は、業務全体を理解し切ることではない。10-source-intakeへ進めるための入口判断を完了することである。

## Ask / Capture / Route

| 聞きたくなった内容 | 00での扱い | 送る先 |
|---|---|---|
| これは既存業務か、新規業務か | 00で聞く | 00 |
| 今ある資料・現物・説明は何か | 00で聞く | 00 / 10 |
| 何をしたいか | `intent` として粗く聞く | 00 |
| 誰の業務か、誰が困っているか | actor / owner候補として粗く聞く | 00 |
| 入力/出力は何っぽいか | 粗く聞く。詳細は決めない | 10 / 20 |
| 詳細な手順はどうなっているか | 深掘りしない。資料/説明候補として残す | 10 / 20 |
| 例外ケースは全部何か | 深掘りしない。例外があることだけrisk/unknownへ残す | 10 / 20 |
| どこを自動化するか | intentとして粗く拾う。設計しない | 30 |
| AI/Skill/scriptに任せるか | 00では決めない | 30 |
| gateや承認をどこに置くか | 初期riskとして拾う。配置は決めない | 30 / 40 / 50 |
| IR node / contract schema / manifest | 00では触らない | 40 |
| 同意画面・flowchart | 00では触らない | 50 |
| 検証方法・test設計 | 00では触らない | 60 |
| 運用ログ・改善サイクル | 初期関心があればメモ。設計しない | 70 / 80 |

## Later Phase Detail Rule

ユーザーが後続phaseの詳細を話した場合、捨てない。ただし00で決めない。

1. `artifacts/later-phase-notes.md` に保存する。
2. `suggested_phase` を付ける。
3. 00の質問へ戻る。

## Stop Drilling Rule

次の状態になったら深掘りを止める。

- 10でsourceを読めば分かる。
- 20でAs-Is分解すべき。
- 30でexecutor routingすべき。
- 40以降でcontract / consent / validation / operationとして扱うべき。

止めた理由は `later_phase_notes` または `unknowns` に残す。