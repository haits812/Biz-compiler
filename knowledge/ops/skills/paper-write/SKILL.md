---
name: paper-write
description: Use when Biz-compiler repoでpaper-write、論文を書いて、研究論文ドラフト、academic/research paper、LaTeX manuscript、論文骨子、研究稿、引用付き論文、PDF/LaTeX原稿の作成・修復・コンパイルを依頼された時。普通の業務文書、Web調査レポート、ブログ、要約、スライド、意思決定メモには使わない。OpenSquillaのmeta-paper-writeからmeta-とruntimeを外し、論文/研究稿向けのcontract、citation、figure/table placeholder、length/citation gate作法を移植する。
---

# Paper Write

## 範囲

これは、学術論文、研究稿、LaTeX原稿、論文骨子、引用付きpaper draftを作るrepo-local Skillである。

OpenSquillaの `meta-paper-write` を参考にするが、`kind: meta`、`composition.steps`、`meta_invoke`、OpenSquilla runtimeは導入しない。ここでは、論文作成の工程を通常の `SKILL.md` 手順として扱う。

現時点では自然発火を広げすぎない。普通の業務文書や長文作成は対象外にする。ユーザーが論文、研究論文、academic paper、LaTeX manuscript、PDF compile、paper-write を明示した時に使う。

## 使う時

- 研究論文やacademic paperの骨子、草稿、LaTeX原稿を作る。
- compact paper skeletonを作る。
- full manuscriptを作る。
- 既存LaTeX原稿を修復する。
- LaTeX/PDFコンパイルの前提確認やhandoffを作る。
- 引用、figure/table plan、実験設計、citation integrityが重要な文章を作る。

## 使わない時

- 普通の提案書、README、手順書、業務設計書、社内文書。
- Web調査レポート、意思決定メモ、比較ブリーフ。これは `web-research-to-report` の領域。
- ブログ、コピー、軽い文章作成。
- 論文の要約だけ。
- スライド作成。

## Modes

最初にmodeを決める。

| Mode | 使う時 | 方針 |
|---|---|---|
| `COMPACT_SKELETON` | 普通の「論文を書いて」「paper draft」 | デフォルト。短く、構造と引用を持つ骨子にする |
| `FULL_MANUSCRIPT` | full、long-form、publication-ready、8ページ以上、section-by-sectionを明示 | sectionごとに書き、統合とgateを厚くする |
| `REPAIR_EXISTING` | 既存原稿の修復 | 与えられた原稿を正本として直す |
| `COMPILE_ONLY` | 既存LaTeXをコンパイルしたいだけ | 原稿作成せず、コンパイル前提とblockerを確認する |

追加質問は、topicが無い時、またはユーザーが明示的にヒアリングを求めた時だけにする。ページ数、言語、読者、引用数は合理的なdefaultを置いて進める。

## Workflow

| Step | 目的 | 出力 |
|---|---|---|
| 1. paper collect | topic、mode、language、target pages、audience、citation targetを抽出する | first-pass brief |
| 2. clarify gate | topic不足など、進められない時だけ聞く | clarification or assumptions |
| 3. paper contract | 明示情報と補足回答を統合し、paper contractを固定する | `PAPER_CONTRACT` |
| 4. paper preferences | 長さ、引用方針、venue style、section配分を決める | planning contract |
| 5. academic source search | academic向け検索語に変換し、arXiv/ACL/ACM/OpenReview/IEEE等を優先して探す | source candidates |
| 6. bibliography/source pack | cite key候補とsource packを作る。足りない場合はgapを明示する | `SOURCE_PACK`, `REFERENCES_BIB` |
| 7. experiment design | RQ、仮説、変数、dataset、baseline、metricsを設計する | experiment plan |
| 8. figure/table placeholders | 図表計画をLaTeX placeholderにする。数値は捏造しない | figure/table blocks |
| 9. analysis outline | 図表とanalysis dimensionを結び、結果章の骨格を作る | analysis outline |
| 10. outline | 論文全体の構成を作る | paper outline |
| 11. citation plan | claimへcite keyを割り当てる。存在しないkeyは使わない | citation plan |
| 12. writing plan | sectionごとの役割、語数、claim、cite keyを固定する | writing blueprint |
| 13. section drafting | full modeではsectionごとに書く | section drafts |
| 14. assemble | sectionを統合し、重複、用語、論旨を揃える | manuscript package |
| 15. gates | consistency、length、citation map、citation integrity、LaTeX sanitizerを通す | gate results |
| 16. deliver | PDF/LaTeXを作れる時だけ作り、作れない時はhandoffを出す | final delivery |

## Citation Rules

- cite keyは `REFERENCES_BIB` またはsource packに存在するものだけ使う。
- citation targetは固定値にせず、target length、source availability、audienceから決める。
- primary claimは弱いsourceだけで支えない。
- citation mapを作り、invalid / weak / unused を確認する。
- URL、DOI、arXiv eprintなど検証可能な識別子が無い引用は弱いものとして扱う。

## Figure / Table Rules

- 図表はResearch Question、Hypothesis、Analysis Dimensionに接続する。
- decorativeな図表を作らない。
- 実験結果、スコア、割合、latency、costなどの数値を捏造しない。
- 実データが無い場合、表の値は `---` または `<TBD>` にする。
- placeholderであることが分かるLaTeX blockにする。

## Quality Gates

最終出力前に確認する。

| Gate | 見ること |
|---|---|
| consistency | topic、claim、terminology、section間の論旨が揃っているか |
| paper length | target pages/word budgetに対して短すぎないか |
| citation map | cite key、使用回数、title、URL/DOI/arXiv、source qualityを見られるか |
| citation integrity | invalid keyが無いか、primary claimがweak sourceだけでないか |
| LaTeX sanitizer | process text、markdown fences、debug logsが原稿に混ざっていないか |
| compile readiness | PDFを作れる前提が揃っているか。揃わないなら作ったふりをしない |

## Output Contract

### Compact skeleton

- title
- abstract draft
- introduction outline
- related work plan
- method outline
- experiment/figure/table placeholders
- analysis outline
- limitations / threats to validity
- citation plan / source gaps

### Full manuscript

- paper contract
- writing plan
- section drafts or assembled manuscript
- references / citation map
- quality gate summary
- PDF/LaTeX output only when actually generated

### Compile-only

- compile readiness
- blockers
- next command or handoff
- do not invent generated PDF

## Guardrails

- 実験結果を捏造しない。
- 存在しない引用キーを使わない。
- source packに無い論文を引用したことにしない。
- topic不足のまま原稿を作らない。
- PDFを作っていないのに、生成済みと言わない。
- `xelatex` / `bibtex` 等が使えない場合は、compile blockerとして扱う。
- 普通の業務文書作成へ勝手に適用しない。

## Provenance

このSkillは OpenSquilla `meta-paper-write` の工程設計を参考に、Biz-compiler用の通常repo-local Skillとして再構成したものである。OpenSquilla runtimeやMetaSkill frontmatterは移植しない。
