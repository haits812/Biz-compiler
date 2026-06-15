# 2026-06-15: AI業務委託メタファーを会話補助として採用する

## Status
Accepted

## Context

Biz-compilerは、業務をそのままAIへ丸投げする道具ではなく、業務を契約、gate、executor、ledger、validationへ分解して安全に再配置する仕組みである。

この説明は正確だが、会話中に直感的に扱うには少し硬い。ユーザーとの会話では、Hello World、Compass、Skill Gate、executor routing、contract、validation、operation ledgerなどの概念が増えており、比喩がある方が会話の足場を作りやすい。

一方で、`COMPASS.md` は思考の指向性を渡すheadingであり、比喩を入れると役割が濁る。`knowledge/docs/lexicon.md` も正本語彙の置き場であり、比喩に引っ張らせない方がよい。

## Decision

Biz-compilerの会話補助メタファーとして、次を採用する。

- 正面の説明: AI業務委託の契約・検収・稼働管理
- 雑な比喩: AIの人材派遣会社

最初のヒアリングは契約書作成そのものではなく、契約可能な状態にするための聞き取りとして扱う。そこで、委託範囲、非委託範囲、成果物、入力、判断者、停止条件、scope外、検収条件、事故時の復旧責任、full-auto可否、HITL要否、再委託、外部接続、他部署影響を洗う。

配置は次の通りにする。

- `README.md`: 人間向けに、AI業務委託の契約・検収・稼働管理として少し濃く説明する。
- `AGENTS.md`: agent向けに、正本語彙ではない会話補助として対応表を置く。
- `COMPASS.md`: 入れない。Compassはheadingとして小さく保つ。
- `knowledge/docs/lexicon.md`: 入れない。正本語彙が比喩に引っ張られないようにする。

## Consequences

- 人間との会話では、ハロワ、職業訓練、斡旋、客先投入、契約型、稼働報告、検収という言い方で短く説明できる。
- agentは比喩を使っても、判断時には `contract`、`manifest`、`gate`、`executor`、`ledger`、`validation` の正本語彙へ戻せる。
- `MEMORY.md` に残っていた未整理メモは正式反映済みとして削る。
- 比喩が便利でも、個別phaseやIR仕様を比喩で曖昧にしない必要がある。