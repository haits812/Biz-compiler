# Lexicon v0

Biz-compilerの共有語彙を置く。ここは概念境界の正本であり、`COMPASS.md` に語彙説明を詰め込まないための逃がし先である。

## Read When

- Biz-compilerで設計、整理、委譲、実装を行う通常作業の初期
- subagentへphase作業や調査を渡すbriefを書く前
- `provenance`、`confidence`、`gate`、`scope`、`N-interface` などを使う時
- 似た語の違いで迷った時
- `COMPASS.md` に語彙説明が入りすぎそうな時
- IR、manifest、contract、ledger、registryの境界を確認したい時

## Core Terms

| Term | 意味 | 混ぜないもの | 主な接続先 |
|---|---|---|---|
| `gate` | 進行を止める、通す、戻すための境界。人間承認、型検査、危険組合せ拒否などを含む | `approval`。approvalはgateで起きる判断の一種 | IR、manifest、phase handoff、運用 |
| `approval` | 人間が見て同意、拒否、保留を決める行為または記録 | `validation`。承認は正しさの検証ではない | 50-consent、manifest差分、audit |
| `validation` | 契約、型、構造、第三者実行、反例で実行可能性や妥当性を確かめること | `approval`。人間がOKしただけではvalidationではない | 60-validation、evaluation |
| `IR` | 実行や検証へ渡すための中間表現。IPO、executor、gate、provenance、confidence等を持つ | 同意ビューの表示JSON。表示はIRのビューであり正本境界を要確認 | `knowledge/docs/ir/`, 40-ir-freeze |
| `contract` | 入力、処理責務、出力、gate、handoffについて人間とシステムが合意する約束 | `manifest`。contractは単位ごとの約束、manifestは管理対象の束 | IR、phase artifact、consent packet |
| `manifest` | 何を、どの自律レベルで、どのscope/gateで管理しているかの台帳 | `contract`。manifestは現在の管理対象一覧 | 40-ir-freeze、50-consent、80-operation |
| `provenance` | その情報や判断がどこから来たか。観測、会話、資料、推測などの由来 | `confidence`。由来と信頼度は別 | IR、source inventory、ledger |
| `confidence` | その主張をどれくらい信じてよいかの度合い | `provenance`。由来が明確でも信頼度が低いことはある | IR、validation、operation ledger |
| `executor` | 責務を実行する主体。script、automation、Skill、orchestrator、human、externalなど | owner。所有者や責任者と実行者は別 | 30-route-executor、IR |
| `N-interface` | 他人、他部署、社外との共有インターフェースを変える時に必要な調整境界 | ownership。所有権ではなく共有境界の変更 | ENCRS、gate、consent |
| `disposition` | As-Is手順がTo-Beで削除、自動化、結合、人手維持などのどこへ行くか | provenance。由来ではなく行き先 | 20-decompose-encrs、casebook |
| `ledger` | 状態、履歴、判断、実行結果を追う記録 | `registry`。ledgerは時系列や状態変化を追う | meta ledger、operation ledger |
| `registry` | 既知の項目を一覧化し、ID、置き場、状態、依存を引ける台帳 | `ledger`。registryは主に目録 | meta README、将来JSON台帳 |
| `Hello World` | repoが現在地を嘘なく返す最小自己記述 | Compass。Hello Worldはposition、Compassはheading | `Hello,world.md` |
| `Compass` | 作業者の思考の向き、価値順位、疑うものを渡すdirection packet | session brief。Compassは恒常的なheading、session briefは今回の仮ゴール | `COMPASS.md` |
| `phase` | 業務コンパイルの数字工程。00〜80で意味とhandoffを持つ | artifact。phaseは工程、artifactは成果物 | `template/<phase>/`, `phase-catalog.md` |
| `artifact` | phaseや運用の中で作る成果物、契約、ログ、テンプレート | phase。artifactは工程そのものではない | template、output、knowledge docs |
| `irreversible` | 外部送信、発注、確定、削除、権限変更など、実行後の巻き戻しが難しい作用 | high-costと同一視しない。安くても不可逆ならgate対象 | IR safety、manifest、approval gate |

## 重要な区別

### gate / approval / validation

`gate` は止める境界である。`approval` はそのgateで人間が行う判断の一種である。

`validation` は、契約や挙動が成り立つかを検査すること。approvalがあってもvalidationが失敗することはある。

### approval / validation

`approval` は人間の同意であり、`validation` は契約や挙動の検証である。

Biz-compilerでは、人間の納得だけで業務設計を正しいとみなさない。

### IR / consent view

`IR` は実行・検証へ渡す中間表現である。consent viewは人間が契約を見て合意するための表示である。

表示JSONが存在しても、それが実行IRと同じとは限らない。両者の関係は `knowledge/docs/ir/` で固定する。

### contract / manifest

`contract` はノードやphase単位の約束である。`manifest` は現在管理している業務、責務、自律レベル、gate、scopeの束である。

contractは凍結単位、manifestは運用上の一覧として読む。

### provenance / confidence

`provenance` は由来、`confidence` は信頼度である。

観測ログ由来でも例外が多ければconfidenceは下がる。本人説明由来でも、何度も実行で裏付けられればconfidenceは上がる。

### ledger / registry

`ledger` は状態や履歴の流れを見る。`registry` は既知項目を引く。

`knowledge/docs/meta/README.md` は現時点ではMarkdown台帳であり、ledgerとregistryの両方の役割を軽く持っている。JSON registry化は保留中。

## ここに置かないもの

| 置かないもの | 置き場 |
|---|---|
| 判断prior、疑うもの、価値順位 | `COMPASS.md` |
| IR/schema/manifestの構造詳細 | `knowledge/docs/ir/` |
| ENCRSやphase運用の方法論 | `knowledge/docs/method/` |
| 判断例、反例 | `knowledge/docs/casebook.md` |
| 状態語彙の3系統 | `knowledge/docs/meta/state-model.md` |

## 更新ルール

新しい語を追加する時は、既存語との差分を明記する。意味がphase-localなら `template/<phase>/`、IR値なら `knowledge/docs/ir/`、方法論なら `knowledge/docs/method/` と併読させる。