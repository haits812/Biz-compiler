# 00-entry

## Purpose

00-entry は、業務候補を Biz-compiler のコンパイル対象として扱ってよいかを初期問診するphaseである。

ここでは要求定義を完成させない。As-Isを分解せず、automation案を決めず、executor routingも行わない。10-source-intake が source を集められるだけの入口情報、scope、材料、初期risk、stop条件を揃える。

00はファーストオピニオンである。深く聞く対象は業務全体ではなく、10へ進めるための入口判断に限定する。

## Operating Assumption

口頭ヒアリング入口では、相手が要件や用件を整理して話せる場合もある。ただし、多くの場合は言葉足らず、暗黙前提、未確認の自己整理、代理説明、現物不足のどれかが混ざる前提で設計する。

00-entry は、整った要求だけを受け取る工程ではない。曖昧な発話、頷き、代理説明、現物不足を、source候補、scope、risk、low confidence仮説へ分ける受付/初期トリアージとして扱う。

したがって、00担当は相手の自己整理や合意反応をそのまま確定扱いしない。こちらで補った業務名、出力案、success guess、rough IOは、source確認まで `confidence = low` の仮説として分離する。

## Position

| From | This phase | To |
|---|---|---|
| user request / rough idea | 業務候補を受付し、entry_type、scope、材料、初期riskを切る | 10-source-intake |

## Inputs

| Input | 内容 |
|---|---|
| user request | 「この業務を自動化したい」「もっと良くしたい」「これから業務を作りたい」などの入口発話 |
| existing materials | マニュアル、手順書、ツール、画面、メール、管理表、直近成果物、ログ |
| concept materials | 構想メモ、参考例、想定ユーザー、想定入力/出力、成功イメージ |
| conversation context | その場の会話、過去メモ、既存decision、Biz-compiler語彙 |

## Outputs

| Output | 置き場 | 内容 |
|---|---|---|
| entry packet | `artifacts/entry-packet.md` | entry_type、intent、仮ゴール、actor、10へ渡す要約 |
| scope memo | `artifacts/scope-memo.md` | scope in/out、境界、保留、stop候補 |
| initial risk memo | `artifacts/initial-risk-memo.md` | 外部送信、発注/確定/削除、個人情報、契約情報、N-interface候補 |
| source candidates | `artifacts/source-candidates.md` | 10-source-intakeで取得・確認する材料候補 |
| later phase notes | `artifacts/later-phase-notes.md` | 00では深掘りしないが後続phaseへ送る話 |
| phase contract | `contract.md` | 00が凍結するentry contract |
| handoff packet | `handoff.md` | 10へ渡す最小情報 |

## Phase Context

`_context/` は、このphaseをsubagentや作業者が実行・実装するための補助文脈である。業務成果物の正本ではないが、業務フォルダへコピーされた後のagentにも効く想定で、phase-local contextとして置く。

| File | 役割 |
|---|---|
| `_context/README.md` | context群の読み方 |
| `_context/phase-boundary.md` | 00で聞くこと、聞かないこと、後続phaseへ送ること |
| `_context/grill-rules.md` | grill-meを00へ翻訳した質問運用ルール |
| `_context/sorting-rules.md` | 回答をどの箱へ入れるか |
| `_context/anomaly-rules.md` | 入口で拾う違和感、stop/rework条件 |
| `_context/gate-rubric.md` | `entry-gate` とmain review観点 |
| `_context/matt-pocock-skills.md` | grill-me / grill-with-docs / to-prd の00向け翻訳 |
| `_context/subagent-brief.md` | 00担当subagentへ必ず渡すdispatch packet |

## Workflow

1. `COMPASS.md`、`knowledge/docs/lexicon.md`、`template/00-entry/_context/` を読む。
2. `questions.md` の入口質問で `entry_type` を `existing_work` / `new_work` / `unclear` に分類する。`unclear` はdraft/rework状態であり、10へhandoffしない。
3. `intent`、actor/owner候補、粗いinput/output、scope in/out、材料候補、初期riskを集める。
4. 後続phaseに属する話は深掘りせず、`artifacts/later-phase-notes.md` へ送る。
5. `artifacts/source-candidates.md` に10で確認する材料を置く。
6. `checks.md` と `_context/gate-rubric.md` の `entry-gate` で、次の実物確認へ進めるか、00内で追加質問するか、停止するかを判定する。
7. `rework` の場合は00内で追加質問して再判定する。`pass` / `defer` / `stop` のいずれかになるまで、00は完了扱いにしない。
8. `pass` / `defer` かつ `entry_type` が `existing_work` / `new_work` に確定している場合だけ `handoff.md` を埋め、10-source-intake へ渡す。`stop` は停止理由を残して閉じる。

## Entry Gate

00の出口では、`entry-gate` で次を確認する。

| Check | 通す条件 |
|---|---|
| entry type | `existing_work` / `new_work` のどちらかに切れている。`unclear` はrework理由でありhandoffしない |
| target | 何を業務候補として扱うか一文で言える |
| material path | 既存型は現物候補、新規型は構想/参考/想定シナリオ候補がある |
| scope | in-scope / out-of-scope / undecided が粗く分かれる |
| risk hints | 外部影響、sensitive、不可逆操作の有無を初期確認している |
| source handoff | 次に確認するsource候補と未確認事項がある |
| boundary | 20以降の詳細を00で決め切っていない |

結果は `pass` / `defer` / `rework` / `stop` のいずれかにする。

| Result | 00の扱い | 次の動き |
|---|---|---|
| `pass` | terminal | 00完了。通常のsource確認として10-source-intakeへ進む |
| `defer` | terminal | 00完了。`entry_type` が切れており、未確認事項を明記して10-source-intakeで検証する |
| `rework` | non-terminal loop | 00未完了。00内で追加質問し、再判定する |
| `stop` | terminal | 00完了。Biz-compiler対象外または危険な依頼として止める |

`rework` は最終出口ではない。実運用では `rework` で会話を閉じず、この初期状態なら00内で追加質問が必要、というループ指示として扱う。source候補があるだけでは `pass` にしない。

## Do Not

- 00で要求定義を完成させない。
- 00でAs-Is手順を詳細分解しない。
- 00でENCRS dispositionを決めない。
- 00でautomation、Skill、script、human routingを決めない。
- 00でIR、contract schema、manifestを設計しない。
- 00でconsent viewやvalidation planを作らない。
- 「全部自動化したい」を、そのまま業務scopeとして扱わない。
- 資料がない新規構想を即停止しない。仮説として扱い、10へ検証材料を渡す。
