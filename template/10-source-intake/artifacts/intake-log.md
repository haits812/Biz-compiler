# Intake Log

ヒアリング、観測、資料確認の時系列ログ。ここは事実確定の場所ではなく、後でsourceやclaimへ接続するための作業ログである。

## Log

| log_id | datetime | actor | source_id | event_type | note | follow_up |
|---|---|---|---|---|---|---|
| `L-001` | `<YYYY-MM-DD HH:mm>` | `<person/agent>` | `<S-001>` | `interview` | `<何を聞いた/見たか>` | `<次に確認すること>` |

## Event Type Hints

| event_type | 使う時 |
|---|---|
| `interview` | 本人説明やヒアリング |
| `document-read` | 資料を読んだ |
| `observation` | 実演、画面、操作を見た |
| `sample-review` | 入力例/出力例を見た |
| `contradiction` | 説明とsourceが矛盾した |
| `missing-source` | source不足が分かった |
| `scope-risk` | scope外、external、sensitive候補が出た |

## Notes

- 重要な内容は `fact-register.md` へclaimとして移す。
- 本人説明は `person_explanation` として移し、観測済み事実とは分ける。
- 矛盾や違和感は削らず、counter_evidence候補として残す。
