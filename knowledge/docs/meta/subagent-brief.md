# Subagent Brief v0

このファイルは、重たい作業をsubagentや別作業者へ委譲する時のbrief型である。

subagentにも `COMPASS.md` は渡す。ただし、subagentの仮ゴールは作業ごとに別で渡す。Compassは共通のheadingであり、今回の北極星や作業完了条件を代替しない。

## 目的

- 委譲先に、作業の仮ゴール、読むもの、成果物契約、禁止事項を明確に渡す。
- `knowledge/docs/` 全量を読ませず、作業種別に応じた追加資料だけ読ませる。
- subagentの成果物を、親作業へ戻せる形にする。
- Compassとタスク用仮ゴールを混ぜない。

## 必ず渡すもの

- `Hello,world.md`
- `SOUL.md`
- `USER.md`
- `COMPASS.md`
- `knowledge/docs/lexicon.md`
- `MEMORY.md`
- 対象作業に該当する `knowledge/docs/README.md` のread routing
- 対象ファイル

## 型

```markdown
# Subagent Brief

## タスク用仮ゴール
このsubagentが今回だけ目指す状態を書く。

## Compass
`COMPASS.md` を読むこと。必要なら今回特に重視するCompass上のpriorを書く。

## 必読ファイル
必ず読むファイルを列挙する。

## 追加read routing
`knowledge/docs/README.md` に基づき、今回だけ読む追加ディレクトリを書く。

## 成果物契約
返してほしい成果物、形式、粒度、置き場を書く。

## 禁止事項
触ってはいけない範囲、混ぜてはいけない概念、実行してはいけない操作を書く。

## 完了条件
何を確認できたら完了かを書く。

## 戻し方
親作業へどう返すか。要約、差分、ファイル、未確認事項の形を書く。

## 未確認 / 仮説
subagentが断定してはいけないことを書く。
```

## 成果物契約の書き方

| 観点 | 書く内容 |
|---|---|
| 出力形式 | Markdown、表、JSON draft、diff案、調査メモなど |
| 置き場 | 直接編集するのか、提案として返すのか |
| 粒度 | v0でよいのか、実装可能な詳細まで必要か |
| 検証 | どのコマンド、どのread back、どの比較を行うか |
| 未確認 | 断定せず仮説として戻すもの |

## 禁止事項の例

- `COMPASS.md` に具体例、schema、テンプレートを詰め込まない。
- `knowledge/docs/` 全量を読ませない。
- 要求定義を、必要条件なしに初期読み込みやsubagent基本セットへ入れない。
- ユーザーが出した言葉やファイル名を確認なしに別概念へ吸収しない。
- `output/` 直下にサンプル業務やプレースホルダ業務フォルダを作らない。
- `knowledge/ops/` 直下に `.ps1` を置かない。
- 外部作用、commit、push、削除などを委譲先の判断だけで行わない。

## Session briefとの関係

| 項目 | Session brief | Subagent brief |
|---|---|---|
| 対象 | 今回の会話/作業全体 | 委譲された部分作業 |
| 仮ゴール | 親作業の仮ゴール | subagent専用の仮ゴール |
| 読むもの | 親作業に必要なもの | 委譲範囲に絞ったもの |
| 成果物 | session全体の成果物 | 親へ戻す成果物契約 |
| 完了条件 | sessionを閉じる条件 | subagentの戻し条件 |

## 更新ルール

subagent委譲の型を変える場合は、`COMPASS.md` のDelegation Rule、`knowledge/docs/README.md` のSubagent Delegation、`session-brief.md`、`knowledge/docs/meta/README.md` を確認する。`MEMORY.md` は正本重複を増やしていないかだけ確認する。
