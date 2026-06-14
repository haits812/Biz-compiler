# 数字phaseごとのコマンド実行面と会話フローを分離する候補

## Target
future runner convention / phase ledger / command interface / conversation flow

## Proposed Change
Biz-compilerは会話で進める機能を持つが、会話だけを実行面にしない。10/20/30...の数字phaseごとに、個別コマンドで実行・検証・再実行できるようにする候補。

通常の会話モードでは、agentが人間とのやり取りをしながら、内部的には各phaseコマンドを順番に呼び出す。人間が1個ずつ実行したい場合や、失敗phaseだけやり直したい場合は、同じphaseコマンドを直接実行できる。

想定形:

```text
conversation UI
  -> phase 10 command
  -> phase 20 command
  -> phase 30 command
  -> ...

manual / automation
  -> phase 20 command only
  -> replay phase 50
  -> validate phase 40
```

コマンドは標準化された入出力契約を持つ。

- input: case_id、前phase成果物、対象artifact、追加ヒアリング入力
- output: phase artifact、event log、ledger更新、open questions、validation result
- options: dry-run、validate-only、resume/replay、force禁止または明示承認

会話は正本ではなく、phase commandの入力を集め、結果を人間に説明し、必要な承認を取るUIとして扱う。正本はPhase Ledger、Event Log、Artifact、Manifest/IRに置く。

## Evidence
ユーザー発話: 「コンパイラと言いつつ、業務OS的な状態を作らないといけない」「会話で進める機能はいるが、それとは別に人間が1個ずつ実行したい場面もある。数字毎にコマンドで実行できるようにして、通常会話だとそのコマンドを順番に実行するフローがよいのでは」という設計案。

## Risk
コマンド粒度を早く細かくしすぎると、CLI/runner作りが目的化し、要求定義やIRが遅れる。最初はphase単位の薄いcommand contractだけを固定し、内部実装はYAML/Python/手動handoffの最小構成に留める。

会話UIとコマンド実行面の二重管理になるリスクがある。会話はledger/event/artifactを直接の正本にせず、必ずphase command経由で状態を更新する設計に寄せる。
