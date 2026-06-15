# Impact Orchestrator

`impact-orchestrator` は、MergeGateの `register work` / `record impact` / `assign execution` / `verify completion` の作法を、Biz-compiler repo-local に軽く移植した作業前プロトコルである。

MergeGate本体やCLIは導入しない。ここでは、編集前に「何を変えるのか」「どこへ効くのか」「何を読ませるのか」「どのgateで終えるのか」を1枚にする。

## 使う時

コード、ドキュメント、Skill、ops、templateを変更する作業に入る前に使う。

短い質問回答、読み取りだけ、対象なしの `githubあげといて` では不要。

## コマンド

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

`-NoWrite` を付けると、work cardをファイルに書かず、内容だけ出力する。

## 出力

通常実行では `knowledge/journal/work/` に work card を作る。

work cardは作業ログであり、正本仕様ではない。採用理由として長期保存すべき内容は、必要に応じて `knowledge/docs/decisions/` へ移す。

## やらないこと

- ファイルlockはまだ実装しない。
- branch / PR stateの正本管理はまだしない。
- 実装や編集そのものは実行しない。
- hook設定ファイルを勝手に編集しない。
