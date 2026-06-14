# Hello World Gate を採用する

- Status: Accepted
- Date: 2026-06-14

## Context

`Hello,world.md` は Biz-compiler の現在地を返す invariant として採用した。だが、手で更新するだけでは stale な自己記述を防げない。

ユーザーは「ハロワ（のゲート）へゴー」として、Hello World が嘘をつかないための実行可能な検査を求めた。

## Decision

`knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` を追加する。

外から叩くコマンドは1つだけにする。このコマンドは、現在状態から `Hello,world.md` を再生成し、内容を検査し、変更があれば日本語commitとGitHub pushまで行う。

単体実行で次を順番に行う。

- 現在状態から `Hello,world.md` を再生成する。
- `Hello,world.md` が生成結果と一致するか検査する。
- 変更がなければcommit/push不要として正常終了する。
- 変更があれば `git add -A` する。
- `理由`、`確認`、`残リスク` を含む日本語commit messageでcommitする。
- `git push` する。
- push後にpost-checkする。

同時に、次の禁止構成を検査する。

- ルート直下の `docs/`、`pending/`、`journal/`、`samples/`、`internal/`、`scripts/`、`schemas/`、`runner/`、`tools/`、`validators/`、`phase-packs/`
- `template/` の必須phase欠落
- `template/50-consent/pipeline-flowchart/pipeline-flowchart.html` の欠落
- `output/example-business-id/`、`output/_business-id/` などのプレースホルダ業務フォルダ
- `output/` 直下で `Biz-001-業務名` 形式になっていない業務フォルダ

## Rules

- 構成を変えたら、同じターンで `.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1` を実行する。
- GitHubへ上げる時も同じコマンドを使い、ハロワ更新を別依頼にしない。
- gateが失敗する状態で、次の作業へ進まない。
- 実際にコンパイルしている個別業務の進行状態は、引き続き `Hello,world.md` へ入れない。

## Consequences

- Hello World の鮮度を人間の記憶だけに依存しなくなる。
- ルート直下の散らかり、template phaseの欠落、outputのプレースホルダを早期に止められる。
- `Hello,world.md` は構成変更時に再生成されうるため、差分には現在地の更新が含まれる。
- この gate は read / position の検査であり、判断や実行の承認ゲートではない。
