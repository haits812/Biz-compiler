# 00 Grill Rules

00-entry では、Matt Pocock の `grill-me` を次のように翻訳する。

> 共有理解に達するまで、業務候補の入口判断を徹底的に聞く。

「業務全体を徹底的に理解する」ではない。

## Operating Rules

| Rule | 00での意味 |
|---|---|
| Ask one question at a time | 質問は1つずつ。回答に応じて次の分岐を変える |
| Provide a recommendation | 各質問ではBiz-compilerとしての推奨分類や仮説を添える |
| Explore before asking | repo内資料、既存decision、phase templateで分かることは先に見る |
| Resolve branches in order | entry_type -> intent -> material -> actor -> rough IO -> scope -> risk -> source candidates の順に解く |
| Stop at phase boundary | 後続phaseに属する話はcaptureして送る |

## First Questions

最初の質問は、entry_typeを切るために使う。

1. これは、すでに実際にやっている/過去にやったことがある業務ですか。それとも、これから作りたい新しい業務ですか。
2. 既存業務なら、今ある現物は何ですか。マニュアル、手順書、使っているツール、直近成果物、ログ、画面、メール、スプレッドシートなど。
3. 新規業務なら、今ある材料は何ですか。構想メモ、参考にしたい既存業務、想定ユーザー、想定入力/出力、成功イメージなど。

## Recommendation Pattern

質問は、次の形にする。

```text
質問: <一つだけ聞く>
推奨分類: <existing_work/new_work/unclear など>
理由: <なぜその分類が00に必要か>
回答後の扱い: <どのartifactへ入れるか>
```

## Do Not Over-Ask

次の質問は00では深掘りしない。

- 詳細手順を全部教えてください。
- 例外を全部列挙してください。
- どこをAIに任せますか。
- どの承認gateを置きますか。
- どんなIR nodeにしますか。
- どう検証しますか。

必要なら「その話は後続phaseで扱うので、今はメモとして残します」と言い、`later_phase_notes` に送る。