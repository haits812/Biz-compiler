# Initial Risk Memo

00-entry 時点の初期risk hint。ここではgate配置を決めない。10以降で確認するための注意として残す。

## Risk Hints

| risk_id | Risk Type | Status | Note | Suggested Source / Next Check |
|---|---|---|---|---|
| `R-001` | `external_impact` | `yes/no/unknown` | `<他部署、社外、顧客、共有interface>` | `<10で確認するsource>` |
| `R-002` | `sensitive_data` | `yes/no/unknown` | `<個人情報、契約情報、機密情報>` | `<10で確認するsource>` |
| `R-003` | `irreversible_action` | `yes/no/unknown` | `<外部送信、発注、確定、削除、権限変更>` | `<10で確認するsource>` |
| `R-004` | `approval_need` | `yes/no/unknown` | `<人間確認が必要そうな箇所>` | `<10で確認するsource>` |
| `R-005` | `responsibility_unclear` | `yes/no/unknown` | `<責任者/停止者が不明>` | `<10で確認するsource>` |

## Notes

- 00では、riskの有無を初期確認するだけで、gate設計はしない。
- high-riskの可能性がある場合、`checks.md` で `defer` または `rework` を検討する。