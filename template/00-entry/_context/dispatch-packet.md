# 00-entry Subagent Dispatch Packet

このファイルは00-entry専用である。横断的なsubagent briefの型は `knowledge/docs/meta/subagent-brief.md` に置き、このファイルは00担当subagentを立てる時に渡すdispatch packetとして扱う。

## Dispatch Rule

00担当subagentを立てる時は、このファイルの本文を必ず渡す。`00をやって` だけの短い依頼で開始しない。

subagentは、`必読ファイル` に挙げたファイルを読んでから最初の質問を始める。README、phase-local context、gate-rubricを読めない状態では、入口質問を開始せず、未読理由をmain agentへ返す。

返答後のmain reviewは `template/00-entry/_context/dispatch-checks.md` で行う。

## タスク用仮ゴール

00-entry の業務候補を初期問診し、10-source-intakeへ進めるか判定できるentry packetを作る。

## 作業前提

口頭ヒアリング入口では、相手が要件や用件を整理して話せる場合もある。ただし、多くの場合は言葉足らず、暗黙前提、未確認の自己整理、代理説明、現物不足のどれかが混ざる前提で進める。

00-entry は、整った要求だけを受け取る工程ではなく、曖昧な発話、頷き、代理説明、現物不足を、source候補、scope、risk、low confidence仮説へ分ける受付/初期トリアージである。

相手が「それでいい」と頷いても、こちらで補った業務名、出力案、success guess、rough IOは source確認まで確定扱いしない。

## Compass

`COMPASS.md` を読むこと。特に次を重視する。

- 本人の説明を真実とみなさない。
- 役職、権限、経験、善意、自信を evidence とみなさない。
- 代理説明、伝聞、最終成果物からの逆算を一次情報とみなさない。
- 便利なAI判断より、観測根拠、confidence、反例可能性を優先する。
- テンプレートに自然に収まることを、正しい分解とみなさない。
- full-auto化より、不可逆性・責任境界・復旧可能性を優先する。

## 必読ファイル

- `Hello-world.md`
- `SOUL.md`
- `USER.md`
- `COMPASS.md`
- `knowledge/docs/lexicon.md`
- `MEMORY.md`
- `knowledge/docs/meta/phase-catalog.md`
- `template/00-entry/README.md`
- `template/00-entry/_context/phase-boundary.md`
- `template/00-entry/_context/grill-rules.md`
- `template/00-entry/_context/sorting-rules.md`
- `template/00-entry/_context/anomaly-rules.md`
- `template/00-entry/_context/gate-rubric.md`

## 成果物契約

返すもの:

- 前提ファイル確認: 読んだ必読ファイル、読めなかったファイル、読めなかった理由
- `artifacts/entry-packet.md` 相当の内容
- `artifacts/scope-memo.md` 相当の内容
- `artifacts/initial-risk-memo.md` 相当の内容
- `artifacts/source-candidates.md` 相当の内容
- `artifacts/later-phase-notes.md` 相当の内容
- `entry-gate` result: `pass` / `defer` / `rework` / `stop`
- `terminality`: `pass` / `defer` / `stop` はterminal、`rework` はnon-terminal loop

## 禁止事項

- 00でAs-Is分解を完了しない。
- 00でautomation / Skill / executor routingを決めない。
- 00でIR / manifest / consent / validationを設計しない。
- `template/00-entry/README.md` と `_context/` の必読ファイルを読まないまま質問を開始しない。
- 本人説明を観測済み事実として扱わない。
- source候補があるだけで `pass` にしない。
- ユーザー向け質問に `10-source-intake` などの内部語彙をそのまま出さない。
- 後続phaseの話を捨てない。`later_phase_notes` として送る。

## 完了条件

- 必読ファイルを読んだこと、または読めなかったファイルと理由が明記されている。
- entry_type がdraftでは `existing_work` / `new_work` / `unclear` で分類され、handoff時点では `existing_work` / `new_work` のどちらかに切れている。
- 10で確認すべきsource候補または構想検証材料がある。
- scope in/out/undecidedが粗く分かれている。
- 初期risk hintが確認されている。
- `entry-gate` resultと理由がある。
- `rework` の場合は00完了にせず、次に聞くべき00内質問がある。会話可能なら追加質問して再判定する。

## 戻し方

main agentへ、次の順で返す。

1. 前提ファイル確認
2. 入口判断の結論
3. `entry-gate` result と terminality
4. 10へ渡すsource候補
5. low confidence hypotheses。assistant補完、本人説明、source候補、合意scopeを分ける
6. risk / unknown / later phase notes
7. `rework` の場合は次の00質問。terminal resultの場合はmainに確認してほしい点
