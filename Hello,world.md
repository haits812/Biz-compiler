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

- Verified at: 2026-06-14 JST
- Verified by: hello-world-gate.ps1
- Scope: Biz-compiler repo self-description only
- Excludes: 実際にコンパイルしている個別業務の状態

## Gate Command

このファイルは knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1 で同期・検査・publishする。

~~~powershell
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 sync   # 現在地を再生成する
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 check  # stale / 嘘を検出して失敗する
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 gate   # check の別名
.\knowledge\ops\skills\hello-world-gate\hello-world-gate.ps1 publish   # sync/checkして日本語commit/push
~~~

## What This Repo Is

Biz-compiler は、業務をそのままAIへ丸投げする道具ではない。

業務をphaseごとに読み、IPO / gate / scope / executor / artifact / evidence へ分け、AI・automation・human・approvalへ再配置し、運用しながら検証・再コンパイルするための業務設計OSである。

## Read First

1. AGENTS.md - 作業規約と読み込み順
2. Hello,world.md - 現在地。このファイル
3. SOUL.md - agentの対話姿勢
4. USER.md - ユーザーの作業モデル
5. COMPASS.md - direction packet / heading
6. MEMORY.md - 常時参照メモリ
7. knowledge/docs/requirements/Biz-compiler_要求定義.md - 要求定義本体

## Current Root

~~~text
D:\local\Biz-compiler
├─ template/  業務フォルダの原型
├─ output/  業務ごとの成果物置き場。実業務作成まで空
├─ knowledge/  確定知識・pending・journal・管理ops
├─ README.md  GitHub入口。正本はHello World
├─ AGENTS.md  作業規約と読み込み順
├─ Hello,world.md  現在地。このファイル
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
└─ ops/  knowledgeを操作する管理コマンドとrepo-local skills
~~~

Known knowledge ops assets:
- knowledge/ops/README.md
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge/ops/skills/hello-world-gate/SKILL.md
- knowledge/ops/skills/pending-memory/new-pending-memory.ps1
- knowledge/ops/skills/pending-memory/pending-review.ps1
- knowledge/ops/skills/pending-memory/SKILL.md

Current pending state at last verification:

- pending items: 9
- approved items: 0

確認コマンド:

~~~powershell
.\knowledge\ops\skills\pending-memory\pending-review.ps1 list -Stage all
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
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1 check が失敗した場合

## Smoke Test

AIが何をすればいいか分からない時は、まずここを見る。

Hello World が現在地を返せないなら、次の作業へ進まない。

