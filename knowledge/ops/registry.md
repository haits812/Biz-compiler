# Knowledge Ops Registry

このファイルは、Biz-compiler repo内の repo-local Skill、hook adapter、orchestrator、command、tool を棚卸しする台帳である。

目的は、似たものを二重に作らないこと、作業前に既存の入口を確認できること、Codex / Claude Code など実行環境が変わっても repo-local の正本を失わないことにある。

## 原則

- 新しい Skill / hook / orchestrator / command / tool を作る前に、この台帳を確認する。
- 似た役割がある場合は、新規追加より既存入口の拡張を優先する。
- 実行スクリプトを `knowledge/ops/` 直下に置かない。所有する Skill または orchestrator のフォルダに同居させる。
- hook は環境別の adapter であり、正本ではない。正本はこの台帳と repo-local script に置く。
- MergeGate本体は導入しない。採用するのは register / impact / assign / verify の作法である。

## 初期読み込みでの扱い

`Hello,world.md` には、存在と入口だけを載せる。

この台帳の全文を読むのは、次の時だけでよい。

- 新しい Skill / hook / orchestrator / command / tool を作る時
- 既存の ops 資産と重複しそうな提案をする時
- 作業前に `impact-orchestrator` で影響範囲を切る時
- `knowledge/ops/` 配下を変更する時

## Skills

| id | 状態 | 役割 | path | command |
|---|---|---|---|---|
| `hello-world-gate` | 整備済み | `Hello,world.md` の再生成、検査、日本語commit、GitHub push、post-checkを一気通貫で行う | `knowledge/ops/skills/hello-world-gate/` | `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` |
| `knowledge-curation` | 整備済み | `MEMORY.md`、pending、journal、decisionsなどの知識候補を整理し、格上げ/保留/退避/廃棄へ振り分ける | `knowledge/ops/skills/knowledge-curation/` | `new-pending-update.ps1`, `pending-review.ps1` |

## Orchestrators

| id | 状態 | 役割 | path | command | 出力 |
|---|---|---|---|---|---|
| `impact-orchestrator` | 整備済み | 作業前に目的、影響、読むべきもの、既存ops資産、実行者、完了gateを1枚に切る | `knowledge/ops/orchestrators/impact-orchestrator/` | `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1` | `knowledge/journal/work/` |

## Hooks

| id | 状態 | 役割 | 呼び出すもの | 備考 |
|---|---|---|---|---|
| `codex-pre-work` | 未実装 | Codex環境で編集前に作業影響を切るadapter候補 | `impact-orchestrator` | 現時点ではCodex設定ファイルを自動編集しない |
| `claude-code-pre-work` | 未実装 | Claude Code環境で編集前に作業影響を切るadapter候補 | `impact-orchestrator` | hook移植は各環境で再現する |
| `pre-publish` | 運用済み相当 | GitHubへ上げる前にHello World同期とcommit/pushを通す | `hello-world-gate` | hookではなく発話/手動gateとして運用中 |

## Commands

| command | owner | 使う時 |
|---|---|---|
| `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` | `hello-world-gate` | ハロワ更新、GitHub push、構成変更後の同期 |
| `knowledge/ops/skills/knowledge-curation/new-pending-update.ps1` | `knowledge-curation` | 未承認の知識更新候補を作る |
| `knowledge/ops/skills/knowledge-curation/pending-review.ps1` | `knowledge-curation` | pending候補のlist/show/approve/reject/applied |
| `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1` | `impact-orchestrator` | 編集前に作業の意図、影響、読むもの、完了gateを記録する |

## Tools

現時点で `knowledge/ops/tools/` は作らない。

repo開発運用に必要な道具は、まず Skill または orchestrator の所有フォルダへ置く。業務フォルダへコピーされる実行部品は `template/_shared/` 側へ置く。

## MergeGate 作法の対応

| MergeGate風の作法 | Biz-compilerでの採用形 |
|---|---|
| register work | `impact-orchestrator` が work card を作る |
| record impact | work cardの `Impact`、`Touched files`、`Read routing` に残す |
| lock files | 現時点では実装しない。必要なら将来のhook adapterで扱う |
| assign execution | work cardの `Executor` と `Subagent hint` に残す |
| track branch / PR state | 現時点では `hello-world-gate` のgit status / push確認に寄せる |
| verify completion | work cardの `Finish gate` と `hello-world-gate` に寄せる |

## 更新ルール

次を変更したら、この台帳も同じターンで更新する。

- repo-local Skill の追加、改名、削除
- hook adapter の追加、改名、削除
- orchestrator の追加、改名、削除
- `knowledge/ops/` 配下の command / script の追加、改名、削除
- `Hello,world.md` に載せる ops entrypoint の変更

この台帳を更新したら、最後に `hello-world-gate.ps1` を通して `Hello,world.md` も同期する。
