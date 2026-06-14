---
name: knowledge-curation
description: Biz-compiler repo内のMEMORYメモと知識候補を、Markdownルール化、Hello World Gate、将来phase script候補、pending、journal、decisions、廃棄へ振り分けるrepo-local Skill。pending候補の作成・承認・却下・適用もこのSkillで扱う。
---

# Knowledge Curation

## 範囲

これは Biz-compiler リポジトリ専用の repo-local Skill。グローバルSkillにはしない。

目的は、普段 `MEMORY.md` に置いたメモや会話・作業で出た知識候補を「どこへ格上げするか、保留するか、退避するか、捨てるか」判断し、必要なら `knowledge/pending/` の承認フローを通して正本へ反映すること。

未承認候補専用の別Skillは作らない。未承認候補の作成・確認・承認・却下・適用済み化は、この `knowledge-curation` のサブ機能として扱う。

外部hook、deny rule、グローバル設定、他リポジトリへ影響する仕組み化は、このSkillの対象外。

## 発話トリガー

次のような依頼で使う。

- `知識整理して`
- `メモリ整理して`
- `MEMORY.md` を整理して
- `格上げ判断して`
- `これルール化できる？`
- `pending見て`
- `pending作って`
- `journalから拾うものある？`
- `この会話どこに残す？`
- `knowledge curation`
- `MEMORY.md` が重い / 汚い / 重複している

## 対象

| 対象 | 見るもの |
|---|---|
| 普段メモ/整理対象 | `MEMORY.md` |
| 常時読む正本 | `AGENTS.md`, `Hello,world.md`, `SOUL.md`, `USER.md`, `COMPASS.md`, `knowledge/docs/lexicon.md` |
| メタ土台 | `knowledge/docs/meta/` |
| 用語・方法・IRなど | `knowledge/docs/README.md` のread routing先 |
| 未承認候補 | `knowledge/pending/` |
| 会話履歴/作業ログ | `knowledge/journal/` |
| 決定理由 | `knowledge/docs/decisions/` |
| repo-local gate | `knowledge/ops/skills/hello-world-gate/` |
| 将来のphase-local実行候補 | `template/<phase>/`, `template/_shared/` |

## コマンド

未承認候補を作る。

```powershell
.\knowledge\ops\skills\knowledge-curation\new-pending-update.ps1 -Title "即時メモのタイトル" -Target "MEMORY.md" -Evidence "どの発話・作業から出たか" -ProposedChange "残したい内容"
```

`-Target` は `MEMORY.md`、`COMPASS.md`、`knowledge/docs/decisions` から選ぶ。迷う場合は `MEMORY.md` を使う。

未承認候補を確認・承認・却下・適用済みにする。

```powershell
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "正式ファイルへ反映済み"
```

`approve` は候補を `knowledge/pending/approved/` へ移すだけで、正式ファイルを自動編集しない。正式反映では、対象ファイルの役割、既存記述、重複、語彙の区別を確認してから編集する。

## 判断順

### 1. 実態確認

候補が指している問題や制約が今も生きているかを確認する。

分類に迷う短いメモは、最初から `MEMORY.md` に置いてよい。整理時にここから各正本へ振り分ける。

`MEMORY.md` は普段メモの入口であり、同時に整理対象である。次を見つけたら、Memoryから削るか正本へ移す。

- `Hello,world.md` が持つ現在構成、root tree、pending件数の重複
- `AGENTS.md` が持つ読み込み順、禁止事項、配置ルール、gate運用の重複
- `knowledge/docs/decisions/` が持つ決定履歴や採用理由の重複
- `knowledge/docs/meta/README.md` が持つメタ土台の状態、依存、次アクションの重複
- `knowledge/docs/README.md` が持つread routingの重複

既に正本にあるなら重複として捨てる。既に解決済みなら記憶として増やさない。現在の構成と矛盾するなら、古い候補として捨てるか `rejected` 扱いにする。

### 2. ルール化できるか

常時効く禁止、配置、読み順、運用制約なら、`MEMORY.md` より先にMarkdown正本へルール化できるかを見る。

| 種類 | 主な格上げ先 |
|---|---|
| 作業規約、読み込み順、禁止事項 | `AGENTS.md` |
| 思考の向き、価値順位、疑うもの | `COMPASS.md` |
| agentの振る舞い | `SOUL.md` |
| ユーザーとの進め方 | `USER.md` |
| 状態、配置、brief、phase意味などの上位ルール | `knowledge/docs/meta/` |
| 用語境界 | `knowledge/docs/lexicon.md` |
| IR、schema、manifest、contractの意味 | `knowledge/docs/ir/` |

### 3. repo-local gateに寄せられるか

`Hello,world.md` の現在地、root構成、読み込み順、`template/`、`knowledge/`、`output/`、push前検査に関わるなら、`hello-world-gate` に寄せられるかを見る。

新しい外部hookやdeny ruleは作らない。現時点の自動化候補は、repo-local `knowledge/ops/skills/hello-world-gate/` の範囲に限る。

### 4. 将来phase script候補か

数字phaseの処理が具体化してから自動化すべきものは、今すぐscript化しない。

- phase固有なら `template/<phase>/` の将来候補
- phase横断なら `template/_shared/` の将来候補
- 現時点では `knowledge/pending/` または `template/phase-local-missing.md` へ置く

### 5. 残す/捨てるを決める

| 分類 | 意味 | 行き先 |
|---|---|---|
| `rule-md` | Markdown正本へルール化する | `AGENTS.md` / `COMPASS.md` / `SOUL.md` / `USER.md` / `knowledge/docs/*` |
| `gate` | repo-local gateで扱う | `knowledge/ops/skills/hello-world-gate/` |
| `phase-script-candidate` | 将来のphase処理でscript化する | `template/<phase>/` / `template/_shared/` / pending |
| `memory` | まだ分類しきれない短い普段メモとして残す | `MEMORY.md` |
| `memory-prune` | `MEMORY.md` から正本化済み、重複、古い状態を削る | `MEMORY.md` |
| `pending` | 未承認、判断に迷う | `knowledge/pending/` |
| `journal` | 会話履歴、作業過程、試行錯誤、長いログ | `knowledge/journal/` |
| `decision` | 背景理由つきの設計判断 | `knowledge/docs/decisions/` |
| `prune` | 重複、解決済み、誤り、もう効かない | 削除、またはrejected記録 |
| `keep` | ownerや扱いがまだ見えない | そのまま残す |

## 禁止事項

- 未承認候補専用の別Skillを作らない。pending運用は `knowledge-curation` に統合する。
- 外部hook、deny rule、グローバル設定をこのSkillで作らない。
- `MEMORY.md` を普段メモの入口として使ってよい。ただし恒久ルール、現在構成、決定済み一覧、次アクション台帳の正本にはしない。
- 既に正本化された内容をpending、journal、MEMORYへ二重保持しない。Memoryに見つけたら整理対象として削る。
- `decision-workflow`、`memory-workflow`、`registry-management` を新しいメタ土台として増やさない。
- `output/` 直下にサンプル業務やプレースホルダ業務フォルダを作らない。
- `knowledge/ops/` 直下に `.ps1` を置かない。

## 完了報告

報告では次を短く出す。

```text
知識候補整理:
- rule-md: N件
- gate: N件
- phase-script-candidate: N件
- memory: N件
- memory-prune: N件
- pending: N件
- journal: N件
- decision: N件
- prune: N件
- keep: N件
- 残リスク: ...
```

Markdown正本、`MEMORY.md`、`knowledge/docs/meta/`、`knowledge/ops/skills/hello-world-gate/` を触った場合は、同じターンでハロワゲートを通す。
