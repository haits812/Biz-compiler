# 00 Entry Questions

この質問票は、業務候補を Biz-compiler の対象にするか判断するための入口である。すべてを聞き切る必要はない。次に実物確認できるだけの入口情報を集める。

ユーザーへ聞く時は、`10-source-intake`、`entry_gate`、`defer`、`rework` などの内部語彙を出さない。内部artifactやhandoffでは、Classification Hint / Notes の値を使ってよい。

## First Response Shape

初回発話だけでは00を完了しない。業務候補らしさを短く受け止め、仮説扱いを明示し、次に確認できる実物またはsource holderを1つだけ聞く。

例:

> 毎月回っている請求書処理の改善候補に見えます。まだ仮置きなので、自動化範囲や確認メール送信はここでは決めません。まず実物で確認できるものを1つ選びたいです。直近の請求書PDF、Excel支払予定表、部長確認メールのうち、最初に確認できる実例はどれですか？

## Entry Type

| # | Question | Classification Hint |
|---|---|---|
| 1 | これは、すでに実際にやっている/過去にやったことがある業務ですか。それとも、これから作りたい新しい業務ですか | `existing_work` / `new_work` / `unclear` |
| 2 | 既存業務なら、今確認できる現物は何ですか。マニュアル、手順書、ツール、直近成果物、ログ、画面、メール、スプレッドシートなど | `source_candidate` |
| 3 | 新規業務なら、今ある材料は何ですか。構想メモ、参考業務、想定ユーザー、想定入力/出力、成功イメージなど | `concept_material` |
| 4 | 判断に迷う場合、過去に一度でも実行したこと、成果物、担当者、頻度はありますか | existing寄りかnew寄りかを切る |
| 5 | これは、今ある作業そのものを整理したい話ですか。それとも、困りごとを受け付ける新しい確認業務・運用を作りたい話ですか | 代理/伝聞相談を `existing_work` のAs-Is扱いにするか、`new_work` の要求候補に切り直すか |
| 6 | 対象は1つの業務ですか、複数業務を束ねる運用ですか、新規事業やチーム編成まで含む構想ですか | `work_unit = single_business / workflow_or_operation / business_program` |
| 7 | 相談者は実作業者ですか、source holderにつながっていますか、現場から聞いた代理説明ですか | `source_posture = first_party / source_holder_connected / proxy_hearsay / mixed` |

## Route Flag Confirmation

route flagは内部では最初に仮置きする。ただしユーザーへは内部語彙を出さず、自然文で確認する。

| # | Question | Classification Hint |
|---|---|---|
| 1 | これは「今ある作業を整理・改善する話」ですか。それとも「新しく業務、運用、事業の形を作る話」ですか | `entry_type` confirmation |
| 2 | 対象は1つの担当者で回る作業ですか、複数部署・複数役割が連動する運用ですか | `work_unit` / `delivery_shape` confirmation |
| 3 | 今の説明は実際に担当している立場からの話ですか、現場や別部署から聞いた話ですか | `source_posture` confirmation |
| 4 | 20では、今ある手順を分解するより先に、新しい運用/事業の構成候補を整理する方が近いですか | `20_readiness` confirmation |

確認の結果、最初の仮置きと違った場合は、仮置きしたrouteを修正してからhandoffする。確認できない場合は `route_confirmed_by_requester = not_yet` とし、`pass` / `defer` で閉じない。

## Intent
| # | Question | Notes |
|---|---|---|
| 1 | 何をしたいですか。自動化、改善、再設計、人手削減、AI支援、新規立ち上げなどのどれに近いですか | 複数可。解決策はまだ決めない |
| 2 | なぜ今それをやりたいですか | pain / trigger |
| 3 | いったん何が楽になれば成功と言えそうですか | `rough_goal`。定量化しすぎない |

## Actor / Owner

| # | Question | Notes |
|---|---|---|
| 1 | 誰の業務ですか | requester / actor candidate |
| 2 | 普段それを使う人、判断する人、承認する人は誰ですか | user / reviewer / approver candidate |
| 3 | 他部署、社外、顧客、委託先が関わりますか | N-interface候補 |
| 4 | 責任者や止める人がまだ不明ですか | risk / unknown |

## Rough Input / Output

| # | Question | Notes |
|---|---|---|
| 1 | 何を受け取って始まる業務ですか | rough input |
| 2 | 最終的に何を出しますか | rough output |
| 3 | 入力や出力の実例、サンプル、テンプレートはありますか | source_candidate |
| 4 | 判断や加工がある場合、何を見て決めていそうですか | 詳細は後続phaseへ送る |

## Scope

| # | Question | Notes |
|---|---|---|
| 1 | 今回の対象に含めるものは何ですか | scope in |
| 2 | 今回は対象外にするものは何ですか | scope out |
| 3 | まだ対象に入れるか迷っているものはありますか | undecided scope |
| 4 | 便利だからつい混ぜたくなるが、本当は別業務かもしれないものはありますか | scope creep候補 |

## Initial Risk

| # | Question | Notes |
|---|---|---|
| 1 | 個人情報、契約情報、機密情報、顧客情報に触れますか | sensitive candidate |
| 2 | 外部送信、発注、確定、削除、権限変更など、間違えると戻しにくい操作がありますか | irreversible candidate |
| 3 | 他部署、社外、顧客への影響がありますか | external / N-interface candidate |
| 4 | 間違えると誰が困りますか | responsibility / harm candidate |
| 5 | 人間が必ず確認すべきそうな箇所はありますか | approval hint |

## Source Handoff

| # | Question | Notes |
|---|---|---|
| 1 | 次に最初に確認するなら、どの資料・画面・ログ・実例がよさそうですか | source_candidates |
| 2 | まだ手元にないが、取れそうな資料は何ですか | target source |
| 3 | 取れない、見られない、存在しない資料はありますか | unavailable source |
| 4 | 本人説明だけで、まだ根拠がない重要な話は何ですか | unknown / low confidence |

## 20 Readiness Questions

| # | Question | Notes |
|---|---|---|
| 1 | 20では、今ある作業の分解をしたいですか。それとも、新しい業務/運用の要件候補を整理したいですか | `as_is_decompose` / `requirements_candidate` を切る |
| 2 | 新規事業や大きめの運用を作る話なら、役割や担当群を複数置く必要がありますか | `business_design_candidate` / `multi_executor_team` 候補。ただし配置確定は後続phase |
| 3 | 代理説明のまま現場作業を分解しようとしていませんか | proxy/hearsayならsource holder接続かnew_workへの切り直しが必要 |

## Stop Questions

| # | Question | Action |
|---|---|---|
| 1 | 業務候補を一文で言えますか | 言えなければrework |
| 2 | 既存業務か新規構想か切れますか | 切れなければrework |
| 3 | 次に何を確認すればよいか見えますか | 見えなければrework |
| 4 | 単発作業であり、業務コンパイルではない可能性がありますか | stopまたは別作業へ |
