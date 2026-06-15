# Knowledge Ops Registry

このファイルは、Biz-compiler repo内の repo-local Skill、hook adapter、orchestrator、command、tool を棚卸しする台帳である。

目的は、似たものを二重に作らないこと、作業前に既存の入口を確認できること、Codex / Claude Code など実行環境が変わっても repo-local の正本を失わないことにある。

## 原則

- 新しい Skill / hook / orchestrator / command / tool を作る前に、この台帳を確認する。
- 似た役割がある場合は、新規追加より既存入口の拡張を優先する。
- 実行スクリプトを `knowledge/ops/` 直下に置かない。所有する Skill、hook adapter、orchestrator のフォルダに同居させる。
- hook は環境別の adapter であり、正本ではない。正本はこの台帳と repo-local script に置く。
- MergeGate本体は導入しない。採用するのは register / impact / lock / assign / verify の作法である。

## 初期読み込みでの扱い

`Hello-world.md` には、存在と入口だけを載せる。

この台帳の全文を読むのは、次の時だけでよい。

- 新しい Skill / hook / orchestrator / command / tool を作る時
- 既存の ops 資産と重複しそうな提案をする時
- 作業前に `impact-orchestrator` で影響範囲を切る時
- `knowledge/ops/` 配下を変更する時

## 読み導線

この台帳は「何があるか」を引く目録であり、各資産の運用詳細を読む場所ではない。

既存ops資産を使う、変更する、または同種の資産を追加する時は、次の順で読む。

1. `Hello-world.md` の `Ops Entrypoints` で存在と入口を確認する。
2. この `knowledge/ops/registry.md` で重複と所有者を確認する。
3. 対象ownerの説明ファイルを読む。

| 対象 | owner説明 |
|---|---|
| repo-local Skill | `knowledge/ops/skills/<skill-name>/SKILL.md` |
| orchestrator | `knowledge/ops/orchestrators/<orchestrator-name>/README.md` |
| hook adapter | `knowledge/ops/hooks/README.md` |
| hookの呼び出し先 | 呼び出し先Skillの `SKILL.md` またはorchestratorの `README.md` |
| command / script / tool | 所有フォルダの `README.md` または `SKILL.md` |

現行owner説明:

- `knowledge/ops/skills/hello-world-gate/SKILL.md`
- `knowledge/ops/skills/knowledge-curation/SKILL.md`
- `knowledge/ops/skills/empirical-prompt-tuning/SKILL.md`
- `knowledge/ops/skills/paper-write/SKILL.md`
- `knowledge/ops/skills/review-agent-essence/SKILL.md`
- `knowledge/ops/skills/review-harness/SKILL.md`
- `knowledge/ops/skills/skill-creator-gate/SKILL.md`
- `knowledge/ops/skills/web-research-to-report/SKILL.md`
- `knowledge/ops/hooks/README.md`
- `knowledge/ops/orchestrators/impact-orchestrator/README.md`
- `knowledge/ops/orchestrators/knowledge-search/README.md`

owner説明が無いops資産は未整備として扱う。新規追加時は、実行体だけでなくowner説明とこの台帳の読み導線を同じターンで更新する。

## Skills

| id | 状態 | 役割 | path | command |
|---|---|---|---|---|
| `hello-world-gate` | 整備済み | `Hello-world.md` の再生成、検査、日本語commit、GitHub push、post-checkを一気通貫で行う | `knowledge/ops/skills/hello-world-gate/` | `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` |
| `knowledge-curation` | 整備済み | `MEMORY.md`、pending、journal、decisionsなどの知識候補を整理し、格上げ/保留/退避/廃棄へ振り分ける | `knowledge/ops/skills/knowledge-curation/` | `new-pending-update.ps1`, `pending-review.ps1` |
| `empirical-prompt-tuning` | 整備済み | mizchi/skillsの`empirical-prompt-tuning`を原文のまま置く。Skill、SKILL.md、agent向けpromptを白紙実行者で評価し、description/body整合、critical要件、失敗パターン台帳で改善する | `knowledge/ops/skills/empirical-prompt-tuning/` | - |
| `paper-write` | 整備済み | OpenSquillaの`meta-paper-write`からmeta/runtimeを外し、論文・研究稿・LaTeX原稿向けにcontract、source/citation、figure/table placeholder、length/citation gateの作法を使う | `knowledge/ops/skills/paper-write/` | - |
| `review-agent-essence` | 整備済み | 明示依頼時だけ、Skill/ハーネス/設計文書をagent-essence原則に照らしてレビューし、標準出力レポートを返す | `knowledge/ops/skills/review-agent-essence/` | - |
| `review-harness` | 整備済み | 明示依頼時だけ、Claude Code/Codex系ハーネス構成を25のアンチパターン指標で診断し、標準出力レポートを返す | `knowledge/ops/skills/review-harness/` | - |
| `skill-creator-gate` | 整備済み | ユーザーのやりたいことを起点にSkill化対象を整理し、多工程Skill設計、標準skill-creator作法での実装、proposal、衝突確認、trigger設計、登録、検査を段階的に行う | `knowledge/ops/skills/skill-creator-gate/` | `new-skill-proposal.ps1`, `validate-repo-skill.ps1` |
| `web-research-to-report` | 整備済み | OpenSquillaの`meta-web-research-to-report`からmeta/runtimeを外し、Web調査を出典付きレポート、ブリーフ、意思決定メモへ変換する | `knowledge/ops/skills/web-research-to-report/` | - |

## Orchestrators

| id | 状態 | 役割 | path | command | 出力 |
|---|---|---|---|---|---|
| `impact-orchestrator` | 整備済み | 作業前に目的、影響、Markdown参照impact、読むべきもの、既存ops資産、実行者、完了gateを1枚に切り、必要ならfile lockを取る | `knowledge/ops/orchestrators/impact-orchestrator/` | `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1` | `knowledge/journal/work/` |
| `knowledge-search` | 整備済み | Markdown正本をSQLite FTS5へindexし、過去会話・作業メモ・決定・設定をpath付きで検索する。「前にこんな会話しなかったっけ？」系の自然文でも使う | `knowledge/ops/orchestrators/knowledge-search/` | `knowledge/ops/orchestrators/knowledge-search/knowledge-search.ps1` | `knowledge/.index/knowledge.sqlite` |

## Hooks

| id | 状態 | 役割 | 呼び出すもの | 備考 |
|---|---|---|---|---|
| `codex-pre-work` | 実装済み / 未接続 | Codex環境で編集前に作業影響を切るadapter | `impact-orchestrator` | 環境側hook設定から呼ぶ |
| `claude-code-pre-work` | 実装済み / 未接続 | Claude Code環境で編集前に作業影響を切るadapter | `impact-orchestrator` | hook移植は各環境で再現する |
| `pre-publish` | 実装済み / 未接続 | GitHubへ上げる前にHello World同期とcommit/pushを通すadapter | `hello-world-gate` | 日本語commit情報が必要 |

## Commands

| command | owner | 使う時 |
|---|---|---|
| `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` | `hello-world-gate` | ハロワ更新、GitHub push、構成変更後の同期 |
| `knowledge/ops/skills/knowledge-curation/new-pending-update.ps1` | `knowledge-curation` | 未承認の知識更新候補を作る |
| `knowledge/ops/skills/knowledge-curation/pending-review.ps1` | `knowledge-curation` | pending候補のlist/show/approve/reject/applied |
| `knowledge/ops/skills/skill-creator-gate/new-skill-proposal.ps1` | `skill-creator-gate` | repo-local Skill proposalを `knowledge/pending/skills/` に作る |
| `knowledge/ops/skills/skill-creator-gate/validate-repo-skill.ps1` | `skill-creator-gate` | repo-local Skillのfrontmatter、命名、script構文、registry/ops README参照を検査する |
| `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1` | `impact-orchestrator` | 編集前のwork card/impact/lock作成、完了時のlock解放 |
| `knowledge/ops/orchestrators/knowledge-search/knowledge-search.ps1` | `knowledge-search` | Markdown正本をSQLite FTS5へindex/searchする |
| `knowledge/ops/hooks/codex-pre-work.ps1` | `codex-pre-work` | Codex hook adapterとして `impact-orchestrator` を呼ぶ |
| `knowledge/ops/hooks/claude-code-pre-work.ps1` | `claude-code-pre-work` | Claude Code hook adapterとして `impact-orchestrator` を呼ぶ |
| `knowledge/ops/hooks/pre-publish.ps1` | `pre-publish` | publish hook adapterとして `hello-world-gate` を呼ぶ |

## Work Ledger

| file | 役割 |
|---|---|
| `knowledge/journal/work/locks.json` | active file lock台帳。完了時に空へ戻す |
| `knowledge/journal/work/*.md` | `impact-orchestrator` のwork card |
| `knowledge/.index/knowledge.sqlite` | Markdown正本から生成するSQLite FTS5検索index。git管理しない |
| `knowledge/pending/skills/*.md` | `skill-creator-gate` が作るrepo-local Skill proposal。正式Skillではない |

## Tools

現時点で `knowledge/ops/tools/` は作らない。

repo開発運用に必要な道具は、まず Skill、hook adapter、orchestrator の所有フォルダへ置く。業務フォルダへコピーされる実行部品は `template/_shared/` 側へ置く。

## MergeGate 作法の対応

| MergeGate風の作法 | Biz-compilerでの採用形 |
|---|---|
| register work | `impact-orchestrator` が work card を作る |
| record impact | work cardの `Impact`、`Touched Files`、`Markdown Reference Impact`、`Read Routing` に残す |
| lock files | `knowledge/journal/work/locks.json` にactive lockを持ち、衝突時に停止する |
| assign execution | work cardの `Executor` と `Subagent hint` に残す |
| track branch / PR state | 未実装。GitHub運用が固まってから判断する |
| verify completion | `impact-orchestrator -Complete` でwork cardを閉じ、lockを解放する。GitHub反映は `hello-world-gate` に寄せる |

## 更新ルール

次を変更したら、この台帳も同じターンで更新する。

- repo-local Skill の追加、改名、削除
- hook adapter の追加、改名、削除
- orchestrator の追加、改名、削除
- `knowledge/.index/` の生成物ルール変更
- `knowledge/ops/` 配下の command / script の追加、改名、削除
- `Hello-world.md` に載せる ops entrypoint の変更

この台帳を更新したら、最後に `hello-world-gate.ps1` を通して `Hello-world.md` も同期する。
