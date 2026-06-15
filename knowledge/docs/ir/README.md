# IR

Biz-compiler の契約データ、IR、manifest、schemaの読み方を置く。

## Read When

- IR、contract、schema、manifestを作る/変更する時
- 同意ビューJSONと実行IRの関係を触る時
- `template/_shared/internal/schemas/` に影響する時
- `gate_policy`、`provenance`、`confidence`、scope境界を機械可読にする時

## Put Here

- IRの概念設計
- schema_versionやmigration方針
- contract / manifest の意味
- UI表示と機械可読正本の境界
- gate policy、evidence、confidenceの共通ルール

## Documents

- `minimum-ir-attributes.md`: Compassから逃がしたIR最小属性と、観測済み契約/未検証仮説の分離ルール。
- `gate-policy-matrix.md`: scope、不可逆性、executor、confidenceなどから最低gateを決めるv0 matrix。
- `evidence-confidence-model.md`: provenance、evidence、counter_evidence、confidenceの上げ下げを扱うv0 model。