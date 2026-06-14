# 数字phaseと知識グループを主語にしたディレクトリ構成を採用する

- Status: Accepted
- Date: 2026-06-14

## Context

Biz-compilerには、phaseごとのテンプレート、業務ごとの成果物、schema/runner/validator/toolなどの横断部品、要求・決定・pending・journalなどの知識がある。これらをリポジトリ直下に並べると、人間が「どの数字phaseを実行すればよいか」「業務ごとの成果物がどこにあるか」を追いにくくなる。

一方で、docs / pending / journal は近いが、確定済み、未承認、作業ログというステータスが違うため混ぜてはいけない。したがって、知識系は `knowledge/` の下でグループ化しつつ、内部の役割は分離する。

## Decision

人間が見る主要構成は次を基本形にする。

```text
template/
  _shared/
    internal/
    scripts/
  00-entry/
  10-source-intake/
  20-decompose-encrs/
  ...
  50-consent/
    pipeline-flowchart/
  ...
  80-operation/

output/
  Biz-001-業務名/  # 業務作成時に採番して作る。プレースホルダは置かない。
    _shared/
    00-entry/
    10-source-intake/
    20-decompose-encrs/
    ...
    80-operation/

knowledge/
  docs/
  pending/
  journal/
  ops/
```

`template/` は業務フォルダの原型である。業務作成時に `output/Biz-001-業務名/` へコピーされる前提で、phase別の雛形と `_shared/` を置く。

`template/_shared/` は、phase横断で業務フォルダ内から使う内部部品、runner、validator、tool、実行スクリプトの置き場である。

`knowledge/` は、このリポジトリを作るための知識置き場である。`docs/`、`pending/`、`journal/`、知識管理用 `ops/` は混ぜずに `knowledge/` 配下で分ける。

会話UIやCLIは、まず `template/<phase>` と、業務作成時に採番された `output/Biz-001-業務名/<phase>` を主語にして説明・実行する。`template/_shared/` と `knowledge/` は補助構造であり、人間向けの主要導線にしない。

## Prohibited

- `output/` 直下に `example-business-id`、`_business-id`、サンプル業務、プレースホルダ業務フォルダを作らない。
- 業務IDフォルダを、構成説明や将来想定のためだけに先作りしない。
- リポジトリ直下に `docs/`、`pending/`、`journal/`、`samples/`、`internal/`、`scripts/`、`schemas/`、`runner/`、`tools/`、`validators/`、`phase-packs/` を増やさない。
- フェーズ50同意ビューHTMLを `samples/` に置かない。`template/50-consent/pipeline-flowchart/` に置く。
- 業務フォルダへコピーされる実行部品を `knowledge/` に置かない。
- 知識管理だけに使う管理コマンドは `knowledge/ops/` に置き、`template/_shared/scripts/` に置かない。

## Consequences

- 人間は数字phaseごとに、雛形と業務別成果物を対応づけて見られる。
- `template/` をコピーすれば、どのテンプレート資産を使ったかが `output/Biz-001-業務名/` 側にも残る。
- phaseごとのコマンド実行や再実行の対象が明確になる。
- 知識系は `knowledge/` にまとまるが、確定・未承認・作業ログは混ざらない。
- 今後ディレクトリを増やすときは、まず `template/`、`output/Biz-001-業務名/`、`knowledge/` のどれに属するかを判断する。

