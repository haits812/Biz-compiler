# Impact Orchestrator

`impact-orchestrator` は、MergeGateの `register work` / `record impact` / `lock files` / `assign execution` / `verify completion` の作法を、Biz-compiler repo-local に軽く移植した作業前プロトコルである。

MergeGate本体やCLIは導入しない。ここでは、編集前に「何を変えるのか」「どこへ効くのか」「何を読ませるのか」「どのgateで終えるのか」を1枚にし、並列作業でぶつかるファイルをlockする。

## 使う時

コード、ドキュメント、Skill、ops、templateを変更する作業に入る前に使う。

短い質問回答、読み取りだけ、対象なしの `githubあげといて` では不要。

## register

```powershell
.\knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1 `
  -Title "作業名" `
  -Kind "ops" `
  -Intent "何をしたいか" `
  -Impact "どこへ効くか" `
  -Files "AGENTS.md;Hello-world.md;knowledge/ops/registry.md" `
  -Executor "codex" `
  -Risk "medium"
```

`-Files` はセミコロン区切りにする。複数ファイルを明示的に分けるため、カンマ区切りは使わない。

通常実行では `knowledge/journal/work/` に work card を作り、対象ファイルを `knowledge/journal/work/locks.json` にactive lockとして記録する。

`-NoWrite` を付けると、work cardとlockを書かず、内容だけ出力する。`-NoLock` を付けるとlockを取らない。

## complete

作業が終わったらwork cardを閉じ、lockを解放する。

```powershell
.\knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1 `
  -Complete `
  -WorkCard "knowledge/journal/work/20260615-000000-example.md" `
  -Result "何を完了したか" `
  -Verified "何を確認したか" `
  -ResidualRisk "残っている注意"
```

## locks

active lockを確認する。

```powershell
.\knowledge\ops\orchestrators\impact-orchestrator\impact-orchestrator.ps1 -ListLocks
```

lock衝突時は停止する。古いlockを意図的に上書きする場合だけ `-Force` を使う。

## Markdown Reference Impact

`-Files` に渡したファイル名・相対パスを、repo内のMarkdownから検索し、work cardの `Markdown Reference Impact` に残す。

Markdownにリンクをベタ書きしている場合も影響として扱う。

## やらないこと

- branch / PR stateの正本管理はまだしない。
- 実装や編集そのものは実行しない。
- hook設定ファイルを勝手に編集しない。
