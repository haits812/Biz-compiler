# Phase-local Missing Items

このメモは、数字工程 `template/<数字phase>/` に属するが、まだ用意していないものを一時的に整理する。

ここに含めるのは、業務フォルダへコピーされた後に各phase内で使うものだけ。Lexicon、状態分類、session brief、subagent brief、read routing などの横断メタ土台はここに含めない。

## 全phase共通で未整備

各 `template/<数字phase>/` に最低限ほしいもの:

- `README.md`: phaseの目的、入力、出力、完了条件、次phaseへのhandoff
- `contract.md` または `contract.yaml`: そのphaseが凍結/生成する成果物契約
- `questions.md`: 会話・ヒアリングで確認する項目
- `artifacts/`: そのphaseで作る成果物の雛形
- `checks.md`: phase完了前に見る検査項目
- `handoff.md`: 次phaseへ渡す情報の形

## 00-entry

入口のv0雛形は作成済み。

既存:

- `template/00-entry/README.md`: phase目的、入力、出力、workflow、entry-gate
- `template/00-entry/contract.md`: entry contract雛形
- `template/00-entry/questions.md`: 初期問診質問票
- `template/00-entry/checks.md`: phase出口チェック
- `template/00-entry/handoff.md`: 10-source-intakeへのhandoff packet
- `template/00-entry/artifacts/entry-packet.md`: entry_type、intent、actor、rough goalの一枚化
- `template/00-entry/artifacts/scope-memo.md`: scope in/out/undecidedのメモ
- `template/00-entry/artifacts/initial-risk-memo.md`: 初期risk hint
- `template/00-entry/artifacts/source-candidates.md`: 10で確認する材料候補
- `template/00-entry/artifacts/later-phase-notes.md`: 00で決めず後続phaseへ送る話
- `template/00-entry/_context/README.md`: 00実行補助contextの読み方
- `template/00-entry/_context/phase-boundary.md`: 00で聞く/聞かない/送る先
- `template/00-entry/_context/grill-rules.md`: grill-meの00向け運用
- `template/00-entry/_context/sorting-rules.md`: 回答分類ルール
- `template/00-entry/_context/anomaly-rules.md`: 違和感、stop/rework条件
- `template/00-entry/_context/gate-rubric.md`: entry-gate、subagent自己チェック、main review観点
- `template/00-entry/_context/matt-pocock-skills.md`: grill-me / grill-with-docs / to-prdの翻訳
- `template/00-entry/_context/subagent-brief.md`: 00担当subagent brief雛形

今後の候補:

- 00-entry完了判定validator
- entry packet / scope memo / risk memo のschema化
- 実業務作成時にoutput側へコピーするphase runner

## 10-source-intake

ソース取得のv0雛形は作成済み。

既存:

- `template/10-source-intake/README.md`: phase目的、入力、出力、workflow、Contract Gate
- `template/10-source-intake/contract.md`: source intake contract雛形
- `template/10-source-intake/questions.md`: ヒアリング/観測質問票
- `template/10-source-intake/checks.md`: phase出口チェックとcompletion reviewer subagent観点
- `template/10-source-intake/handoff.md`: 20-decompose-encrsへのhandoff packet
- `template/10-source-intake/artifacts/source-inventory.md`: 観測対象一覧
- `template/10-source-intake/artifacts/intake-log.md`: ヒアリング/観測ログ
- `template/10-source-intake/artifacts/fact-register.md`: 事実、本人説明、推測、未確認の主張台帳

今後の候補:

- source inventory / fact register のschema化
- 10-source-intake完了判定validator
- 実業務作成時にoutput側へコピーするphase runner

## 20-decompose-encrs

分解とENCRSで未整備:

- As-Is手順一覧の雛形
- IPO分解worksheet
- ENCRS disposition表
- N-interface発火候補表
- orphan手順を残さないためのチェック
- 例外、差戻し、判断分岐の記録欄

## 30-route-executor

実行者振り分けで未整備:

- executor routing matrix
- automation / script / Skill / orchestrator / human / external の判定表
- autonomy候補とgate候補の対応表
- 不可逆操作、責任境界、復旧可能性のチェック
- human-onlyに残す理由の記録欄

## 40-ir-freeze

IR凍結で未整備:

- IR draft/freeze雛形
- nodeごとの input / process / output / gate / executor / autonomy 記録欄
- provenance / confidence の記録欄
- observed / hypothesized / negotiated の区分
- manifest差分の雛形
- schema conformance checklist

## 50-consent

生成と同意で未整備:

- 同意パケットの雛形
- flowchart JSON と IR の対応メモ
- 人間が見る粗い契約と、node payloadに残す詳細仕様の分離ルール
- approval recordの雛形
- scope内/外、N-interface、HITL gateを確認するチェック

既存:

- `template/50-consent/pipeline-flowchart/pipeline-flowchart.html`

## 60-validation

検証で未整備:

- fresh executor task brief
- validation plan
- type/contract check結果の記録欄
- test fixture / sample input / expected output の置き方
- near-miss / failure / rework の記録欄
- 合格、保留、差戻しの判定基準

## 70-improvement

改善で未整備:

- drift / near-miss / 差戻しログの雛形
- improvement proposalの雛形
- eval結果と改善効果の記録欄
- 昇格/降格候補の記録欄
- 収束条件、再評価タイミング、反例探索の記録欄
- 改善案を本番反映する前のapproval checklist

## 80-operation

運用で未整備:

- runbook雛形
- operation ledger / event log の置き方
- schedule / trigger / owner / escalation の記録欄
- kill switch / stop condition の記録欄
- audit log / approval history / manifest revision の紐付け
- 定期レビューと再コンパイル要否の判定欄

## ここに含めないもの

次はphase-localではなく、横断メタ土台または `_shared/` 側で扱う。

- Lexicon: `knowledge/docs/lexicon.md`
- 状態分類: 決定済み / 仮説 / 未検証 / pending / accepted / applied など
- session brief: 今回の作業の仮ゴール、scope、完了条件
- 横断subagent brief: 委譲先への仮ゴール、Compass、必要資料、成果物契約。phase固有の実行briefは `template/<phase>/_context/` に置いてよい
- read routing: どの作業で何を追加で読むか
- schema / validator / runner: 原則 `template/_shared/internal/`
