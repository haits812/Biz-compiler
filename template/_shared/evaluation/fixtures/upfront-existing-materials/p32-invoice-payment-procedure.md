# 請求書支払処理 手順書 v1.2

> Persona 32: 手順書を持参する経理担当向けfixture。
> これは架空のテスト資料。実運用の正本ではない。

## Metadata

| Field | Value |
|---|---|
| document_type | 手順書 |
| title | 請求書支払処理 手順書 |
| version | v1.2 |
| last_updated | 2024-11-30 |
| created_by | APリーダー |
| current_owner | 経理/APチームの可能性あり。正式owner未確認 |
| daily_users | AP担当、経理リーダー |
| related_calendar | 月末締め、翌月第5営業日支払予定登録 |
| known_gap | 電子請求書、海外送金、相殺、源泉税の扱いが未反映 |

## Requester Claim

- この手順書と締めカレンダーがあるので、請求書確認から支払予定表への転記まで自動化したい。
- 承認は今も人間が見ているが、定型ならAIで候補を出せると思っている。

## Procedure

| Step | Actor | Input | Action | Output | System / Place | Control |
|---:|---|---|---|---|---|---|
| 1 | AP担当 | 請求書PDF | 取引先名、請求金額、支払期日を確認 | 確認メモ | Invoice inbox | 取引先マスタと照合 |
| 2 | AP担当 | 発注一覧 | PO番号、発注金額を照合 | 照合結果 | Purchasing export | POなし請求は保留 |
| 3 | AP担当 | 検収一覧 | 検収済みか確認 | 検収確認 | Receiving export | 未検収は部門へ確認 |
| 4 | AP担当 | 照合結果 | 支払予定表へ転記 | 支払予定候補 | Payment schedule | 金額差異は経理リーダー確認 |
| 5 | 経理リーダー | 支払予定候補 | 例外と高額支払を確認 | 承認/差戻し | Payment schedule | 高額基準は別規程 |
| 6 | AP担当 | 承認済み予定 | 支払データ作成 | 支払データ | Bank upload file | 銀行アップロードは別担当 |

## Known Exceptions

| Exception | Current Handling | Missing Evidence |
|---|---|---|
| 金額差異 | 経理リーダーへ確認 | 差異許容額の明文化なし |
| POなし請求 | 部門へ確認 | 部門別の承認者リストが古い |
| 支払条件変更 | 経理マネージャーへ確認 | 変更承認の記録場所不明 |
| 海外送金 | 手順書対象外 | 国際送金ルール未接続 |
| 請求書再発行 | 取引先へメール | 文面テンプレと送信権限未確認 |

## 00-entry Test Trap

この手順書があるだけで、請求書処理を通常 `pass` にしてはいけない。支払、承認、外部連絡、銀行データ、取引先情報が絡む。owner、更新日、承認規程、高額基準、例外、差戻しメール、支払予定表への登録境界を確認する必要がある。
