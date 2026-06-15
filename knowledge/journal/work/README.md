# Work Journal

このフォルダには、`impact-orchestrator` が作る作業前の work card と、並列作業用のactive lock台帳を置く。

work cardは、実装前に目的、影響、読むもの、完了gateを切るための作業ログである。要求、設計、決定、業務artifactの正本ではない。

## files

| file | 役割 |
|---|---|
| `README.md` | この説明 |
| `locks.json` | active file lock台帳。完了時に空へ戻す |
| `*.md` | `impact-orchestrator` が作るwork card |

## 運用

- 作業開始時に `impact-orchestrator` でwork cardを作る。
- `-Files` に対象ファイルを渡すと、`locks.json` にactive lockが入る。
- 作業完了時に `impact-orchestrator -Complete -WorkCard ...` でwork cardを閉じ、lockを解放する。
- 長期的に残すべき採用理由は `knowledge/docs/decisions/` へ移す。未確定の知識候補は `knowledge/pending/` へ移す。
