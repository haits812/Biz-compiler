# CrewAI作法をBiz-compiler作り方規約として借用する候補

## Target
future coding convention / output repo template / phase ledger / IR schema / runner convention

## Proposed Change
CrewAI本体を実行基盤として導入するのではなく、作り方の分離原則だけをBiz-compilerへ借用する候補。

借用候補:

- 設定と実行コードを分ける: `flows/*.yaml` や phase/IR 契約に「何をやるか」を置き、`scripts/` や runner に「どう実行するか」を置く。
- Task単位に成果物契約を持たせる: `description`、`expected_output`、`output_file`、構造化出力、guardrail、人間レビュー要否を明示する。
- Flowは固定し、AI判断は限定ノードへ閉じ込める: 業務全体を自由なmulti-agent会話にせず、phase contract / workflow / state machineを正本にする。
- Toolは限定関数として扱う: DBや外部サービスをAIへ自由操作させず、allowlistされた狭い関数にする。
- run単位のstate/artifact/logを残す: 再実行、監査、差戻し、70/80の改善に使えるよう、入力・状態・AI依頼・AI応答・成果物・ログを保持する。

重要な補正: 「LLM APIオーケストレーションをしない」という意味ではない。オーケストレーション自体はしてよい。ただし、Python実行中にLLMが必要な箇所はOpenAI/Anthropic等のAPIを直接呼ぶ前提にせず、CodexまたはClaude Codeへ明示的に作業委譲するステップとして扱う。つまり、Python runnerは決定論的I/O、状態管理、成果物検証、handoff bundle生成を担当し、LLM判断・文章生成・コード生成が必要なところはCodex/Claude Codeが実行者になる。

Biz-compilerへの翻訳では、CrewAIの `Agent / Task / Tool / Flow / State / Guardrail` をそのまま名称輸入するのではなく、既存の `IPO / IR / manifest / gate / Phase Ledger / Event Log` と対応づけて採用可否を判断する。

## Evidence
ユーザー発話: crewAIInc/crewAIをそのまま使う気はないが、コーディング規約・作り方統一のルールとして参考にするのはどうか、という相談。

追加訂正: APIでLLMを呼ぶ想定ではないが、オーケストレーションではあってよい。Python実行時にLLMが動く箇所があれば、それはAPI呼び出しではなくCodexないしClaude Codeにやらせる、という意味。

公式CrewAI README/docs確認: CrewAIは `agents.yaml` / `tasks.yaml` と `crew.py` / `main.py` を分け、Taskに `expected_output`、`output_file`、structured output、guardrail、human inputなどを持たせ、Flowsでstate/persistence/branchingを扱う。

## Risk
CrewAIの用語をそのまま持ち込むと、Biz-compiler固有のphase contract、IR、gate、70/80運用ループがCrewAI風のagent実行基盤へ引っ張られる。借用対象は構造化の作法に限定し、本体導入やAPIベースのmulti-agent自律実行を前提にしない。

LLM実行をCodex/Claude Code委譲にすると、純粋なPythonプロセス内で完結する再現性は下がる。これを補うため、handoff bundle、入力スナップショット、期待出力、受け入れ条件、生成結果、検証ログをrun artifactとして残す必要がある。
## Additional Note: 横断機構とphase内適用を分ける

CrewAI由来の作法は、人間側の価値で見ると `迷わない`、`頼み方がブレない`、`忘れない`、`やり直せる`、`勝手に進まない`、`暴走しない` に整理できる。これらはBiz-compilerの数字phase全体を横断して必要になるものと、各phase内で個別に必要になるものに分かれる。

横断して必要なもの:

- Flow/手順: phase間の進行、分岐、再開位置を管理する。
- Task/作業依頼契約: Codex/Claude Code/人間/automationへ渡す作業単位を統一する。
- Artifact/成果物管理: phaseごとの出力、同意済み契約、検証対象を索引化する。
- State/Event Log: 現在地、判断、凍結、差戻し、検証、承認を追跡する。
- Checkpoint/Replay: 失敗箇所や古くなったphaseだけをやり直す。
- Guardrail/Gate: schema、禁止組合せ、人間承認、N-interfaceを次工程前に検査する。
- Tool allowlist: 実行者が触れる外部作用やデータ境界を限定する。

phase内で個別に必要なもの:

- 10: 入力源、観測根拠、provenance、ヒアリング未確認事項を落とさない。
- 20: IPO分解、ENCRS、disposition、孤児手順ゼロを検査する。
- 30: executor振り分け、tool許可、autonomy/gate/riskの危険組合せを拒否する。
- 40: 6層蒸留、IR、confidence、counter evidenceを構造化する。
- 50: 人間が同意する粗い契約ビューと、機械可読契約の一致を確認する。
- 60: fresh executor、型/構造検証、受け入れ条件を検査する。
- 70: drift、near-miss、差戻しから改善案を作り、改善後成果物を再検証する。
- 80: 昇格/降格、定着、監査、運用上の自立化を判断する。

この分離により、CrewAIの機能名をそのまま導入するのではなく、Biz-compilerの数字phaseを支える共通OS部分と、各phaseの具体ワークに分けて設計できる。

