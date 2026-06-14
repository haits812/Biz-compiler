# Session Brief v0

このファイルは、通常会話や通常作業の開始時に、今回だけの仮ゴールと作業範囲を揃えるためのbrief型である。

`COMPASS.md` とは別物である。Compassは作業者の思考の向き、価値順位、疑うものを渡すheadingであり、session briefは今回の作業の仮ゴール、現在地、成果物、完了条件を渡す作業単位のメモである。

## 目的

- 会話の途中で「今どこだっけ」をすぐ戻せるようにする。
- 仮ゴール、scope、読むもの、成果物、完了条件を分ける。
- session中の判断をCompassへ混ぜない。
- 必要な更新対象を最初に意識する。

## 型

```markdown
# Session Brief

## 仮ゴール
今回いったん目指す状態を書く。恒久ゴールではない。

## 現在地
Hello World、直近の差分、作業中ファイルなどから分かる現在地を書く。`MEMORY.md` は現在地の正本ではない。

## Scope
今回触る範囲を書く。

## Out of Scope
今回触らない範囲を書く。

## 読むもの
必読ファイルと、作業種別に応じた追加read routingを書く。

## 成果物
このsessionで作る、直す、確認するものを書く。

## 完了条件
何をもってこのsessionを閉じてよいかを書く。

## 更新対象
作業後に同期確認するファイルや台帳を書く。

## 未確認 / 仮説
まだ断定できないことを書く。

## Stop条件
勝手に進めず止める条件を書く。
```

## 記入ルール

| 項目 | 書き方 |
|---|---|
| 仮ゴール | 一文で書く。ゴールは変わってよい |
| 現在地 | `Hello,world.md` を優先する。`MEMORY.md` は現在構成ではなく普段の未整理メモとして見る |
| Scope | ファイル、ディレクトリ、phase、判断対象を具体化する |
| Out of Scope | 今回やらないことを明示する |
| 読むもの | `knowledge/docs/README.md` のread routingを使う |
| 成果物 | ファイル名や確認結果として残るものにする |
| 完了条件 | 「作った」だけでなく、確認、台帳更新、残リスクを含める |
| 更新対象 | Hello World、meta ledger、Decision、必要な正本を確認する。`MEMORY.md` は重複を増やしていないかだけ確認する |
| 未確認 / 仮説 | 主張状態の `仮説` として扱う |
| Stop条件 | behind/diverged、危険な外部作用、scope逸脱などを書く |

## Compassとの境界

| 項目 | Compass | Session brief |
|---|---|---|
| 役割 | 思考の指向性 | 今回の作業範囲 |
| 寿命 | 長い | 短い |
| 読ませる相手 | 全作業者、subagent | 今回の担当者 |
| 内容 | 価値順位、疑うもの、判断prior | 仮ゴール、成果物、完了条件 |
| 置き場 | `COMPASS.md` | 必要に応じて会話、journal、task note |

session briefで出た恒久的な制約や判断priorは、即時メモ候補として扱い、いきなりCompassへ混ぜない。

## 更新ルール

session brief型を変える場合は、`knowledge/docs/meta/README.md`、`knowledge/docs/README.md`、必要なら `subagent-brief.md` を確認する。`MEMORY.md` は正本重複を増やしていないかだけ確認する。
