# compiler repo と output repo の境界を分ける

- Status: Accepted
- Date: 2026-06-14

## Context

Biz-compilerは、個別業務のSkill集ではなく、いろいろな仕事を作るための汎用業務コンパイラとして設計する。このため、Hermesのprocedural memoryやcuratorの発想をそのままこのリポジトリ直下に適用すると、compiler本体の資産と、compilerが生成した業務固有資産が混ざる。

## Decision

このリポジトリは、Biz-compiler本体を作るcompiler repoとして扱う。ここに置くのは、phase contract、IR、schema、validator、同意ビュー、サンプル、共通テンプレート、開発運用ルールである。

個別業務ごとのSkill、workflow、automation、adapter、業務固有テンプレートは、Biz-compilerが生成・整備するoutput repo側の成果物として扱う。

Curatorや棚卸しもrepo種別で分ける。

- compiler repo: 要求、Compass、IR、schema、sample、pending、Decisionを棚卸しする。
- output repo: 生成されたSkill、workflow、adapter、業務固有テンプレート、実行ログを棚卸しする。

Hermesのnarrow waistは参考にするが、そのまま「core toolを細くする」という意味では移植しない。Biz-compilerにおける細い腰は、10番台以降のphaseごとに凍結される契約とIR境界である。

## Consequences

- このrepo直下に個別業務Skillを増やさない。
- 将来Skillやcuratorを扱う場合は、compiler repo向けかoutput repo向けかを先に分ける。
- output repo template v0 が必要になる。そこにSkill/workflow/adapter/curatorの配置規約を置く。
