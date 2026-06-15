---
name: web-research-to-report
description: Use when Biz-compiler repoでWeb調査を出典付きレポート、ブリーフ、意思決定メモにする、調べて根拠付きでまとめて、出典付きで比較して、最新情報を調査して報告して、市場/技術/選択肢/リスクをsource-backedに整理してと言われた時。単発の事実確認、与えられたメモだけの要約、普通の文章作成には使わない。OpenSquillaのmeta-web-research-to-reportからmeta-とruntimeを外し、普通のrepo-local Skillとして工程作法を移植する。
---

# Web Research To Report

## 範囲

これは、Web調査を出典付きのレポート、ブリーフ、意思決定メモへ変換するrepo-local Skillである。

OpenSquillaの `meta-web-research-to-report` を参考にするが、`kind: meta`、`composition.steps`、`meta_invoke`、OpenSquilla runtimeは導入しない。ここでは、工程を通常の `SKILL.md` 手順として扱う。

自然発火してよい。ユーザーが「調べて」「比較して」「出典付きで」「最新情報で」「意思決定メモにして」「根拠付きで報告して」のように、Web由来の根拠を必要とする成果物を求めたら使う。

## 使う時

- 出典付き調査レポートを作る。
- 市場、技術、製品、競合、選択肢、リスクを調べてブリーフにする。
- 意思決定メモ、比較メモ、推薦メモを根拠付きで作る。
- 最新情報、価格、規約、仕様、ニュースなど、Web確認が必要な内容をまとめる。
- 「調べてから報告して」「source-backedで」「根拠付きで」と言われた。

## 使わない時

- 単発の事実確認だけで足りる。
- ユーザーが渡した資料やメモだけを要約する。
- 普通の文章作成、言い換え、翻訳、コピー作成。
- 学術論文やLaTeX原稿作成。これは `paper-write` の領域。
- Web確認が不要な雑談や設計相談。

## 基本方針

- いきなり本文を書かない。まず調査契約を作る。
- 追加質問は最小限にする。広すぎる時、または意思決定文脈が欠けている時だけ聞く。
- source target と live-verified source を混ぜない。
- 一次情報、公式情報、発行日、直接性を優先する。
- major claim にはsourceか明示的な caveat を付ける。
- current facts を推測で埋めない。Web確認できない場合は evidence limits として出す。

## Workflow

必ず次の順で進める。急ぎでも `source_quality` と `final_audit` は省略しない。

| Step | 目的 | 出力 |
|---|---|---|
| 1. report contract | 依頼から目的、読者、判断文脈、レポート種別、長さ、言語、引用形式、前提を決める | `REPORT_CONTRACT` |
| 2. clarification gate | topicが広すぎる、または意思決定文脈が不足している時だけ質問する | 質問または `ASSUMPTIONS` |
| 3. report mode | `QUICK_DECISION_MEMO` / `DEEP_REPORT` / `EXPORT_REQUESTED` を選ぶ | `REPORT_MODE` |
| 4. source targets | 公式・準公式・一次情報として確認すべき対象を列挙する | `SOURCE_TARGETS` |
| 5. live research | Web検索で現在のsourceを集める。検索失敗時は失敗を隠さない | raw source candidates |
| 6. source quality | 重複、SEO、弱い二次情報を落とし、8-15件程度のsource packにする | `SOURCE_PACK` |
| 7. outline | 読者と目的に合う構成を作る | outline |
| 8. draft | source packとoutlineから本文を作る | draft |
| 9. source-to-claim audit | major claim がどのsourceで支えられるか確認する | claim map |
| 10. quality gate | 出典漏れ、古い情報、断定しすぎ、弱い根拠を修復する | repaired draft |
| 11. final audit | 内部手順、ツール名、ファイル生成の虚偽、sourceなし断定を消す | final report |

## Source Pack Contract

source pack は次の形で持つ。

```text
[S1] Title - URL
Credibility: なぜ使えるか
Supports: どの主張を支えるか
Evidence type: direct | indirect | background
Freshness: 日付または確認日
Caveat: 注意点またはnone
```

ルール:

- URLが無いsourceは、原則としてsource packに入れない。
- 公式、一次情報、標準文書、製品docs、規制当局、企業発表を優先する。
- Reddit、匿名掲示板、generic SEO listicleは主証拠にしない。
- 二次まとめ記事は `indirect` または `background` として扱う。
- 価格、対応可否、仕様、法規制、日程は古い可能性が高いので日付を確認する。

## Output Contracts

### Decision memo

意思決定メモでは、原則として次を出す。

```text
Assumptions / Decision Context
Recommendation
Key Findings
Practical Risks / Tradeoffs
Evidence Limits
Next Steps
Sources
```

### Research report / brief

調査レポートやブリーフでは、原則として次を出す。

```text
Executive Summary
Scope / Assumptions
Key Findings
Evidence
Risks / Limits
Recommendation or Options
Sources
```

ユーザーが別形式を指定した場合はそれに合わせる。ただし Sources / Evidence Limits は消さない。

## Guardrails

- major claim をsourceなしで断定しない。
- searchできなかった時に、調べたふりをしない。
- source targets を live-verified source として扱わない。
- 内部workflow、Skill名、ツール失敗、workspace pathを最終回答に出さない。
- ファイルを作っていないのに、保存・添付・生成済みと言わない。
- Web情報が時間依存の場合は、確認日または発行日を明示する。
- 高リスク領域では、判断材料として出し、専門的助言として断定しない。

## Validation

最終回答前に確認する。

- 依頼目的、読者、出力形式に合っている。
- Sourcesに、本文で引用したsource IDがすべてある。
- source IDが存在しないclaimを引用していない。
- direct / indirect / background の弱さが本文で反映されている。
- 最新性が重要な情報は日付を確認している。
- Evidence Limits がある。
- 内部手順やツール名が最終回答に漏れていない。

## Provenance

このSkillは OpenSquilla `meta-web-research-to-report` の工程設計を参考に、Biz-compiler用の通常repo-local Skillとして再構成したものである。OpenSquilla runtimeやMetaSkill frontmatterは移植しない。
