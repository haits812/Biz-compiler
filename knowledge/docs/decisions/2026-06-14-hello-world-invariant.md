# Hello World を自己記述 invariant として採用する

- Status: Accepted
- Date: 2026-06-14

## Context

Biz-compiler は業務設計OSとして、AIが毎回全量探索せずに現在地へ入れる必要がある。DeckPilot の `docs/architecture.md` は、自己記述インデックスとしてこの問題に近い役割を担っている。

ただし Biz-compiler では、`ONTOLOGY.md` や `map.md` というファイル名を先に固定するよりも、まず「今の状態が分かる」ことが重要である。

## Decision

ルートに `Hello-world.md` を置く。

`Hello-world.md` は、Biz-compiler が自分の現在地を返す最小自己記述であり、最初のスモークテストである。

- Compass は heading。
- Hello World は position。
- 位置と方位が揃って、はじめて航行できる。

最重要 invariant:

> Hello World は嘘をつかない。

`Hello-world.md` は read の入口であり、decide / act の入口ではない。判断は `COMPASS.md`、実行は phase command / template / output 側の責務とする。

## Rules

- ルート構成、読み込み順、`template/`、`knowledge/`、`output/` の業務ID生成ルールを変えたら、同じターンで `Hello-world.md` を更新する。
- `Hello-world.md` には、実際にコンパイルしている個別業務の進行状態を含めない。
- 個別業務の状態は `output/Biz-001-業務名/` 側の phase ledger / artifact / event log に置く。
- 件数や状態を書く場合は、鮮度を明示する。
- `Hello-world.md` が現在地を返せないなら、次の作業へ進まない。

## Consequences

- AIは最初に「今どこか」を確認できる。
- 自己記述が嘘をつく事故を、ひとつの invariant に還元できる。
- 大仰な名前を避け、最小プログラムの比喩で状態確認の入口を持てる。
- 更新運用を怠ると逆に危険な stale map になるため、構成変更時の同時更新が必須になる。
