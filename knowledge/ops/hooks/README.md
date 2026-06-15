# Hooks

このフォルダは、Codex / Claude Code など環境別hook adapterの置き場である。

現時点では、実hook設定ファイルは置かない。hookは環境ごとに設定方法が違い、このリポジトリ外へ影響するため、repo内の正本は `knowledge/ops/registry.md` と repo-local orchestrator / Skill に置く。

## 方針

- hookは正本ではなくadapterである。
- hook adapterは、直接ロジックを持たず repo-local script を呼ぶ。
- 作業前hookの第一候補は `knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1` を呼ぶこと。
- GitHub反映前の出口は `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` に寄せる。
- `.claude/settings.json`、Codexのローカル設定、deny listなどは、このリポジトリから勝手に編集しない。

## 想定adapter

| adapter | 状態 | 呼び出し先 | 目的 |
|---|---|---|---|
| `codex-pre-work` | 未実装 | `impact-orchestrator` | Codexで編集前にwork cardを作る |
| `claude-code-pre-work` | 未実装 | `impact-orchestrator` | Claude Codeで編集前にwork cardを作る |
| `pre-publish` | 手動gateで運用 | `hello-world-gate` | push前にHello World同期、検査、commit、pushを通す |

## 移植時の確認

hookを実際の環境へ移植する時は、先に `knowledge/ops/registry.md` を読み、既存のSkill / orchestrator / commandと重複しないか確認する。
