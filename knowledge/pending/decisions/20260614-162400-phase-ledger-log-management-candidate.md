# phase ledger / log management 設計候補

## Target
future IR schema / knowledge/docs/decisions / output repo template

## Proposed Change
Biz-compilerでは、ヒアリングした業務を1つずつ自動化していく過程を、agentが後から遡れるようにする必要がある。ログ管理は単なるチャットログ保存ではなく、次の2層で設計する候補。

1. Phase Ledger: 各数字フェーズの現在状態と成果物への索引。agentが「phase 20で何をしたか」「phase 50で何に同意したか」を読むための正本。
2. Event Log: ヒアリング、判断、凍結、差戻し、検証、再コンパイル、承認、却下などの時系列イベント。Phase Ledgerの各状態がなぜそうなったかを追跡する監査ログ。

`pipeline-flowchart.html` はこの正本を可視化するviewerに留める。HTML自体をログ正本にしない。

## Draft Model

```yaml
case_id: sample-case
phases:
  - phase: 10
    name: source-intake
    status: frozen
    current_artifacts:
      - artifacts/phases/10/source-summary.yaml
    depends_on: []
    event_refs:
      - events/2026-06-14T10-00-00Z-intake-start.yaml
      - events/2026-06-14T10-30-00Z-phase-freeze.yaml
    open_questions: []
    invalidates_downstream_when:
      - scope_changed

  - phase: 20
    name: decompose-encrs-pass-1
    status: draft
    depends_on:
      - phase: 10
    current_artifacts:
      - artifacts/phases/20/ipo-nodes.yaml
    open_questions:
      - id: q-approval-owner
        text: 例外時の承認者が未確定
```

```yaml
# event例
id: evt-20260614-103000-freeze-p10
case_id: sample-case
phase: 10
type: phase.freeze
actor: human
summary: 現業ヒアリングの初回範囲を凍結
evidence:
  - source: transcript
    ref: transcripts/2026-06-14-intake.md
affects:
  artifacts:
    - artifacts/phases/10/source-summary.yaml
  downstream_phases:
    - 20
    - 30
```

## Key Requirements

- 後続phaseは過去phaseの全文ではなく、Phase Ledgerから成果物索引・決定・未解決論点・検証状態を引く。
- 各phaseは `status` を持つ。例: `draft` / `frozen` / `validated` / `stale` / `superseded` / `blocked`。
- phase間依存はDAGとして扱い、循環を拒否する。
- upstream phaseが変更されたら、downstream phaseを `stale` にできる。
- event logはappend-onlyを基本とし、修正は過去イベントの上書きではなく新イベントで表現する。
- 人間向けUIは後から作る。最初はagentが読むYAML/JSON正本を優先する。
- `60` は初回構築時の検証、`70/80` は運用後の改善で作り直した成果物の再検証として扱う。
- 70/80では、実運用ログをdrift検出・改善案作成・昇降格判断・near-miss評価の入力に使う。検証対象はログそのものではなく、ログやdriftを根拠に作った改善後成果物である。
- 改善案を作った場合、本番反映や自律レベル昇格の前に、改善後成果物に対する再検証イベントを残す。

## Evidence
ユーザー発話: `pipeline-flowchart.html` はあとから可視化する場所として話していた。ヒアリング業務の各数字について、あとから何をしたか確認できるログ管理も設計する必要がある。追加発話: 80だけ扱う運用セッションでは表の在り方が変わる。運用中にログをため、後で検証に使える設計が必要。改善して作った内容を再度検証するため、70/80に改善後成果物の再検証が入っていないと成立しない。

## Risk
ログ管理を重くしすぎると、初期MVPが台帳作りだけで止まる。最初は1ケース1ファイルの `phase-ledger.yaml` とappend-only `events/` 程度に抑え、DB/Kanban/UIは後回しにするべき。




