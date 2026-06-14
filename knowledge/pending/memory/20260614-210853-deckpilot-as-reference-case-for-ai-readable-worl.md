# DeckPilot as reference case for AI-readable world model

## Target
MEMORY.md / future self-description index / operational state design

## Proposed Change
Biz-compiler の Ontology / World Model 検討時に、DeckPilot を「AI-readable operating world model」の参照ケースとして扱う。ただしそのまま移植せず、DeckPilot は一人開発OS向けの自己記述モデル、Biz-compiler は業務設計OS向けの業務概念モデルとして境界を分ける。

DeckPilot で近いことをしている層:

- `CLAUDE.md`: repo の運用ルール、技術契約、検証義務、正本分担。AI が作業世界で守る法・手順。
- `SOUL.md`: RIO の役割、境界、距離感。AI の actor model / interaction model。
- `USER.md`: Pilot の好み、地雷、判断傾向。人間側 actor のコスト関数。
- `RIO-MEMORY.md`: 昇格待ちの動的学び。恒久正本ではない temporary learning queue。
- `docs/architecture.md`: full map / startup-visible discoverability artifact。ドメイン一覧、Skill、docs構造、Knowledge検索表、ハーネス階層を一面で見せる構造地図。
- `docs/dev-rules/`、Skill、Hook、verifier: 世界モデルを実行時に enforce する契約・ガードレール。

Biz-compiler側に翻訳するなら、`Compass` は価値順位・判断prior、自己記述インデックスはAIが初手で参照する配置・導線・読む順番・現在の運用状態の地図として分ける。`ONTOLOGY.md` や `map.md` というファイル名は必須ではない。

## Evidence
ユーザー発話: Biz-compilerが業務設計OSなら、AIが参照すべき業務の地図・世界モデルが必要ではないか。DeckPilotでは、AGENTS.mdに書かれた最初に読むファイル群が、AIに雑に指示してアプリ修正できるためのオンボーディング資料として作られ、結果的に近いことをやっているのではないか。

確認したDeckPilotファイル: `AGENTS.md`、`CLAUDE.md`、`SOUL.md`、`USER.md`、`RIO-MEMORY.md`、`docs/architecture.md`。

特に `CLAUDE.md` は `docs/architecture.md` を「full map / startup-visible discoverability artifact」として扱い、コード読解前の確認を必須化している。`docs/architecture.md` はレイヤー構造、ドメイン一覧、Skill一覧、docs構造、Knowledge検索アーキテクチャ、ハーネス階層を同一面に載せている。

## Risk
DeckPilot の自己流構造をそのまま Biz-compiler へ持ち込むと、ペルソナ・開発運用・業務IRが混線する。参照すべきはファイル名や人格設計ではなく、正本分担、読順、地図、Hook/Skill/Knowledge の役割分担。

Biz-compilerでは、DeckPilotの航空/RIO世界観を移植しない。必要なのは「AIが業務設計OSの世界を誤読しないための概念地図」であり、個別ペルソナや会話演出ではない。
## Additional Note

ユーザー確認: DeckPilot の `docs/architecture.md` は、単にアーキテクチャを説明するためではなく、DeckPilot 上で動く機能・ドメインが大量に増えていく前提で、AIが毎回全量を読まずに必要な場所へスムーズに到達するために作られた。つまり、トークンを浪費しないための startup-visible index / self-description map でもある。

Biz-compilerへの含意: 必須なのは `ONTOLOGY.md` や `map.md` という個別ファイルではなく、現在のrepo/業務設計OSが自分自身をどう説明し、どのphase・template・contract・decision・pending・knowledgeへどう辿ればよいかを示す `self-description index` を保つこと。実際にコンパイルしている業務そのものは `output/` 側の状態であり、この自己記述インデックスには含めない。

区別:

- Concept split: 何を概念として分けるか。固定ファイル名は未定。\r\n- Self-description index: このシステムのどこに何があり、AIが最初に何を読めばよいか。最新運用状態を保つ。\r\n- Compass: どう判断するか。

## Correction

ユーザー訂正: ONTOLOGY.md や map.md は無くてもよい。ファイル名より更新機構が重要。必要なのは、実際にコンパイルしている業務を含めない範囲で、Biz-compiler自身の最新運用状態をAI向けに保ち続ける設計である。

