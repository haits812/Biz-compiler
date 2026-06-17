# 00 Grill Rules

00-entry では、Matt Pocock の `grill-me` を次のように翻訳する。

> 共有理解に達するまで、業務候補の入口判断を徹底的に聞く。

「業務全体を徹底的に理解する」ではない。

## Operating Rules

| Rule | 00での意味 |
|---|---|
| Ask one question at a time | 質問は1つずつ。回答に応じて次の分岐を変える |
| Provide a recommendation | Biz-compilerとしての推奨分類や次の確認順は添える。出力案や業務像は断定しない |
| Explore before asking | repo内資料、既存decision、phase templateで分かることは先に見る |
| Resolve branches in order | entry_type -> intent -> material -> actor -> rough IO -> scope -> risk -> source candidates の順に解く |
| Stop at phase boundary | 後続phaseに属する話はcaptureして送る |
| Mark assistant guesses | こちらが置いた業務名、出力案、success guess、rough IOは `confidence = low` で記録する |
| Do not launder agreement | ユーザーの「それでいい」を、source確認済みやowner承認済みに変換しない |

## First Questions

最初の質問は、entry_typeを切るために使う。

1. これは、すでに実際にやっている/過去にやったことがある業務ですか。それとも、これから作りたい新しい業務ですか。
2. 既存業務なら、今ある現物は何ですか。マニュアル、手順書、使っているツール、直近成果物、ログ、画面、メール、スプレッドシートなど。
3. 新規業務なら、今ある材料は何ですか。構想メモ、参考にしたい既存業務、想定ユーザー、想定入力/出力、成功イメージなど。
4. 最初から業務フロー、手順書、マニュアル、Excelなどが渡された場合は、この資料がどの業務のものか、誰が使い、誰が更新し、実運用との差分や例外がありそうかを聞く。

## Recommendation Pattern

質問は、次の形にする。

```text
質問: <一つだけ聞く>
推奨分類: <existing_work/new_work/unclear など。出力案の断定ではない>
理由: <なぜその分類が00に必要か>
回答後の扱い: <どのartifactへ入れるか>
confidence: <observed / medium / low。assistant仮説ならlow>
provenance: <user_statement / source_candidate / assistant_hypothesis_from_conversation など>
```

## Low-Articulation Users

ユーザーがうまく言語化できない場合、00担当は言葉を補ってよい。ただし、補った言葉をユーザーの確定意思として扱わない。

使ってよい言い方:

```text
候補の一つとしては「<仮の業務名>」に見えます。違っていたら直してください。
この仮説はまだ low confidence として記録します。次に、実際の資料や例があるかだけ確認します。
```

避ける言い方:

```text
つまり、最初に欲しい出力は「<こちらの案>」で合っていますね。
この業務の目的は「<こちらの整理>」です。
```

低言語化ユーザーへの扱い:

- まず、資料、直近成果物、画面、ログ、Slack、メール、スプレッドシートなど、見れば分かる現物があるか聞く。
- 選択肢を出す場合は、どれも仮説として出し、選ばれたものも `confidence = low` から始める。
- 業務候補を1つ選べたら、10-source-intakeへ送れる。細部の正しさは10以降でsource確認する。ただし、具体sourceとsource holderを確認するまでは `pass` ではなく `defer` に倒す。
- 1つも選べない場合は `rework`。こちらで勝手にもっともらしい業務へ整形しない。

## Upfront Existing Materials

ユーザーが最初から既存フロー、手順書、マニュアル、Excel、業務一覧を渡してきた場合、資料があること自体を観測済みAs-Isとみなさない。

まず確認すること:

- その資料はどの業務範囲を表すか。
- 誰が作り、誰が更新し、誰が日常的に使っているか。
- 最終更新日、版、対象外、例外、差戻し履歴はあるか。
- 実担当者、source holder、ownerへ接続できるか。

00では資料の中身を詳細分解しない。資料は `source_candidate` として10へ渡し、実運用との差分確認は10/20へ送る。

## Do Not Over-Ask

次の質問は00では深掘りしない。

- 詳細手順を全部教えてください。
- 例外を全部列挙してください。
- どこをAIに任せますか。
- どの承認gateを置きますか。
- どんなIR nodeにしますか。
- どう検証しますか。

必要なら「その話は後続phaseで扱うので、今はメモとして残します」と言い、`later_phase_notes` に送る。
