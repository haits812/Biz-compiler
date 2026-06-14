# Hello World Gate を採用する

- Status: Accepted
- Date: 2026-06-14

## Context

`Hello,world.md` は Biz-compiler の現在地を返す invariant として採用した。だが、手で更新するだけでは stale な自己記述を防げない。

ユーザーは「ハロワ（のゲート）へゴー」として、Hello World が嘘をつかないための実行可能な検査を求めた。

## Decision

`knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` を追加する。

このコマンドは `Hello,world.md` を現在状態から同期し、検査する。

- `sync`: ルート構成、`template/` phase、`output/` 状態、pending / approved 件数から `Hello,world.md` を再生成する。
- `check`: 現在の `Hello,world.md` が生成結果と一致するか検査する。
- `gate`: `check` の別名として扱う。
- `publish`: `sync`、`check`、`git add -A`、日本語commit、`git push`、post-checkを順番に実行する。

同時に、次の禁止構成を検査する。

- ルート直下の `docs/`、`pending/`、`journal/`、`samples/`、`internal/`、`scripts/`、`schemas/`、`runner/`、`tools/`、`validators/`、`phase-packs/`
- `template/` の必須phase欠落
- `template/50-consent/pipeline-flowchart/pipeline-flowchart.html` の欠落
- `output/example-business-id/`、`output/_business-id/` などのプレースホルダ業務フォルダ
- `output/` 直下で `Biz-001-業務名` 形式になっていない業務フォルダ

## Rules

- 構成を変えたら、同じターンで `.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 sync` を実行する。
- 完了前に `.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 check` を通す。
- GitHubへ上げる時は `.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 publish` を使う。
- `check` が失敗する状態で、次の作業へ進まない。
- 実際にコンパイルしている個別業務の進行状態は、引き続き `Hello,world.md` へ入れない。

## Consequences

- Hello World の鮮度を人間の記憶だけに依存しなくなる。
- ルート直下の散らかり、template phaseの欠落、outputのプレースホルダを早期に止められる。
- `Hello,world.md` は毎日または構成変更時に `sync` されうるため、差分には現在地の再生成が含まれる。
- この gate は read / position の検査であり、判断や実行の承認ゲートではない。


