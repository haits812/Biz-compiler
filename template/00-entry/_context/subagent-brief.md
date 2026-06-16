# 00-entry Subagent Brief Template

## タスク用仮ゴール

00-entry の業務候補を初期問診し、10-source-intakeへ進めるか判定できるentry packetを作る。

## Compass

`COMPASS.md` を読むこと。特に次を重視する。

- 本人の説明を真実とみなさない。
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

- `artifacts/entry-packet.md` 相当の内容
- `artifacts/scope-memo.md` 相当の内容
- `artifacts/initial-risk-memo.md` 相当の内容
- `artifacts/source-candidates.md` 相当の内容
- `artifacts/later-phase-notes.md` 相当の内容
- gate result: `pass` / `defer` / `rework` / `stop`

## 禁止事項

- 00でAs-Is分解を完了しない。
- 00でautomation / Skill / executor routingを決めない。
- 00でIR / manifest / consent / validationを設計しない。
- 本人説明を観測済み事実として扱わない。
- 後続phaseの話を捨てない。`later_phase_notes` として送る。

## 完了条件

- entry_type が `existing_work` / `new_work` / `unclear` で分類されている。
- 10で確認すべきsource候補または構想検証材料がある。
- scope in/out/undecidedが粗く分かれている。
- 初期risk hintが確認されている。
- gate resultと理由がある。

## 戻し方

main agentへ、次の順で返す。

1. 入口判断の結論
2. gate result
3. 10へ渡すsource候補
4. risk / unknown / later phase notes
5. mainに確認してほしい点