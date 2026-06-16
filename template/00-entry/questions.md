# 00 Entry Questions

この質問票は、業務候補を Biz-compiler の対象にするか判断するための入口である。すべてを聞き切る必要はない。10-source-intakeへ進めるだけの入口情報を集める。

## Entry Type

| # | Question | Classification Hint |
|---|---|---|
| 1 | これは、すでに実際にやっている/過去にやったことがある業務ですか。それとも、これから作りたい新しい業務ですか | `existing_work` / `new_work` / `unclear` |
| 2 | 既存業務なら、今ある現物は何ですか。マニュアル、手順書、ツール、直近成果物、ログ、画面、メール、スプレッドシートなど | `source_candidate` |
| 3 | 新規業務なら、今ある材料は何ですか。構想メモ、参考業務、想定ユーザー、想定入力/出力、成功イメージなど | `concept_material` |
| 4 | 判断に迷う場合、過去に一度でも実行したこと、成果物、担当者、頻度はありますか | existing寄りかnew寄りかを切る |

## Intent

| # | Question | Notes |
|---|---|---|
| 1 | 何をしたいですか。自動化、改善、再設計、人手削減、AI支援、新規立ち上げなどのどれに近いですか | 複数可。解決策はまだ決めない |
| 2 | なぜ今それをやりたいですか | pain / trigger |
| 3 | 00時点での成功イメージは何ですか | `rough_goal`。定量化しすぎない |

## Actor / Owner

| # | Question | Notes |
|---|---|---|
| 1 | 誰の業務ですか | requester / actor candidate |
| 2 | 誰が使い、誰が判断し、誰が承認しますか | user / reviewer / approver candidate |
| 3 | 他部署、社外、顧客、委託先が関わりますか | N-interface候補 |
| 4 | 責任者や止める人がまだ不明ですか | risk / unknown |

## Rough Input / Output

| # | Question | Notes |
|---|---|---|
| 1 | 何を受け取って始まる業務ですか | rough input |
| 2 | 最終的に何を出しますか | rough output |
| 3 | 入力や出力の実例、サンプル、テンプレートはありますか | 10 source candidate |
| 4 | 判断や加工がある場合、何を見て決めていそうですか | 詳細は20/30へ送る |

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
| 2 | 外部送信、発注、確定、削除、権限変更など不可逆な操作がありますか | irreversible candidate |
| 3 | 他部署、社外、顧客への影響がありますか | external / N-interface candidate |
| 4 | 間違えると誰が困りますか | responsibility / harm candidate |
| 5 | 人間が必ず確認すべきそうな箇所はありますか | approval hint |

## Source Handoff

| # | Question | Notes |
|---|---|---|
| 1 | 10-source-intakeで最初に読むべき資料や現物は何ですか | source_candidates |
| 2 | まだ手元にないが、取れそうな資料は何ですか | target source |
| 3 | 取れない、見られない、存在しない資料はありますか | unavailable source |
| 4 | 本人説明だけで、まだ根拠がない重要な話は何ですか | unknown / low confidence |

## Stop Questions

| # | Question | Action |
|---|---|---|
| 1 | 業務候補を一文で言えますか | 言えなければrework |
| 2 | 既存業務か新規構想か切れますか | 切れなければrework |
| 3 | 10で何を読めばよいか見えますか | 見えなければrework |
| 4 | 単発作業であり、業務コンパイルではない可能性がありますか | stopまたは別作業へ |