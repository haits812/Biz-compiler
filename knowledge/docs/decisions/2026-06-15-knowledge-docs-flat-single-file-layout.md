# 2026-06-15: knowledge docs の単体カテゴリは直置きmdにする

## Status
Accepted

## Context

`knowledge/docs/` 配下に `lexicon/README.md`、`casebook/README.md`、`evaluation/README.md` のようなREADMEだけのフォルダがあり、人間側から見ると「なぜフォルダなのか」が分かりづらかった。

`meta/` や `decisions/` のように複数ファイルが増える置き場はフォルダでよい。一方で、単語表や薄いカテゴリ入口は、最初からフォルダを作る必要がない。

## Decision

次の単体カテゴリは `knowledge/docs/` 直下のMarkdownファイルにする。

- `knowledge/docs/lexicon.md`
- `knowledge/docs/casebook.md`
- `knowledge/docs/evaluation.md`

次のように、複数ファイルが自然に増える置き場はフォルダのまま維持する。

- `knowledge/docs/meta/`
- `knowledge/docs/decisions/`
- `knowledge/docs/requirements/`
- `knowledge/docs/ir/`
- `knowledge/docs/method/`

## Consequences

- read routingは「カテゴリ」ではなく実際の読み先を示す。
- `lexicon` のような単語表は1ファイルとして見つけやすくなる。
- `casebook` や `evaluation` が将来大きくなった場合は、その時点でフォルダ化を再検討する。
- 過去のdecision record内に残る旧パスは、当時の判断記録として扱う。