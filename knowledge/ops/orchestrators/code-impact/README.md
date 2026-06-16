# Code Impact Orchestrator

`code-impact` は、Biz-compiler のメタ土台に対して、変更対象から読むべき関連ファイル候補を高速に辿るための repo-local orchestrator である。

これは安全判定器ではない。コードを壊さない保証、taint の証明、依存関係の完全性、実行時影響の網羅はしない。目的は、作業前に「このファイルを触るなら、近くのどこを読めばよさそうか」を軽く出すことにある。

## 原則

- 正本は Markdown、registry、contract、manifest、template、script である。
- SQLite は `knowledge/.index/code-impact.sqlite` に置く生成 index であり、直接編集しない。
- `knowledge/.index/*.sqlite` と `knowledge/.index/*.sqlite-*` は git 管理しない。
- v0 は Biz-compiler メタ土台専用である。`output/Biz-*` の個別業務成果物は対象外にする。
- MCP、Web UI、vector search、PDG、taint 本格解析は入れない。

## 対象

| source | 対象 |
|---|---|
| `root` | root 正本ファイル。例: `AGENTS.md`、`Hello-world.md`、`COMPASS.md`、`MEMORY.md` |
| `knowledge_docs` | `knowledge/docs/` |
| `knowledge_pending` | `knowledge/pending/` |
| `knowledge_journal` | `knowledge/journal/` |
| `knowledge_ops` | `knowledge/ops/` |
| `template` | `template/` |

対象外:

- `output/`
- `knowledge/.index/`
- `.git/`
- `node_modules/`、`.venv/`、`__pycache__/` などの生成物や依存物

## 抽出するもの

v0 は軽量な文字列抽出に留める。

- repo内に実在する相対path、basename、stem
- PowerShell の `function Name`、param名、script名
- Python の `def`、`class`、argparse command名
- Markdown links、inline code、fenced code内のコマンドやpath
- JSON / HTML内JSON の `"key":` 形式key
- risk hint: `shell`、`Start-Process`、`Invoke-WebRequest`、`Set-Content`、`Remove-Item`、secret/env、外部送信っぽい語

## Commands

indexを作る。

```powershell
.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 index
```

DBを削除して作り直す。

```powershell
.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 rebuild
```

状態を見る。

```powershell
.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 status
```

関連候補を辿る。

```powershell
.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query `
  -Files "MEMORY.md;knowledge/ops/registry.md" `
  -Depth 2 `
  -Format markdown
```

JSONで返す。

```powershell
.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query `
  -Files "MEMORY.md" `
  -Depth 2 `
  -Format json
```

`query` は index が古い時に nonzero exit で止まる。古い index を承知で見る時だけ `-AllowStale` を付ける。

```powershell
.\knowledge\ops\orchestrators\code-impact\code-impact.ps1 query -Files "MEMORY.md" -AllowStale
```

## 出力

Markdown出力は次の節を返す。

- `Related Files`
- `Symbols And Keys`
- `Risk Hints`
- `Validation Candidates`
- `Index Status`

`impact-orchestrator` は `-Files` がある register で既定でこの出力を work card の `Code Impact Candidates` として添付する。不要な時だけ `-NoCodeImpact` を付ける。

## Flow Integration

`code-impact` は2つのタイミングで使う。

- `hello-world-gate`: GitHubへ上げる前の出口gateで `code-impact rebuild` を自動実行し、生成graphを最新化する。
- `impact-orchestrator`: 作業前 register で `-Files` がある時に `code-impact query` を自動実行し、読むべき関連候補を work card に添付する。

`impact-orchestrator` 側で index が無い、または古い場合は、自動で rebuild してから query を再実行する。
## 限界

- grepより賢い補助線であり、静的解析器ではない。
- 名前一致とpath一致に寄せるため、同名ファイルや汎用keyではノイズが出る。
- `weak token fanout` が大きいtokenは展開を止める。
- `risk hint` は注意喚起であり、taint解析や安全証明ではない。
- `output/Biz-*` の横断解析は将来別設計にする。