# Persona Fixtures

`personas/` は、phase横断のpaired subagent testで使う回答側personaの安定設定である。

1人につき1フォルダを持ち、各フォルダの `persona.md` をその人物像の正本として扱う。`persona-test-matrix.md` は、まともな人、危ない人、初手資料持ち込み、代理/伝聞などを探すための参照indexであり、persona本文の正本ではない。

## Usage

- 回答側persona agentには、原則として対象フォルダの `persona.md` を渡す。
- 質問側phase agentには、対象phaseのREADME、phase-local `_context/`、gate/checksを渡す。
- 回答側persona agentには、Biz-compiler内部語彙やgate期待値を必要以上に渡さない。
- Evaluator Notes はmain reviewerまたは質問側検査用であり、回答側へ渡す時は省いてよい。

## Folder Rule

フォルダ名は `<2桁ID>-<stable-slug>` とする。IDは `persona-test-matrix.md` の `#` と一致させる。

## Matrix

`../persona-test-matrix.md` は次に使う。

- phase別にどのpersonaを使うか選ぶ。
- 正統派、危険、代理、低言語化、初手資料持ち込みなどを検索する。
- `00初回期待判定` と `00で見る観点` を比較する。

## Persona Index

| # | Persona | Config |
|---:|---|---|
| 01 | 請求書処理担当 | `personas/01-invoice-processing-ap/persona.md` |
| 02 | Vendor onboarding担当 | `personas/02-vendor-onboarding/persona.md` |
| 03 | うまく説明できない担当者 | `personas/03-low-articulation-sales/persona.md` |
| 04 | 単発依頼者 | `personas/04-one-off-apology/persona.md` |
| 05 | 怪しい外部連絡担当 | `personas/05-suspicious-vendor-bank-info/persona.md` |
| 06 | まとまらない依頼者 | `personas/06-incoherent-ai-secretary/persona.md` |
| 07 | AP担当 一般社員 | `personas/07-ap-invoice-reconciliation/persona.md` |
| 08 | 採用コーディネーター 主任 | `personas/08-recruiting-coordinator/persona.md` |
| 09 | 契約管理担当 一般社員 | `personas/09-nda-status-management/persona.md` |
| 10 | バイヤー 係長 | `personas/10-buyer-quote-comparison/persona.md` |
| 11 | オフィスマネージャー 課長 | `personas/11-office-asset-return/persona.md` |
| 12 | 営業マネージャー | `personas/12-sales-weekly-progress/persona.md` |
| 13 | チームリード | `personas/13-cs-refund-escalation/persona.md` |
| 14 | キャンペーン担当 一般社員 | `personas/14-marketing-ad-report/persona.md` |
| 15 | PM | `personas/15-product-release-notes/persona.md` |
| 16 | 営業Opsアナリスト | `personas/16-sales-ops-crm-cleanup/persona.md` |
| 17 | ヘルプデスクリード | `personas/17-it-helpdesk-account-lifecycle/persona.md` |
| 18 | 現場スーパーバイザー | `personas/18-logistics-shipping-delay/persona.md` |
| 19 | 品質管理アシスタント | `personas/19-qa-defect-triage/persona.md` |
| 20 | アソシエイト | `personas/20-audit-evidence-collection/persona.md` |
| 21 | 部長 | `personas/21-expense-approval-visibility/persona.md` |
| 22 | 無自覚係長 | `personas/22-unaware-sales-admin-lead/persona.md` |
| 23 | 視野狭い一社員 | `personas/23-narrow-ap-clerk/persona.md` |
| 24 | ベテラン属人化 | `personas/24-qa-tacit-veteran/persona.md` |
| 25 | 部分最適マネージャー | `personas/25-cs-local-optimization-manager/persona.md` |
| 26 | ツール信仰担当 | `personas/26-it-workflow-believer/persona.md` |
| 27 | 偽ベテラン新人 | `personas/27-procurement-fake-veteran-newcomer/persona.md` |
| 28 | 権限はあるが現場を知らない上位者 | `personas/28-executive-without-observation/persona.md` |
| 29 | 善意のプライバシー無自覚担当 | `personas/29-benign-privacy-blindness/persona.md` |
| 30 | 代理依頼者 / 伝聞依頼 | `personas/30-proxy-hearsay-request/persona.md` |
| 31 | フロー図を持参する総務担当 | `personas/31-onboarding-flow-carrier/persona.md` |
| 32 | 手順書を持参する経理担当 | `personas/32-ap-payment-procedure-carrier/persona.md` |
| 33 | Excel台帳を正本視する営業企画担当 | `personas/33-sales-pipeline-excel-believer/persona.md` |
| 34 | 古いマニュアルを渡すCSリーダー | `personas/34-stale-cs-refund-manual/persona.md` |
| 35 | 現場フローだけ持ってきた業務企画担当 | `personas/35-proxy-order-processing-flow/persona.md` |
| 36 | 部下の業務フローを誤読する上司 | `personas/36-manager-misreads-team-flow/persona.md` |
| 37 | 自信だけある勘違い新入社員 | `personas/37-overconfident-procurement-newcomer/persona.md` |
| 38 | フローを持っているが話が飛ぶ依頼者 | `personas/38-incoherent-expense-flow/persona.md` |
| 39 | 部門横断新規事業プログラム担当 | `personas/39-cross-functional-business-program/persona.md` |
