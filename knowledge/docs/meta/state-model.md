# State Model v0

このファイルは、Biz-compilerで使う状態語彙を混ぜないためのメタ土台である。

状態には少なくとも3系統ある。これらを同じ列や同じ意味で扱わない。

## 3つの状態系統

| 系統 | 何の状態か | 値 | 正本の主な場所 |
|---|---|---|---|
| 整備状態 | artifactやメタ土台が使える状態か | `未整備` / `一部あり` / `整備済み` / `廃止` | `knowledge/docs/meta/README.md` |
| 主張状態 | 設計判断や業務理解がどれだけ確からしいか | `仮説` / `決定済み` / `検証済み` / `却下` | `knowledge/docs/decisions/`, IR, ledger |
| pending運用状態 | 未確定メモ候補が正式反映まで進んだか | `pending` / `approved` / `applied` / `rejected` | `knowledge/pending/`, `knowledge/journal/`, `knowledge-curation` Skill |

## 整備状態

| 状態 | 意味 | 使い方 |
|---|---|---|
| `未整備` | 必要性は見えているが、正本artifactがまだない | 台帳上の不足として残す |
| `一部あり` | 断片や既存運用はあるが、単独で参照できる形に整理されていない | 既存ファイルを併読しながら使う |
| `整備済み` | v0として作業者が読んで使える | 完璧ではなく、現時点の運用に耐えるという意味 |
| `廃止` | 以前は必要だったが、現在の設計では使わない | 消した理由と代替を残す |

基本遷移:

```text
未整備 -> 一部あり -> 整備済み -> 廃止
```

`整備済み` は完成ではない。後から分割、改名、JSON化、validator化されることはある。

## 主張状態

| 状態 | 意味 | 使い方 |
|---|---|---|
| `仮説` | まだ観測・検証されていない判断 | 業務理解、蒸留物、To-Be案の初期値 |
| `決定済み` | このrepoの運用上、いったん採用した判断 | Compass、Decision、IR draftなど。Memoryは決定履歴の置き場にしない |
| `検証済み` | fresh executor、shadow run、運用ログ、evalなどで確認された判断 | 昇格、gate緩和、正式IRに近い扱い |
| `却下` | 採用しないと決めた判断 | Decisionやjournalに理由を残す |

基本遷移:

```text
仮説 -> 決定済み -> 検証済み
仮説 -> 却下
決定済み -> 却下
```

`決定済み` は真実ではない。Biz-compilerでは、業務設計は最初は仮説であり、観測と反例で検証する。

## pending運用状態

| 状態 | 意味 | 使い方 |
|---|---|---|
| `pending` | AIまたは作業者が提案した未承認候補 | `knowledge/pending/` に置く |
| `approved` | 人間が正式反映してよいと認めた候補 | まだ正式ファイルへ反映済みではない |
| `applied` | 正式ファイルへ文脈込みで反映済み | `knowledge/journal/pending-applied/` へ移す |
| `rejected` | 採用しないと決めた候補 | `knowledge/journal/pending-rejected/` へ移す |

基本遷移:

```text
pending -> approved -> applied
pending -> rejected
approved -> rejected
```

`approved` と `applied` を混ぜない。承認済み候補を機械的に本文へ追記してはいけない。

## 混同禁止ルール

- `未整備` はartifactの状態であり、内容の真偽を表さない。
- `仮説` は主張の状態であり、ファイルが存在するかどうかを表さない。
- `approved` はpending候補の承認状態であり、正式反映済みを意味しない。
- `整備済み` の文書内に `仮説` の主張が含まれることはあり得る。
- `検証済み` の主張を含むartifactでも、artifact自体が `一部あり` のままなことはあり得る。
- 台帳の `状態` 列にpending運用状態を入れない。
- IRや業務ledgerの `confidence` を、メタ土台の `整備済み` と混ぜない。

## 使う場面

| 場面 | 使う状態系統 |
|---|---|
| `knowledge/docs/meta/README.md` の台帳更新 | 整備状態 |
| 業務理解、設計判断、IR属性の確からしさ | 主張状態 |
| 即時メモ候補の承認・適用管理 | pending運用状態 |
| session/subagent briefで未確認事項を置く | 主張状態 |
| phase-local雛形があるかどうかを見る | 整備状態 |

## 更新ルール

状態語彙を増やす場合は、先にこのファイルへ追加し、`knowledge/docs/meta/README.md` に影響するか確認する。`MEMORY.md` には状態語彙の重複を増やさない。
