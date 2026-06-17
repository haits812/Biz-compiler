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

- Verified at: 2026-06-17 JST
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

## Setup

clone直後や環境を作り直した時は setup.md を読む。

setup.md は、必要ツール、hook接続、生成物、knowledge-search index、確認コマンドの入口である。hook一覧は複製せず、knowledge/ops/registry.md と knowledge/ops/hooks/README.md を正本にする。

## Current Root

この構成図では、clone先に依存しないようrepo rootを `<repo-root>/` と表記する。実パスを確認する時は `git rev-parse --show-toplevel` を使う。

~~~text
<repo-root>/
├─ template/  業務フォルダの原型
├─ output/  業務ごとの成果物置き場。実業務作成まで空
├─ knowledge/  確定知識・pending・journal・管理ops
├─ README.md  GitHub入口。正本はHello World
├─ setup.md  clone後の初期セットアップ入口
├─ .gitattributes  Git改行・text正規化ルール
├─ .editorconfig  エディタ向け改行・文字コードルール
├─ .gitignore  生成物除外
├─ AGENTS.md  作業規約と読み込み順
├─ Hello-world.md  現在地。このファイル
├─ COMPASS.md  direction packet / heading
├─ MEMORY.md  常時参照メモリ
├─ SOUL.md  agentの対話姿勢
└─ USER.md  ユーザーの作業モデル
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
- template/_shared/evaluation/fixtures/upfront-existing-materials/p31-onboarding-flow.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p32-invoice-payment-procedure.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-notes.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p33-sales-pipeline-register.csv
- template/_shared/evaluation/fixtures/upfront-existing-materials/p34-cs-refund-complaint-manual.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p35-order-processing-flow-proxy.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p36-manager-misreads-team-flow.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p37-overconfident-newcomer-misreads-procurement-flow.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/p38-incoherent-request-with-expense-flow.md
- template/_shared/evaluation/fixtures/upfront-existing-materials/README.md
- template/_shared/evaluation/persona-test-matrix.md
- template/_shared/evaluation/personas/01-invoice-processing-ap/persona.md
- template/_shared/evaluation/personas/02-vendor-onboarding/persona.md
- template/_shared/evaluation/personas/03-low-articulation-sales/persona.md
- template/_shared/evaluation/personas/04-one-off-apology/persona.md
- template/_shared/evaluation/personas/05-suspicious-vendor-bank-info/persona.md
- template/_shared/evaluation/personas/06-incoherent-ai-secretary/persona.md
- template/_shared/evaluation/personas/07-ap-invoice-reconciliation/persona.md
- template/_shared/evaluation/personas/08-recruiting-coordinator/persona.md
- template/_shared/evaluation/personas/09-nda-status-management/persona.md
- template/_shared/evaluation/personas/10-buyer-quote-comparison/persona.md
- template/_shared/evaluation/personas/11-office-asset-return/persona.md
- template/_shared/evaluation/personas/12-sales-weekly-progress/persona.md
- template/_shared/evaluation/personas/13-cs-refund-escalation/persona.md
- template/_shared/evaluation/personas/14-marketing-ad-report/persona.md
- template/_shared/evaluation/personas/15-product-release-notes/persona.md
- template/_shared/evaluation/personas/16-sales-ops-crm-cleanup/persona.md
- template/_shared/evaluation/personas/17-it-helpdesk-account-lifecycle/persona.md
- template/_shared/evaluation/personas/18-logistics-shipping-delay/persona.md
- template/_shared/evaluation/personas/19-qa-defect-triage/persona.md
- template/_shared/evaluation/personas/20-audit-evidence-collection/persona.md
- template/_shared/evaluation/personas/21-expense-approval-visibility/persona.md
- template/_shared/evaluation/personas/22-unaware-sales-admin-lead/persona.md
- template/_shared/evaluation/personas/23-narrow-ap-clerk/persona.md
- template/_shared/evaluation/personas/24-qa-tacit-veteran/persona.md
- template/_shared/evaluation/personas/25-cs-local-optimization-manager/persona.md
- template/_shared/evaluation/personas/26-it-workflow-believer/persona.md
- template/_shared/evaluation/personas/27-procurement-fake-veteran-newcomer/persona.md
- template/_shared/evaluation/personas/28-executive-without-observation/persona.md
- template/_shared/evaluation/personas/29-benign-privacy-blindness/persona.md
- template/_shared/evaluation/personas/30-proxy-hearsay-request/persona.md
- template/_shared/evaluation/personas/31-onboarding-flow-carrier/persona.md
- template/_shared/evaluation/personas/32-ap-payment-procedure-carrier/persona.md
- template/_shared/evaluation/personas/33-sales-pipeline-excel-believer/persona.md
- template/_shared/evaluation/personas/34-stale-cs-refund-manual/persona.md
- template/_shared/evaluation/personas/35-proxy-order-processing-flow/persona.md
- template/_shared/evaluation/personas/36-manager-misreads-team-flow/persona.md
- template/_shared/evaluation/personas/37-overconfident-procurement-newcomer/persona.md
- template/_shared/evaluation/personas/38-incoherent-expense-flow/persona.md
- template/_shared/evaluation/personas/README.md
- template/_shared/evaluation/README.md
- template/00-entry/_context/anomaly-rules.md
- template/00-entry/_context/dispatch-checks.md
- template/00-entry/_context/dispatch-packet.md
- template/00-entry/_context/gate-rubric.md
- template/00-entry/_context/grill-rules.md
- template/00-entry/_context/matt-pocock-skills.md
- template/00-entry/_context/phase-boundary.md
- template/00-entry/_context/README.md
- template/00-entry/_context/sorting-rules.md
- template/00-entry/artifacts/entry-packet.md
- template/00-entry/artifacts/initial-risk-memo.md
- template/00-entry/artifacts/later-phase-notes.md
- template/00-entry/artifacts/scope-memo.md
- template/00-entry/artifacts/source-candidates.md
- template/00-entry/checks.md
- template/00-entry/contract.md
- template/00-entry/handoff.md
- template/00-entry/questions.md
- template/00-entry/README.md
- template/10-source-intake/artifacts/fact-register.md
- template/10-source-intake/artifacts/intake-log.md
- template/10-source-intake/artifacts/source-inventory.md
- template/10-source-intake/checks.md
- template/10-source-intake/contract.md
- template/10-source-intake/handoff.md
- template/10-source-intake/questions.md
- template/10-source-intake/README.md
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
└─ .index/  生成SQLite index（knowledge-search / code-impact）。正本ではない
~~~

Known knowledge ops assets:
- knowledge/ops/hooks/claude-code-pre-work.ps1
- knowledge/ops/hooks/codex-pre-work.ps1
- knowledge/ops/hooks/pre-publish.ps1
- knowledge/ops/hooks/README.md
- knowledge/ops/orchestrators/code-impact/code_impact.py
- knowledge/ops/orchestrators/code-impact/code-impact.ps1
- knowledge/ops/orchestrators/code-impact/README.md
- knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1
- knowledge/ops/orchestrators/impact-orchestrator/README.md
- knowledge/ops/orchestrators/knowledge-search/knowledge_search.py
- knowledge/ops/orchestrators/knowledge-search/knowledge-search.ps1
- knowledge/ops/orchestrators/knowledge-search/README.md
- knowledge/ops/README.md
- knowledge/ops/registry.md
- knowledge/ops/skills/empirical-prompt-tuning/SKILL-ja.md
- knowledge/ops/skills/empirical-prompt-tuning/SKILL.md
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge/ops/skills/hello-world-gate/SKILL.md
- knowledge/ops/skills/knowledge-curation/new-pending-update.ps1
- knowledge/ops/skills/knowledge-curation/pending-review.ps1
- knowledge/ops/skills/knowledge-curation/SKILL.md
- knowledge/ops/skills/paper-write/SKILL.md
- knowledge/ops/skills/review-agent-essence/reference/agent-essence.md
- knowledge/ops/skills/review-agent-essence/SKILL.md
- knowledge/ops/skills/review-harness/diagnosis-report-template.md
- knowledge/ops/skills/review-harness/diagnosis-rubric.md
- knowledge/ops/skills/review-harness/SKILL.md
- knowledge/ops/skills/skill-creator-gate/new-skill-proposal.ps1
- knowledge/ops/skills/skill-creator-gate/SKILL.md
- knowledge/ops/skills/skill-creator-gate/validate-repo-skill.ps1
- knowledge/ops/skills/web-research-to-report/SKILL.md

## Ops Entrypoints

初期読み込みでは、ここで存在と入口だけを確認する。Skillを作る、hook/orchestrator/command/toolを触る、作業前impact、lock、knowledge searchを扱う時は、まず knowledge/ops/registry.md を読み、その後対象ownerの README.md / SKILL.md を読む。

- ops overview: knowledge/ops/README.md
- registry: knowledge/ops/registry.md
- owner docs rule: ops資産を使う/変更する時はregistryの後に対象のREADME.mdまたはSKILL.mdを読む
- skills: knowledge/ops/skills/
  - hello-world-gate docs: knowledge/ops/skills/hello-world-gate/SKILL.md
  - hello-world-gate command: knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
  - knowledge-curation docs: knowledge/ops/skills/knowledge-curation/SKILL.md
  - empirical-prompt-tuning docs: knowledge/ops/skills/empirical-prompt-tuning/SKILL.md
  - paper-write docs: knowledge/ops/skills/paper-write/SKILL.md
  - skill-creator-gate docs: knowledge/ops/skills/skill-creator-gate/SKILL.md
  - skill-creator-gate proposal command: knowledge/ops/skills/skill-creator-gate/new-skill-proposal.ps1
  - skill-creator-gate validation command: knowledge/ops/skills/skill-creator-gate/validate-repo-skill.ps1
  - web-research-to-report docs: knowledge/ops/skills/web-research-to-report/SKILL.md
- hooks: knowledge/ops/hooks/README.md
  - codex-pre-work: knowledge/ops/hooks/codex-pre-work.ps1
  - claude-code-pre-work: knowledge/ops/hooks/claude-code-pre-work.ps1
  - pre-publish: knowledge/ops/hooks/pre-publish.ps1
- orchestrators: knowledge/ops/orchestrators/
  - impact-orchestrator docs: knowledge/ops/orchestrators/impact-orchestrator/README.md
  - impact-orchestrator command: knowledge/ops/orchestrators/impact-orchestrator/impact-orchestrator.ps1
  - code-impact docs: knowledge/ops/orchestrators/code-impact/README.md
  - code-impact command: knowledge/ops/orchestrators/code-impact/code-impact.ps1
  - knowledge-search docs: knowledge/ops/orchestrators/knowledge-search/README.md
  - knowledge-search command: knowledge/ops/orchestrators/knowledge-search/knowledge-search.ps1
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
repo-local Skillを追加・改名・削除したら、SKILL.mdのname/description、owner説明、knowledge/ops/README.md、Hello Worldの一覧を同じターンで同期する。

- empirical-prompt-tuning: Use only when the user explicitly asks for empirical-prompt-tuning、empirical eval、プロンプト実証評価、SkillのIter-0 description/body整合チェック、またはagent向け指示を白紙実行者で評価して反復改善してと言われた時。Do NOT auto-invoke after every skill edit.
  - path: knowledge/ops/skills/empirical-prompt-tuning/
- hello-world-gate: Use when Biz-compilerでハロワやっといて/ハロワ見て/ハロワ更新しといて/githubあげといて/GitHub上げて/pushして等の依頼が出た時。
  - path: knowledge/ops/skills/hello-world-gate/
  - commands: knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1
- knowledge-curation: Use when Biz-compiler repoで知識整理して、メモリ整理して、MEMORY.mdを整理して、格上げ判断して、pending見て、pending作って、journalから拾うものある？、この会話どこに残す？、knowledge curationと言われた時。MEMORYメモと知識候補を正本、pending、journal、decisions、廃棄へ振り分ける。
  - path: knowledge/ops/skills/knowledge-curation/
  - commands: knowledge/ops/skills/knowledge-curation/new-pending-update.ps1, knowledge/ops/skills/knowledge-curation/pending-review.ps1
- paper-write: Use when Biz-compiler repoでpaper-write、論文を書いて、研究論文ドラフト、academic/research paper、LaTeX manuscript、論文骨子、研究稿、引用付き論文、PDF/LaTeX原稿の作成・修復・コンパイルを依頼された時。普通の業務文書、Web調査レポート、ブログ、要約、スライド、意思決定メモには使わない。OpenSquillaのmeta-paper-writeからmeta-とruntimeを外し、論文/研究稿向けのcontract、citation、figure/table placeholder、length/citation gate作法を移植する。
  - path: knowledge/ops/skills/paper-write/
- review-agent-essence: Use only when the user explicitly asks for review-agent-essence、agent-essence原則レビュー、エッセンスレビュー、原則チェック、またはSkill/ハーネス設計をagent-essenceに照らして見てと言われた時。Do NOT auto-invoke for generic review requests.
  - path: knowledge/ops/skills/review-agent-essence/
- review-harness: Use only when the user explicitly asks for review-harness、ハーネス診断、harness診断、ハーネスの健康診断、またはClaude Code/Codex系ハーネス構成を25指標で診断してと言われた時。Do NOT auto-invoke for generic 診断して or review requests.
  - path: knowledge/ops/skills/review-harness/
- skill-creator-gate: Use when Biz-compiler repoで新しいrepo-local Skillを作る、既存Skillを改修する、作業をSkill化する、やりたいことを元にどれをSkill化するか組み立てる、スキル作って/Skill作って/この流れをSkillにして/この仕事をSkill化できるか/creator gate/skill-creator-gate/meta-skill-creator流用と言われた時。やりたいことの聞き取り、Skill候補整理、多工程Skill設計、標準skill-creator作法による実装、repo-local登録、検査まで行う。
  - path: knowledge/ops/skills/skill-creator-gate/
  - commands: knowledge/ops/skills/skill-creator-gate/new-skill-proposal.ps1, knowledge/ops/skills/skill-creator-gate/validate-repo-skill.ps1
- web-research-to-report: Use when Biz-compiler repoでWeb調査を出典付きレポート、ブリーフ、意思決定メモにする、調べて根拠付きでまとめて、出典付きで比較して、最新情報を調査して報告して、市場/技術/選択肢/リスクをsource-backedに整理してと言われた時。単発の事実確認、与えられたメモだけの要約、普通の文章作成には使わない。OpenSquillaのmeta-web-research-to-reportからmeta-とruntimeを外し、普通のrepo-local Skillとして工程作法を移植する。
  - path: knowledge/ops/skills/web-research-to-report/

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
- setup.md の環境前提、hook接続、生成物ルール
- 読み込み順
- template/ のphase構成
- knowledge/ の構成
- output/ の業務ID生成ルール
- pending / approved の状態をこのファイルで数える場合
- repo-local Skillを追加・改名・削除した場合
- knowledge/ops/registry.md、hooks、orchestrators、repo-local commands/toolsを変更した場合
- ops資産のowner説明ファイル、またはその読み導線を変更した場合
- knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1 が失敗した場合

## Smoke Test

AIが何をすればいいか分からない時は、まずここを見る。

Hello World が現在地を返せないなら、次の作業へ進まない。
