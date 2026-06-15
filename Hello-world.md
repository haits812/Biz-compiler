# Hello, world

> Biz-compiler が自分の現在地を嘘なく返すための最小自己記述。
>
> Compass は heading。Hello World は position。
> 位置と方位が揃って、はじめて航行できる。

## Invariant

**Hello World は嘘をつかない。**

ここは read の入口であり、decide / act の入口ではない。判断は COMPASS.md、実行は phase command / template / output 側の責務。

このファイルが古い可能性があるなら、内容を信じる前に現在のディレクトリ・pending・template構成を確認し、同じターンで更新する。

## Last Verified

- Verified at: 2026-06-15 JST
- Verified by: hello-world-gate.ps1
- Scope: Biz-compiler repo self-description only
- Excludes: 実際にコンパイルしている個別業務の状態

## Gate Command

このファイルは knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1 で同期・検査・commit/pushまで一気通貫する。

~~~powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
~~~

## What This Repo Is

Biz-compiler は、業務をそのままAIへ丸投げする道具ではない。

業務をphaseごとに読み、IPO / gate / scope / executor / artifact / evidence へ分け、AI・automation・human・approvalへ再配置し、運用しながら検証・再コンパイルするための業務設計OSである。

## Read First

1. AGENTS.md - 作業規約と読み込み順
2. Hello-world.md - 現在地。このファイル
3. SOUL.md - agentの対話姿勢
4. USER.md - ユーザーの作業モデル
5. COMPASS.md - direction packet / heading
6. knowledge/docs/lexicon.md - 用語定義と概念境界
7. MEMORY.md - 常時参照メモリ

要求定義は、要求全体の確認・要求変更・要求定義との照合が必要な時だけ knowledge/docs/requirements/ から追加で読む。

## Current Root

~~~text
D:\local\Biz-compiler
├─ template/  業務フォルダの原型
├─ output/  業務ごとの成果物置き場。実業務作成まで空
├─ knowledge/  確定知識・pending・journal・管理ops
├─ README.md  GitHub入口。正本はHello World
├─ .gitignore  生成物除外
├─ AGENTS.md  作業規約と読み込み順
├─ Hello-world.md  現在地。このファイル
├─ COMPASS.md  direction packet / heading
├─ MEMORY.md  常時参照メモリ
├─ SOUL.md  agentの対話姿勢
├─ USER.md  ユーザーの作業モデル
└─ .gitattributes
~~~

## Template

template/ は、業務作成時に output/Biz-001-業務名/ へコピーされる原型である。

Current phase directories:

~~~text
template/
├─ _shared/  業務フォルダへコピーされる横断部品
├─ 00-entry/  入口
├─ 10-source-intake/  ソース取得
├─ 20-decompose-encrs/  分解とENCRS
├─ 30-route-executor/  実行者振り分け
├─ 40-ir-freeze/  IR凍結
├─ 50-consent/  生成と同意
├─ 60-validation/  検証
├─ 70-improvement/  改善
└─ 80-operation/  運用
~~~

Known template assets:
- template/50-consent/pipeline-flowchart/pipeline-flowchart.html
- template/phase-local-missing.md

## Output

output/ は、実業務を作るまで空にする。

業務を作る時だけ、次のように採番して作る。

~~~text
output/
└─ Biz-001-業務名/
   ├─ _shared/
   ├─ 00-entry/
   ├─ 10-source-intake/
   └─ ...
~~~

禁止:

- output/example-business-id/ を作らない
- output/_business-id/ を作らない
- サンプル業務やプレースホルダ業務フォルダを置かない
- 業務フォルダは output/Biz-001-業務名/ の形式で作る

Current state:
- output/ contains no business folders at last verification.

## Knowledge

knowledge/ は、このrepoを作るための知識置き場である。

~~~text
knowledge/
├─ docs/  確定済み要求・決定
├─ pending/  未承認候補
├─ journal/  作業ログ・適用/却下ログ
├─ ops/  repo-local skills / hooks / orchestrators / registry
└─ .index/  生成SQLite検索index。正本ではない
~~~

Known knowledge ops assets:
- knowledge/ops/hooks/claude-code-pre-work.ps1
- knowledge/ops/hooks/codex-pre-work.ps1
- knowledge/ops/hooks/pre-publish.ps1
- knowledge/ops/hooks/README.md
- knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1
- knowledge/ops/orchestrators/impact-orchestrator/README.md
- knowledge/ops/orchestrators/knowledge-search/knowledge_search.py
- knowledge/ops/orchestrators/knowledge-search/knowledge-search.ps1
- knowledge/ops/orchestrators/knowledge-search/README.md
- knowledge/ops/README.md
- knowledge/ops/registry.md
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge/ops/skills/hello-world-gate/SKILL.md
- knowledge/ops/skills/knowledge-curation/new-pending-update.ps1
- knowledge/ops/skills/knowledge-curation/pending-review.ps1
- knowledge/ops/skills/knowledge-curation/SKILL.md

## Ops Entrypoints

初期読み込みでは、ここで存在と入口だけを確認する。Skillを作る、hook/orchestrator/command/toolを触る、作業前impact、lock、knowledge searchを扱う時だけ knowledge/ops/registry.md を読む。

- registry: knowledge/ops/registry.md
- hooks: knowledge/ops/hooks/README.md
  - codex-pre-work: knowledge/ops/hooks/codex-pre-work.ps1
  - claude-code-pre-work: knowledge/ops/hooks/claude-code-pre-work.ps1
  - pre-publish: knowledge/ops/hooks/pre-publish.ps1
- orchestrators: knowledge/ops/orchestrators/
  - impact-orchestrator: knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1
  - knowledge-search: knowledge/ops/orchestrators/knowledge-search/knowledge-search.ps1
- knowledge index: knowledge/.index/README.md (SQLite DBは生成物。commitしない)
- work ledger: knowledge/journal/work/
  - active locks: knowledge/journal/work/locks.json

## Natural Language Triggers

ユーザーが過去の会話・作業メモ・決定・ユーザー設定を探している自然文を出したら、コマンド名を待たずに knowledge-search を使う。

代表例:

- 前にこんな会話しなかったっけ？
- 前にもこれ話した？
- あの時どう決めたっけ？
- 似た話、前にしてない？
- その設定どこかに残ってない？
- この話の経緯探して

動き方:

- まずユーザーの言葉をそのまま検索語にする。必要なら2〜3語へ分けて再検索する。
- indexが無い、または古い可能性がある時は knowledge-search.ps1 index を先に実行する。
- 結果は path#Lstart-Lend を根拠として返す。SQLite内の本文を正本にしない。

## Repo-local Skills

初期読み込みでは、既存Skillの発火条件を確認してから新しいSkillを作る。似た役割のSkillがあるなら、まず既存Skillへ統合する。
repo-local Skillを追加・改名・削除したら、SKILL.mdのname/description、knowledge/ops/README.md、Hello Worldの一覧を同じターンで同期する。

- hello-world-gate: Use when Biz-compilerでハロワやっといて/ハロワ見て/ハロワ更新しといて/githubあげといて/GitHub上げて/pushして等の依頼が出た時。
  - path: knowledge/ops/skills/hello-world-gate/
  - commands: knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge-curation: Biz-compiler repo内のMEMORYメモと知識候補を、Markdownルール化、Hello World Gate、将来phase script候補、pending、journal、decisions、廃棄へ振り分けるrepo-local Skill。pending候補の作成・承認・却下・適用もこのSkillで扱う。
  - path: knowledge/ops/skills/knowledge-curation/
  - commands: knowledge/ops/skills/knowledge-curation/new-pending-update.ps1, knowledge/ops/skills/knowledge-curation/pending-review.ps1

Current pending state at last verification:

- pending items: 4
- approved items: 0

確認コマンド:

~~~powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 `
  -Type "運用" `
  -Subject "何を変えたか" `
  -Reason "なぜ必要だったか" `
  -Verified "何を確認したか" `
  -Risks "残っている注意点"
~~~

## What Hello World Must Not Include

このファイルには、実際にコンパイルしている個別業務の進行状態を含めない。

それは output/Biz-001-業務名/ 側の phase ledger / artifact / event log の責務である。

## When To Update

次を変えたら、同じターンでこのファイルを更新する。

- ルート直下の構成
- 読み込み順
- template/ のphase構成
- knowledge/ の構成
- output/ の業務ID生成ルール
- pending / approved の状態をこのファイルで数える場合
- repo-local Skillを追加・改名・削除した場合
- knowledge/ops/registry.md、hooks、orchestrators、repo-local commands/toolsを変更した場合
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1 が失敗した場合

## Smoke Test

AIが何をすればいいか分からない時は、まずここを見る。

Hello World が現在地を返せないなら、次の作業へ進まない。

