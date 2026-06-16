# Matt Pocock Skills Mapping for 00-entry

00-entry では、Matt Pocock の `grill-me`、`grill-with-docs`、`to-prd` をそのまま使わず、Biz-compilerの入口phaseへ翻訳して使う。

## grill-me

元の役割: 計画や設計を共有理解に到達するまで徹底的にインタビューする。

00での翻訳:

- 業務全体ではなく、entry decisionを徹底的に聞く。
- 質問は1つずつ出す。
- 各質問に推奨分類を添える。
- repo内資料で分かることは先に確認する。
- 後続phaseの話は深掘りせずrouteする。

## grill-with-docs

元の役割: 既存docs、用語、ADR、コードと照合しながら質問し、用語や判断を整える。

00での翻訳:

| Matt側 | Biz-compiler側 |
|---|---|
| `CONTEXT.md` | `knowledge/docs/lexicon.md` + phase README |
| `docs/adr/` | `knowledge/docs/decisions/` |
| code cross-check | `template/`, `knowledge/`, `code-impact` |

00では、ユーザーの言葉をBiz-compiler語彙へ寄せる。

- 業務、単発作業、成果物作成、運用を混ぜない。
- request、scope、contract、validation、executor、approvalを混ぜない。
- 用語が曖昧なら、00で必要な粗さまでだけ確認する。

## to-prd

元の役割: 既に話した内容をPRDへ整理する。追加インタビューはしない。

00での翻訳:

| to-prd項目 | 00成果物 |
|---|---|
| Problem Statement | `entry-packet.md` のproblem / trigger |
| Solution | 00では解決策にしない。`intent` と `rough_goal` に留める |
| User Stories | actor / requester / user candidate |
| Implementation Decisions | `contract.md` のentry decision |
| Testing Decisions | `checks.md` / `gate-rubric.md` |
| Out of Scope | `scope-memo.md` |

`to-prd` は、grill後に00成果物へ整える段階で使う。

## License Note

外部repoの `SKILL.md` を実装として取り込む場合は、MIT Licenseの著作権表示を残す。00 v0では、思想と工程をBiz-compiler向けに翻訳したメモとして扱う。