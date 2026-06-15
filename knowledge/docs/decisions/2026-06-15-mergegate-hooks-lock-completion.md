# MergeGate型opsにhook adapter、file lock、completion trackingを足す

## Status

Adopted 2026-06-15

## Context

前段では、MergeGate本体を導入せず、作業前impactを切る薄い `impact-orchestrator` と `knowledge/ops/registry.md` を作った。

ただし、並列subagentや複数AI実行を前提にすると、register workだけでは足りない。Markdown文書にファイルパスやリンクを直接書いているため、コードだけでなくMarkdown参照も影響として扱う必要がある。

branch / PR state trackingはGitHub運用が固まるまで保留できる。一方で、hook adapter、file lock、completion trackingは、今から薄く持っておかないと作業衝突と未完了ログが増える。

## Decision

`impact-orchestrator` を拡張し、次を扱う。

- 作業前work card作成
- 対象ファイルのactive lock
- Markdown Reference Impactの抽出
- `-Complete` によるwork card完了記録とlock解放
- `-ListLocks` によるactive lock確認

active lockの台帳は `knowledge/journal/work/locks.json` とする。完了時には空へ戻す。

hook adapterとして `knowledge/ops/hooks/codex-pre-work.ps1`、`knowledge/ops/hooks/claude-code-pre-work.ps1`、`knowledge/ops/hooks/pre-publish.ps1` を置く。ただし、CodexやClaude Codeの外部設定ファイルはこのリポジトリから自動編集しない。

## Consequences

- 並列作業時に同じファイルを触る前に衝突を検出できる。
- Markdownにベタ書きされたリンクやファイル参照も影響としてwork cardに残る。
- 作業カードを完了状態へ閉じ、lockを解放できる。
- branch / PR state trackingは未実装のまま残す。必要になったら別途設計する。
