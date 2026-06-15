# Hooks

このフォルダは、Codex / Claude Code など環境別hook adapterの置き場である。

hookは正本ではない。正本は `knowledge/ops/registry.md` と repo-local orchestrator / Skill に置く。ここに置く `.ps1` は、外部環境のhook設定から呼ばれる薄いadapterである。

## 方針

- hook adapterは、直接ロジックを持たず repo-local script を呼ぶ。
- 作業前hookは `impact-orchestrator` を呼び、work card作成、Markdown参照impact、file lockを扱う。
- GitHub反映前の出口は `hello-world-gate` に寄せる。
- `.claude/settings.json`、Codexのローカル設定、deny listなどは、このリポジトリから勝手に編集しない。移植時にその環境で設定する。

## Adapter一覧

| adapter | 状態 | 呼び出し先 | 目的 |
|---|---|---|---|
| `codex-pre-work.ps1` | 実装済み / 未接続 | `impact-orchestrator` | Codex環境で編集前にwork cardとlockを作る |
| `claude-code-pre-work.ps1` | 実装済み / 未接続 | `impact-orchestrator` | Claude Code環境で編集前にwork cardとlockを作る |
| `pre-publish.ps1` | 実装済み / 未接続 | `hello-world-gate` | push前にHello World同期、検査、commit、pushを通す |

## 作業前hook adapter

環境側hookから、次のように呼ぶ。

```powershell
.\knowledge\ops\hooks\codex-pre-work.ps1 `
  -Title "作業名" `
  -Kind "ops" `
  -Intent "何をしたいか" `
  -Impact "どこへ効くか" `
  -Files "AGENTS.md;Hello,world.md" `
  -Risk "medium"
```

`-Files` はセミコロン区切りにする。`Hello,world.md` のようにカンマを含むファイル名があるため、カンマ区切りは使わない。

環境変数でも渡せる。

| env | 意味 |
|---|---|
| `BIZ_WORK_TITLE` | 作業名 |
| `BIZ_WORK_KIND` | 作業種別 |
| `BIZ_WORK_INTENT` | 目的 |
| `BIZ_WORK_IMPACT` | 影響 |
| `BIZ_WORK_FILES` | セミコロン区切りの対象ファイル |
| `BIZ_WORK_RISK` | `low` / `medium` / `high` / `unknown` |

## pre-publish adapter

```powershell
.\knowledge\ops\hooks\pre-publish.ps1 `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
```

## 移植時の確認

hookを実際の環境へ移植する時は、先に `knowledge/ops/registry.md` を読み、既存のSkill / orchestrator / commandと重複しないか確認する。
