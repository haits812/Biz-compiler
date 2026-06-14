# Meta Completion Criteria v0

このファイルは、Biz-compilerのメタ土台が「一旦使える」と言える条件を定義する。

ここでいう完了は、メタ土台の永久完成ではない。通常会話、subagent委譲、配置判断、状態分類、phase設計を迷わず始められるv0状態を指す。

## v0完了条件

| 条件 | 判定 | 正本 |
|---|---|---|
| State modelがある | 整備状態、主張状態、pending運用状態を混ぜないルールがある | `knowledge/docs/meta/state-model.md` |
| Phase catalogがある | 00〜80の目的、入力、出力、完了条件、handoffを一表で読める | `knowledge/docs/meta/phase-catalog.md` |
| Artifact placementがある | root、knowledge、template、outputの配置判断を説明できる | `knowledge/docs/meta/artifact-placement.md` |
| Lexicon v0がある | gate、approval、validation、IR、contract、manifest等の初期語彙がある | `knowledge/docs/lexicon.md` |
| Session brief型がある | 通常会話の仮ゴール、scope、読むもの、成果物、完了条件を扱える | `knowledge/docs/meta/session-brief.md` |
| Subagent brief型がある | subagentにCompassと別の仮ゴール、成果物契約、禁止事項を渡せる | `knowledge/docs/meta/subagent-brief.md` |
| Ledger更新ルールがある | メタ土台の整備状態、正本、併読、依存、次アクションを台帳管理できる | `knowledge/docs/meta/README.md` |
| Read routingがある | meta/, lexicon.md, ir/, method/, casebook.md, evaluation.md, decisions/を作業種別で読める | `knowledge/docs/README.md` |
| Hello World Gateが通る | 構成変更後に現在地、検査、commit/pushを同期できる | `knowledge/ops/skills/hello-world-gate/` |

## v0では不要なもの

- JSON台帳
- 台帳validator
- README自動生成
- phase-local成果物雛形の完成
- IR/schema/manifestの実装完了
- 同意ビューの全仕様確定
- 実業務 `output/Biz-001-*` の作成

## 受け入れチェック

- `knowledge/docs/meta/README.md` の未整備メタ土台7件が `整備済み` になっている。
- 新規メタdocを読めば、数字工程に入る前の配置・状態・brief・完了条件が分かる。
- `knowledge/docs/README.md` から `knowledge/docs/meta/` と `knowledge/docs/lexicon.md` を辿れる。
- `MEMORY.md` に常時参照が必要な最小情報だけが残り、詳細は各docに分かれている。
- `template/phase-local-missing.md` に残すべきphase-local不足物を、meta台帳へ混ぜていない。
- `git diff --check` が通る。
- ハロワゲートを実行し、`Hello,world.md`、commit、push、post-checkが通る。

## v0後の次候補

メタ土台v0が揃った後に進める候補は、次のいずれかである。

| 候補 | 目的 |
|---|---|
| phase-local README v0 | `template/<数字phase>/` 側の作業雛形を揃える |
| IR/schema v0 | 同意ビューJSONと実行IRの関係を固定する |
| evaluation v0 | fresh executor / shadow run / evalの最初の検証観点を作る |
| casebook v0 | 良い判断/悪い判断の比較例を作る |

## 更新ルール

この完了条件を変える場合は、`knowledge/docs/meta/README.md` の台帳、`MEMORY.md` の次候補、`knowledge/docs/README.md` のread routingを確認する。