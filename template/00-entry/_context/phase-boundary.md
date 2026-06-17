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

## Source-First Routing

後続phaseに見える話でも、実物やルールを確認しないと判断できないものは、まず10-source-intakeへ送る。

| 出てきた話 | 00での扱い | first_check_phase | after_confirmed_phase |
|---|---|---|---|
| 手順、分岐、例外の存在 | source候補/unknownとして残す | 10 | 20 |
| 入力/出力の列、項目、必須情報 | source候補/unknownとして残す | 10 | 20 / 40 |
| 既存ルール、期限、社内基準 | source候補/unknownとして残す | 10 | 20 / 40 / 50 |
| 判断者、承認者、対応表の鮮度 | source候補/unknownとして残す | 10 | 30 / 50 |
| 自動化したい箇所 | intent/later noteとして残す | 10 if evidence needed | 30 |
| AI読取、抽出、分類の精度 | 仮説として残す | 10 | 60 |
| 外部送信、本登録、削除、確定 | risk hintとして残す | 10 | 30 / 40 / 50 / 60 |

`first_check_phase` が10の場合、00では `suggested_phase` を20以降だけにしない。`later-phase-notes.md` では、まず10で何を確認するかも併記する。

## Later Phase Detail Rule

ユーザーが後続phaseの詳細を話した場合、捨てない。ただし00で決めない。

1. source確認が必要なら `first_check_phase = 10-source-intake` を付ける。
2. source確認後に扱う先を `after_confirmed_phase` または `suggested_phase` に付ける。
3. `artifacts/later-phase-notes.md` または `unknowns` に保存する。
4. 00の質問へ戻る。

## Stop Drilling Rule

次の状態になったら深掘りを止める。

- 10でsourceを読めば分かる。
- 20でAs-Is分解すべき。
- 30でexecutor routingすべき。
- 40以降でcontract / consent / validation / operationとして扱うべき。

止めた理由は `later_phase_notes` または `unknowns` に残す。source確認が必要な話は、後続phaseへ直送せず、10での確認対象を先に書く。
