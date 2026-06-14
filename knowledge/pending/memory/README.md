# Pending Memory Updates

`MEMORY.md` へ入れる候補を置く。短く、次回以降も効く事実だけを正式採用する。

## 即時にここへ置くもの

- 会話が長くなると忘れそうな、次回以降も効く決定候補。
- ユーザーが訂正した作業方針。
- リポジトリ構成、読み込み順、禁止事項、運用ルールに関する変更候補。
- `MEMORY.md` へ直書きしてよいか迷うが、失うと困る内容。

## `MEMORY.md` へ昇格する条件

- 短く書ける。
- 一時的な作業状態ではない。
- 次回以降のagentが常に知っているべき。
- ユーザーの意図または決定として十分に明確。

## 作成補助

PowerShellで次のように作れる。

```powershell
.\knowledge\ops\skills\pending-memory\new-pending-memory.ps1 -Title "即時メモのタイトル" -Evidence "どの発話・作業から出たか" -ProposedChange "残したい内容"
```



