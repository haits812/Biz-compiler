# 経験的業務設計ループ

- Status: Extracted from `COMPASS.md`
- Date: 2026-06-14
- Read when: phase設計、ENCRS、fresh executor、shadow run、運用ループを扱う時

## Purpose

この文書は、`COMPASS.md` から逃がした方法論である。

`COMPASS.md` は作業者やsubagentへ思考の指向性を渡す direction packet として短く保つ。この文書は、その指向性を実際の業務設計手順へ落とす時に読む。

## Core Loop

Biz-compilerは、業務設計を経験的に改善する。

1. 業務を仮説として記述する。
2. 入出力、gate、責任境界、provenance、confidenceを契約として凍結する。
3. fresh executor、shadow run、または実運用で検証する。
4. 不明瞭点、裁量補完、差戻し、near-miss、例外を回収する。
5. 小さく修正し、何が効いたか追跡できる単位で再評価する。
6. 評価が頭打ちになるまで反復する。
7. 本番反映、昇格、scope変更、不可逆操作のgate変更は人間承認を通す。

## Borrowed Pattern From Empirical Prompt Tuning

この方法論のベースは、プロンプト改善の経験的手法を業務設計へ翻訳したものである。

- 書いた本人の自己評価を信用しない。
- 白紙の実行者に実際に使わせる。
- 事前に評価シナリオとcritical要件を固定する。
- 不明瞭点と裁量補完を欠陥信号として回収する。
- 改善は小さく、因果が追える単位で行う。
- うまくいったように見える時ほど過適合を疑う。
- 量的メトリクスだけでなく、質的な詰まり方を主信号にする。

| prompt tuning | Biz-compiler |
|---|---|
| プロンプト品質は作者には分からない | 業務設計の良し悪しは本人だけでは分からない |
| 白紙のsubagentに実行させる | fresh executor / shadow runで検証する |
| 不明瞭点・裁量補完を回収する | 暗黙判断・例外・根回し・差戻しを回収する |
| critical要件を先に固定する | 不可逆性・権限境界・出力契約・承認条件を先に固定する |
| hold-outで過適合を見る | 別案件・別担当・near-missで汎化を疑う |

## Practical Reading Rule

この文書は、すべての会話開始時に読むものではない。

読むのは、次の作業に入る時である。

- phase設計をする時
- ENCRSや業務分解を設計する時
- fresh executor / shadow run を組み込む時
- 70/80の運用改善ループを設計する時
- `COMPASS.md` のheadingを具体的な手順へ翻訳する時
