# MEMORY.md

> このファイルは、普段の会話で出た「覚えといて」をまず置くメモである。定期的に `knowledge-curation` で掃除し、正本化・移動・削除する。

## 役割

- 会話中に次回以降も効きそうなことが出たら、まずここに短く置いてよい。
- ここは未整理メモを含む。書いた時点では正式なルール、決定、ユーザーモデルではない。
- 現在構成、読み込み順、禁止事項、決定履歴、メタ台帳の正本にはしない。
- 長い会話履歴を丸ごと残す場合は `knowledge/journal/` に置く。
- 背景理由つきで採用/却下が決まった判断は `knowledge/docs/decisions/` に移す。

## 未整理メモ

- Contract Gate は独立した大きなgateというより、数字phase末尾に入る完了処理/出口チェックとして設計する候補。各phaseで次へ進める契約条件、検収条件、実行者、scope、rollbackなどが揃ったかを確認する処理として後で整理する。

- Revision/Recompile Model（manifest revision、contract patch、approval再取得、gate降格など）は、70/80の運用・改善ループに到達してから整備する。現時点の先行メタ土台からは外し、phase handoff、gate policy、evidence/confidenceを先に扱う。

- PDG / taint analysis は本格的な静的解析として先に実装するより、まず `taint-lite` 的な観点として `skill-creator-gate` や検収/validation gate に残す候補。特に shell、外部送信、secret/env、ファイル削除/上書き、ユーザー入力からcommand stringへの流入、approval bypass などを、成果物の品質チェック項目として扱う方向がよさそう。

### Matt Pocock skills の数字phase実装への流用メモ

しばらく数字phase実装が続く間は、`mattpocock/skills` の工程・チェックリスト・テンプレを Biz-compiler 語彙へ置換して流用する。思想だけでなく、`SKILL.md` の実装手順も取り込む候補にする。外部repoは MIT License なので、実装として取り込む場合は著作権表示を残す。

凡例: `A` = かなり直接流用、`B` = Biz-compiler向けに改造して流用、`C` = 参考程度。

| Phase | 使えそうなMatt skills | 流用度 | どう効くか |
|---|---|---:|---|
| `00-entry` | `grill-me`, `grill-with-docs`, `to-prd` | A/B | 対象業務、scope、仮ゴール、初期リスクを質問で詰める。`to-prd` はPRDではなく `00-entry/contract` や entry packet 生成へ転用。 |
| `10-source-intake` | `grill-with-docs`, `zoom-out`, `triage` | A/B | ソースと本人説明を照合し、用語衝突を拾う。`zoom-out` は既存資料・コードの地図化に使える。`triage` の `needs-info` 発想は未確認事項管理に合う。 |
| `20-decompose-encrs` | `to-issues`, `prototype`, `grill-me`, `zoom-out` | A/B | `to-issues` の vertical slice / tracer bullet が、IPO/ENCRS分解に効く。As-Is手順を横断sliceにして、孤児手順を潰せる。 |
| `30-route-executor` | `triage`, `to-issues`, `write-a-skill` | A/B | `triage` の `ready-for-agent` / `ready-for-human` が executor routing に近い。`write-a-skill` は Skill 化候補の構造化に使える。 |
| `40-ir-freeze` | `to-prd`, `tdd`, `prototype`, `review` | A/B | `to-prd` の Implementation Decisions / Testing Decisions を IR freeze 用に変換できる。`tdd` の public interface test は contract/schema/validator の設計に合う。 |
| `50-consent` | `prototype`, `grill-with-docs`, `tdd`, `to-prd` | A/B | consent view や flowchart のUI/状態モデルを試すなら `prototype` が直撃。人間が見る粗い契約とnode payloadの分離も、grillで詰められる。 |
| `60-validation` | `tdd`, `diagnose`, `review`, `to-issues` | A | 一番流用度が高い。`diagnose` の feedback loop構築、再現、仮説、instrument、regression test は validation gate そのものに近い。 |
| `70-improvement` | `improve-codebase-architecture`, `review`, `diagnose`, `to-issues`, `grill-with-docs` | A/B | drift / near-miss / rework から改善候補を出すところに合う。deep module、deletion test、standards/spec二軸reviewは改善案の質を上げる。 |
| `80-operation` | `triage`, `diagnose`, `handoff`, `review` | B | 運用中の事故・改善要望・引き継ぎに効く。`handoff` は一時ファイル出力ではなく operation ledger / runbook handoff へ置換する必要あり。 |

置換ルール:

| Matt側 | Biz-compiler側 |
|---|---|
| `CONTEXT.md` | `knowledge/docs/lexicon.md` + phase README |
| `docs/adr/` | `knowledge/docs/decisions/` |
| GitHub Issues | `knowledge/journal/work/` or phase-local work items |
| PRD | phase contract / handoff / checks |
| `ready-for-agent` | automation / Skill / orchestrator / AFK executor |
| `ready-for-human` | human / approval gate / HITL |
| prototype output | decision / contract / schema へ吸収して削除 |

実装候補:

- `phase-implementation-gate` っぽいrepo-local Skillを作る。
- 中身は `grill-with-docs`、`to-issues`、`to-prd`、`tdd`、`diagnose` を合成する。
- 出力は数字phaseごとの `README.md`、`contract.md`、`questions.md`、`checks.md`、`handoff.md`、`artifacts/` に寄せる。
- phaseごとに、目的・語彙・scopeをgrillし、phase-local contract / acceptance criteriaへ落とし、vertical sliceに分解し、迷う部分だけprototypeし、public interface越しにtest/validatorを作り、hello-world-gate / code-impact / phase gateで閉じる。

## 掃除ルール

`knowledge-curation` で定期的にこのファイルを見直し、各メモを次のどれかへ振り分ける。

| 行き先 | 使う時 |
|---|---|
| `AGENTS.md` | 作業規約、読み込み順、禁止事項、配置ルール |
| `USER.md` | ユーザーの作業モデル、嫌う混同、会話上の好み |
| `SOUL.md` | agentの対話姿勢、避ける振る舞い |
| `COMPASS.md` | 判断prior、思考の向き、疑うもの |
| `knowledge/docs/decisions/` | 背景理由つきで採用/却下した判断 |
| `knowledge/pending/` | まだ確定できない候補 |
| `knowledge/journal/` | 長い会話履歴、作業ログ、試行錯誤 |
| `knowledge/docs/*` | 用語、IR、method、metaなどの正本文書 |
| 削除 | 重複、解決済み、誤り、もう効かない内容 |

掃除後、ここには「まだ整理していない短いメモ」だけを残す。
