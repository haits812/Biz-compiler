# Knowledge Ops

このディレクトリは、Biz-compiler開発運用の ops 資産を置く場所である。

対象は repo-local Skill、hook adapter、orchestrator、command、tool の棚卸しと実行入口である。正本台帳は `knowledge/ops/registry.md` に置く。作業前impact、file lock、completion trackingは `impact-orchestrator` が扱う。

`knowledge/ops/` 直下に `.ps1` は置かない。実行スクリプトは、それを所有する Skill または orchestrator のフォルダに同居させる。

## Registry

新しい Skill / hook / orchestrator / command / tool を作る前に、まず次を確認する。

```powershell
Get-Content -Raw .\knowledge\ops\registry.md
```

似た役割がある場合は、別資産を増やさず既存入口へ統合する。

## Owner Docs

`knowledge/ops/registry.md` は棚卸し正本、このREADMEはops全体の入口である。各資産を実際に使う・変更する時は、owner説明を読む。

| owner | 読むファイル | 使う時 |
|---|---|---|
| `hello-world-gate` | `knowledge/ops/skills/hello-world-gate/SKILL.md` | ハロワ更新、GitHub反映、出口gateを扱う時 |
| `knowledge-curation` | `knowledge/ops/skills/knowledge-curation/SKILL.md` | MEMORY、pending、journal、decisionsの整理を扱う時 |
| `empirical-prompt-tuning` | `knowledge/ops/skills/empirical-prompt-tuning/SKILL.md` | empirical-prompt-tuning、empirical eval、プロンプト実証評価、Iter-0整合チェックを明示された時 |
| `paper-write` | `knowledge/ops/skills/paper-write/SKILL.md` | 論文、研究稿、LaTeX原稿、引用付きpaper draftを扱う時 |
| `review-agent-essence` | `knowledge/ops/skills/review-agent-essence/SKILL.md` | review-agent-essence、agent-essence原則レビュー、エッセンスレビュー、原則チェックを明示された時 |
| `review-harness` | `knowledge/ops/skills/review-harness/SKILL.md` | review-harness、ハーネス診断、harness診断、ハーネス健康診断を明示された時 |
| `skill-creator-gate` | `knowledge/ops/skills/skill-creator-gate/SKILL.md` | やりたいことを元にSkill化対象を整理し、repo-local Skillの作成、改修、多工程Skill設計、trigger設計、proposalを扱う時 |
| `web-research-to-report` | `knowledge/ops/skills/web-research-to-report/SKILL.md` | Web調査を出典付きレポート、ブリーフ、意思決定メモにする時 |
| `impact-orchestrator` | `knowledge/ops/orchestrators/impact-orchestrator/README.md` | 編集前impact、work card、lock、completionを扱う時 |
| `knowledge-search` | `knowledge/ops/orchestrators/knowledge-search/README.md` | 過去会話・作業メモ・決定の検索、SQLite indexを扱う時 |
| `hooks` | `knowledge/ops/hooks/README.md` | Codex / Claude Code など環境別hook adapterを扱う時 |

hook adapterは薄い入口なので、呼び出し先のowner説明も読む。例: `codex-pre-work.ps1` を触るなら `hooks/README.md` と `impact-orchestrator/README.md` の両方を読む。

## Sync Rule

次を追加・改名・削除した場合は、このREADMEと `knowledge/ops/registry.md` を同じターンで更新する。

- repo-local Skill
- hook adapter
- orchestrator
- command / script
- tool

最後に `hello-world-gate.ps1` を通し、`Hello-world.md` のops entrypointとKnown knowledge ops assetsを再生成する。

## skills/hello-world-gate/

`Hello-world.md` を現在状態に同期・検査し、GitHubへ上げる時もこのgateでcommit/pushする。

外から叩くコマンドは1つだけ。

```powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
```

このコマンドは、ハロワ更新、検査、`git add -A`、日本語commit、`git push`、post-checkを順番に実行する。GitHub/push依頼では、先に `git status --short --branch` で対象有無を見る。対象がなければgate本体を実行せず `対象ないよ。main と origin/main は同期済み。` と返す。

## skills/knowledge-curation/

`MEMORY.md`、`knowledge/pending/`、`knowledge/journal/`、`knowledge/docs/decisions/` などの知識候補を整理するSkillである。

未承認候補の作成・確認・承認・却下・適用済み化もここで扱う。`pending` は状態名であり、別Skill名にはしない。

```powershell
.\knowledge\ops\skills\knowledge-curation\new-pending-update.ps1 -Title "即時メモのタイトル" -Target "MEMORY.md" -Evidence "どの発話・作業から出たか" -ProposedChange "残したい内容"

.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 list -Stage all
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 show -Id "memory/<file>.md"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 approve -Id "memory/<file>.md" -Reason "採用理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 reject -Id "memory/<file>.md" -Reason "却下理由"
.\knowledge\ops\skills\knowledge-curation\pending-review.ps1 applied -Id "approved/memory/<file>.md" -Reason "MEMORY.mdへ反映済み"
```

`approve` は候補を `knowledge/pending/approved/` へ移すだけで、正式ファイルを自動編集しない。正式反映では、対象ファイルの役割と既存記述を読んでから文脈込みで編集する。

## skills/empirical-prompt-tuning/

mizchi/skills の `empirical-prompt-tuning` をベースに置く。`SKILL.md` と `SKILL-ja.md` の両方を同居させ、repo-local Skillとしての読まれ方は通常どおり `SKILL.md` に従う。明示依頼時だけ使い、Skill作成・改修後に自動発火しない。

Skill、SKILL.md、agent向けprompt、subagent brief、phase promptを、白紙実行者に読ませて評価し、description/body整合、critical要件、失敗パターン台帳、反復改善で直すために使う。`skill-creator-gate` はSkillを作る入口、これは作った/直したSkillを検査して直す入口として分ける。
## skills/paper-write/

OpenSquillaの `meta-paper-write` から `meta-` とruntimeを外し、論文、研究稿、LaTeX原稿向けの通常repo-local Skillとして移植した。

普通の業務文書には使わない。論文/academic paper/LaTeX/PDF/研究稿が明示された時に、paper contract、source/citation、figure/table placeholder、length/citation gateを通して書く。

## skills/review-agent-essence/

Skill、ハーネス、設計文書を `agent-essence` の原則に照らしてレビューする明示呼び出し専用Skillである。

通常のレビュー依頼では自動発火しない。`review-agent-essence`、agent-essence原則レビュー、エッセンスレビュー、原則チェック、またはSkill/ハーネス設計をagent-essenceに照らして見る依頼がある時だけ使う。出力は標準出力のレビュー・レポートで、対象ファイルは直接修正しない。

## skills/review-harness/

Claude Code / Codex 系のハーネス構成を25のアンチパターン指標で診断する明示呼び出し専用Skillである。

通常の「診断して」や一般レビューでは自動発火しない。`review-harness`、ハーネス診断、harness診断、ハーネス健康診断、25指標診断を明示された時だけ使う。出力は標準出力の診断レポートで、画像生成、SNS投稿提案、ファイル生成は行わない。

## skills/skill-creator-gate/

ユーザーのやりたいことを元にSkill化対象を整理し、多工程Skill設計、標準skill-creator作法での実装、repo-local登録、検査まで扱うcreator/gateである。

いきなり正式Skillを増やすのではなく、必要に応じて `knowledge/pending/skills/` にproposalを作り、既存Skill / orchestrator / hook / commandとの衝突確認、trigger-rich description設計、owner説明、検査、registry / Hello World同期まで扱う。

```powershell
.\knowledge\ops\skills\skill-creator-gate\new-skill-proposal.ps1 `
  -Name "skill-name" `
  -Intent "何をSkill化したいか" `
  -Triggers "自然文1;自然文2" `
  -Steps "intake;shape;design;validate" `
  -Validation "何を確認するか" `
  -CollisionCheck "既存Skillとの関係" `
  -Risk "残リスク"

.\knowledge\ops\skills\skill-creator-gate\validate-repo-skill.ps1 -SkillName "skill-name"
```

## skills/web-research-to-report/

OpenSquillaの `meta-web-research-to-report` から `meta-` とruntimeを外し、Web調査を出典付きレポート、ブリーフ、意思決定メモへ変換する通常repo-local Skillとして移植した。

出典付き調査、最新情報の確認、選択肢比較、意思決定メモ、source-backed reportを求められた時に自然発火してよい。単発の事実確認、与えられたメモだけの要約、普通の文章作成には使わない。
## orchestrators/impact-orchestrator/

MergeGateの作法を参考に、編集前に作業の目的、影響、読むもの、既存ops資産、実行者、完了gateを1枚に切るorchestratorである。

```powershell
.\knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1 `
  -Title "作業名" `
  -Kind "ops" `
  -Intent "何をしたいか" `
  -Impact "どこへ効くか" `
  -Files "AGENTS.md;knowledge/ops/registry.md" `
  -Executor "codex" `
  -Risk "medium"
```

`-NoWrite` を付けると、work cardを作らず内容だけ確認できる。通常実行では `knowledge/journal/work/locks.json` にactive lockを作り、完了時に `-Complete` で解放する。

```powershell
.\knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1 -ListLocks
```

## hooks/

hookは環境別adapterであり、正本ではない。Codex / Claude Code などへ移植する場合も、hook本体は repo-local orchestrator / Skill を呼ぶだけにする。

repo-local adapterは実装済み。外部環境のhook設定は自動編集しない。

```powershell
.\knowledge\ops\hooks\codex-pre-work.ps1 -Title "作業名" -Files "AGENTS.md;Hello-world.md"
.\knowledge\ops\hooks\claude-code-pre-work.ps1 -Title "作業名" -Files "AGENTS.md;Hello-world.md"
.\knowledge\ops\hooks\pre-publish.ps1 -Subject "何を変えたか" -Reason "なぜ必要だったか" -Verified "何を確認したか" -Risks "残っている注意点"
```
