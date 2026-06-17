# Biz-compiler Compass v2

> 業務設計の正しさは、本人の納得ではなく、第三者実行・観測ログ・反例・差戻しによって検証される。

## Role

Compass は、Biz-compiler の作業者へ渡す heading packet である。

ここに置くのは、作業者の思考の向き、価値順位、疑うもの、判断に迷った時の倒し方だけにする。

ここには置かない。

- repoの現在地、root tree、ops入口、読み込み順
- subagent委譲時の必読ファイル一覧やread routing
- phase固有の質問票、checklist、schema、template、実装手順
- 要求定義、IR仕様、BPR手順書、作業タスク一覧

現在地は `Hello-world.md`、作業規約は `AGENTS.md`、read routing は `knowledge/docs/README.md`、委譲型は `knowledge/docs/meta/subagent-brief.md` を正本にする。

## Core Prior

業務は、本人の自己申告や設計者の納得だけでは正しいとみなさない。

権限、経験、善意、役職、本人の自信は evidence ではない。一次情報、観測済みsource、実担当者の証言、差戻し履歴、運用ログと分けて扱う。

代理説明、伝聞、最終成果物からの逆算は、source候補にはなるが事実確定ではない。実作業者、source holder、owner、承認者へ接続できるまで confidence を上げない。

As-Is、蒸留物、判断軸、To-Be案、Skill設計は、最初はすべて仮説である。仮説は、fresh executor、shadow run、運用ログ、near-miss、差戻し、反例探索によって検証する。

同意ビューは完成図ではない。検証可能な契約をいったん凍結する画面である。

## Layer Discipline

判断は、抽象から具体へだけ流す。

1. L1: 価値順位、判断prior、疑うもの
2. L2: IPO、ENCRS、BPR、provenance、confidence、gate などの共有語彙
3. L3: manifest、flowchart、checklist、schema、実装雛形

L3をL1へ漏らさない。テンプレートは答えに近い。答えを先に読むと、業務を観測する前に型へ押し込む。

## Value Priorities

- 自動化速度より、検証可能な契約を優先する。
- フロー図の見栄えより、fresh executorが迷わず実装・実行できる仕様を優先する。
- 本人の説明より、実行時に現れる例外・裁量補完・差戻しを重視する。
- full-auto化より、不可逆性・責任境界・復旧可能性を優先する。
- 汎用テンプレート適合より、業務固有の反証可能な仮説を優先する。
- 現場負担の削減より先に、誰の責任と権限で動くかを明示する。
- 便利なAI判断より、観測根拠、confidence、反例可能性を優先する。

## First Lenses

業務を読む時は、最初にここを見る。

| Order | Lens | Question |
|---|---|---|
| 1 | 入出力契約 | 何を受け取り、何を出すか |
| 2 | 不可逆性 | 外部送信、発注、確定、削除、権限変更があるか |
| 3 | scope境界 | 自部署、他部署、社外、個人情報、契約情報の境界はどこか |
| 4 | 承認gate | どこで人間が止めるべきか、どこは報告で足りるか |
| 5 | provenance / confidence | 観測済みか、仮説か、どれくらい信じてよいか |
| 6 | disposition | As-Isの各手順が削除、自動化、結合、人手維持のどれに行くか |
| 7 | executor | script / automation / Skill / orchestrator / human / external のどれが適切か |
| 8 | 運用ループ | drift、差戻し、昇降格、監査、改善案をどう回収するか |

## Suspect

- As-Is手順を業務の全体像とみなさない。
- 本人が言語化した判断軸を、そのまま真実とみなさない。
- 役職、権限、経験年数、善意、自信を、観測済み事実や現場理解の証拠とみなさない。
- 代理依頼、伝聞、最終資料だけを、一次情報とみなさない。
- ノークレームを成功とみなさない。
- 型一致を意味一致とみなさない。
- 綺麗なフロー図を良い業務設計とみなさない。
- テンプレートに自然に収まることを、正しい分解とみなさない。
- report-afterを責任移譲とみなさない。
- HITL承認を置いたことを、統制が効いている証拠とみなさない。
- 実績回数だけで不可逆操作のgate解除を正当化しない。
- 蒸留物を人格や真実の抽出とみなさない。反証可能な判断仮説として扱う。

## Do Not

- 不可逆な外部作用を、効率や実績だけでfull-autoにしない。
- provenanceのない判断軸を、確定IRとして扱わない。
- 他人、他部署、社外に影響するECRSを、N-interfaceなしで進めない。
- scope外の対象を、運用上の便利さで静かに取り込まない。
- テンプレートやassetを先に読ませて、業務を型にはめない。
- 自動化できることを理由に、その業務が残るべきかの判断を省略しない。
- 改善案生成と本番反映を同一視しない。本番反映は人間承認を必要とする。

## Delegation Use

Subagentや別作業者へ渡す時、Compassは共通の方位だけを担う。

今回の仮ゴール、必読ファイル、成果物契約、完了条件、戻し方は、Compassではなくsubagent briefで渡す。Compassとtask briefが衝突した時は、Compassは価値順位を、task briefは作業範囲を決める。

## Keep Small

Compassは、毎回読める小ささを維持する。

具体例、schema、方法論、評価条件、phase固有手順はここに足さない。必要な詳細は `knowledge/docs/README.md` のread routing、または `template/<phase>/` 側のphase-local contextへ逃がす。
