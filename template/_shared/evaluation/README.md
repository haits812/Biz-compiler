# Template Shared Evaluation

`template/_shared/evaluation/` は、複数phaseで再利用する評価fixtureを置く場所である。

ここに置くものは、特定phaseの正本手順ではない。phase-local prompt、contract、gate、validator、subagent brief を変更した後、同じ入力条件で挙動を比較するための共通テスト材料である。

## Assets

- `personas/`: 1人1フォルダの安定persona設定。回答側persona agentへ渡す正本。
- `persona-test-matrix.md`: 38 personaから、まともな人、危険な人、初手資料持ち込み、代理/伝聞などを探すための参照index。
- `fixtures/upfront-existing-materials/`: persona 31-38で使う初手資料持ち込みfixture。既存フロー、手順書、Excel風台帳、古いマニュアル、代理者持参フロー、資料内容と発話が噛み合わないフローを含む。

## Paired Subagent Protocol

persona fixtureを使う対話テストは、質問側agentと回答側persona agentを分ける。

| Role | 渡すもの | 渡さないもの |
|---|---|---|
| 質問側phase agent | `COMPASS.md`、対象phase README、phase-local `_context/`、gate/checks | personaの内部期待gate以外の答え |
| 回答側persona agent | `personas/<id>/persona.md` のPersona Prompt、部署/役職、初回テーマ、必要なら疑似資料だけ | `COMPASS.md`、Biz-compiler語彙、phase README、gate/checks、Evaluator Notes |
| main reviewer | transcript、期待gate、成果物、差分評価 | 回答側personaへの誘導prompt |

回答側persona agentは、普通の業務依頼者として回答する。`phase`、`gate`、`source-first`、`confidence` などのBiz-compiler内部語彙を使わせない。

main agentが一人二役で会話を作るテストは、厳密な回帰テストとして扱わない。使えるのは粗いスモークまでである。

## Upfront Existing Material Variant

00-entryの回帰テストでは、通常の初回発話に加えて、ユーザーが最初から既存フロー、手順書、マニュアル、Excel、業務一覧を渡してくるvariantも使う。

このvariantで見ること:

- 質問側phase agentが、資料を観測済みAs-Isや正本として扱わないか。
- 資料のowner、更新日、対象scope、実担当者、例外、差戻し履歴、実運用との差分を確認しに行くか。
- 資料があるだけで `pass` にせず、未確認なら `defer` に倒せるか。
- 代理者が資料だけ持っている場合、本人またはsource holderへの実接続前に `pass` にしないか。
- 資料内容と依頼者発話が別業務、別scope、別権限へズレている場合、黙って統合せず `defer` / `rework` に倒せるか。


## Deterministic Smoke Runner

00-entryから10-source-intakeまでの契約・handoff・finalize回帰は、次のrepo-local runnerで38 persona全員分を通す。

```powershell
.\template\_shared\internal\runner\replay\run-00-10-persona-smoke.ps1
```

このrunnerは、各personaの期待gateから合成したphase resultを使い、既存の `template/00-entry/phase-orchestrator.ps1` と `template/10-source-intake/phase-orchestrator.ps1` を実際に呼ぶ。確認範囲は、00 review/finalize、10 start/review/finalize、10から20へ渡す `handoff.md` と `source-inventory.md` / `intake-log.md` / `fact-register.md` のmaterializeである。

これはpaired subagent会話評価の代替ではない。LLMが自然会話から正しい質問を出せるか、persona agentが普通の業務依頼者として破綻なく返せるかは、上の `Paired Subagent Protocol` で別途見る。
10-source-intake reviewerの厳格化回帰は、次のrunnerで確認する。

```powershell
.\template\_shared\internal\runner\replay\run-10-source-intake-review-regression.ps1
```

このrunnerは、10成果物のpositive/negative fixtureを直接 `template/10-source-intake/phase-orchestrator.ps1 review` に通す。特に、source intake interaction metadata欠落、資料確認もsource holder接続もないterminal result、`person_explanation` の `provenance=observed` 昇格、標準外 `reported` provenance、passなのに実資料確認なし、を落とせるかを見る。
## Boundary

- 00-entryだけの質問規則は `template/00-entry/_context/` に置く。
- phase横断で同じpersonaを使う評価材料は `personas/` に置く。`persona-test-matrix.md` は選抜用indexとして使う。
- 実行runner、schema、validator本体は `template/_shared/internal/` 側に置く。