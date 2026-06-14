# MEMORY.md

> このファイルは、Biz-compilerリポジトリで開発を続けるための小さい常時参照メモリである。詳細な議論、長い背景、作業ログはここに入れず、該当する `knowledge/docs/`、`knowledge/journal/`、`knowledge/pending/` へ逃がす。

## 現在の構成

- `AGENTS.md`: このリポジトリで作業するagent向けの作業規約と読み込み順。
- `Hello,world.md`: Biz-compilerの現在地を返す最小自己記述。構成変更時は同じターンで更新する。
- `SOUL.md`: このリポジトリで作業するagentの対話姿勢。
- `USER.md`: このリポジトリで主に話しかけてくる相手の作業モデル。
- `COMPASS.md`: 作業者やsubagentへ思考の指向性を渡す direction packet。テンプレートや個別例より先に読む。
- `MEMORY.md`: このリポジトリを作るための開発運用メモリ。
- `knowledge/docs/requirements/Biz-compiler_要求定義.md`: 現時点の要求定義本体。
- `knowledge/docs/README.md`: Compassから逃がした詳細知識をいつ読むかのread routing。
- `knowledge/docs/decisions/`: 設計・運用上の決定記録。
- `knowledge/docs/lexicon/`: 用語定義と概念境界。
- `knowledge/docs/ir/`: IR、contract、schema、manifestの概念設計。
- `knowledge/docs/method/`: phase設計、ENCRS、検証ループなどの方法論。
- `knowledge/docs/casebook/`: 判断例、反例、良い/悪い設計の比較。
- `knowledge/docs/evaluation/`: fresh executor、shadow run、eval、受け入れ条件。
- `knowledge/pending/`: AIまたは作業者が提案した、未承認のMemory/Compass/Decision更新。
- `knowledge/pending/approved/`: 人間が正式反映を認めたが、まだ対象ファイルへ反映済みとは限らない候補。
- `knowledge/journal/`: 作業セッションのログ、検討過程、未整理メモ、pendingの適用/却下ログ。
- `knowledge/ops/`: 開発運用メモリを操作するrepo-local Skill置き場。`.ps1` は直下に置かず、各 `skills/<skill-name>/` に `SKILL.md` と同居させる。
- `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1`: ハロワ更新、検査、必要なら日本語commit、GitHub push、post-checkまで一気通貫で行う唯一のハロワゲートコマンド。
- `knowledge/ops/skills/`: Biz-compilerリポジトリ内だけで効くrepo-local運用Skill。グローバルSkill置き場ではない。
- `knowledge/ops/skills/hello-world-gate/SKILL.md`: ハロワゲートをいつ発火するかを定義するrepo-local Skill。外向けコマンドは1つだけ。
- `knowledge/ops/skills/pending-memory/SKILL.md`: 未承認Memory/Compass/Decision候補の作成、確認、承認、却下、適用済み処理を定義するrepo-local Skill。
- `knowledge/ops/skills/pending-memory/new-pending-memory.ps1`: 即時メモ候補を `knowledge/pending/memory/` に作る。
- `knowledge/ops/skills/pending-memory/pending-review.ps1`: pending候補を `list`、`show`、`approve`、`reject`、`applied` する。
- `template/`: 業務フォルダの原型。数字phaseごとの雛形と、業務フォルダへコピーされる `_shared/` を置く。
- `template/_shared/`: phase横断で業務フォルダ内から使う内部部品、runner、validator、tool、実行スクリプトの置き場。
- `template/50-consent/pipeline-flowchart/pipeline-flowchart.html`: フェーズ50同意ビューのテンプレート資産。
- `output/`: 業務ごとの実行成果物置き場。業務を作るタイミングで `Biz-001-業務名` のように採番したフォルダを作る。プレースホルダ業務フォルダは置かない。
- GitHub repository: private `haits812/Biz-compiler`。ローカルは `main` branchで初期化する。Gitは空ディレクトリを追跡しないため、`output/` 以外の空ディレクトリは `.gitkeep` で保持する。

## 決定済み

- このリポジトリはBiz-compilerを実装していく作業場として扱う。
- 読み込み順は `AGENTS.md` → `Hello,world.md` → `SOUL.md` → `USER.md` → `COMPASS.md` → `MEMORY.md` → 要求定義 → 必要なテンプレート/Decision とする。
- `SOUL.md` は、汎用コンサルではなく、Biz-compilerを一緒に作る聞き取り型の共同設計者としての姿勢を置く。
- `USER.md` は、主に話しかけてくる相手の作業モデルを置く。個人プロフィールではない。
- Compassはルートの `COMPASS.md` に置き、作業者やsubagentに思考の指向性を渡すdirection packetとして扱う。
- Compassは短く保つ。用語、IR詳細、方法論、事例、評価条件、決定理由は `knowledge/docs/README.md` のread routingに従って分ける。
- 要求定義は `knowledge/docs/requirements/` に置く。
- 決定記録、未承認候補、作業ログは `knowledge/` 配下でグループ化し、`docs` / `pending` / `journal` の役割は混ぜない。
- フェーズ50のフローチャートHTMLは `template/50-consent/pipeline-flowchart/` に置く。`samples/` には置かない。
- 実行時に業務フォルダへコピーされる横断部品は `template/_shared/` に置く。
- 開発運用上の記憶はBiz-compiler本体の業務メモリとは分ける。
- 開発運用メモリは会話終盤レビューに依存しない。重要点が出たら即時に `knowledge/pending/`、`MEMORY.md`、`knowledge/docs/decisions/`、または `knowledge/journal/` へ反映する。
- `knowledge/ops/skills/pending-memory/pending-review.ps1` でpending候補を `list`、`show`、`approve`、`reject`、`applied` できる。
- `approved` は正式反映済みではなく、正式ファイルへ文脈込みで反映してから `applied` とする。
- このリポジトリには個別業務ごとのSkillを溜め込まない。個別Skill、workflow、adapterはBiz-compilerが作る成果物リポジトリ側の資産として扱う。
- Curator/棚卸しはcompiler repoとoutput repoで分ける。このrepoでは設計資産とpending、出力先では生成された業務資産を対象にする。
- Biz-compilerのnarrow waistは、core tool数ではなく、10番台以降のphase contractとIR境界で作る。
- `map.md` は、将来導入するなら全体像・配置・読み方の地図であり、`MEMORY.md` とは別物として扱う。
- 会話フェーズナビゲーション表のカラムは `#` / `フェーズ` / `この工程の役割` / `今回の扱い` / `完了` に固定する。列の追加・削除・並べ替え・ラベル変更をしない。完了マーク `✔` は右端の `完了` カラムで揃える。モード差分は `今回の扱い` の値で表す。
- `60` は初回構築時の検証、`70/80` は運用後の改善で作り直した成果物の再検証として扱う。検証対象はログそのものではなく改善後成果物。
- ディレクトリ構成は、人間が数字phaseで追える `template/<数字phase>` と、業務作成時に採番される `output/Biz-001-業務名/<数字phase>` を基本形にする。`output/` 直下に見本の業務フォルダは置かない。
- `Hello,world.md` は read の入口であり、decide / act の入口ではない。実際にコンパイルしている個別業務の状態は含めない。
- `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` で `Hello,world.md` の更新、検査、必要ならcommit/pushまで行う。gateが失敗したら次の作業へ進まない。
- ハロワゲートは `knowledge/ops/skills/hello-world-gate/SKILL.md` としてrepo-local Skill化済み。グローバルSkillにはしない。commit/pushも同じハロワゲートに含め、外向けコマンドは1つだけにする。
- `ハロワやっといて`、`ハロワ見て`、`ハロワ確認して`、`ハロワ更新しといて` は `hello-world-gate` を発火する。`githubあげといて`、`GitHub上げて`、`pushして`、`pushしといて` は `hello-world-gate.ps1` を発火する。GitHubへ上げる依頼はハロワ更新込みで、更新・検査・commit・push・post-checkを一気通貫で行う。

## 常に守る制約

- `apply_patch` は使わない。Windows絶対パスでハングする既知リスクがある。
- Codex Desktop向けの未文書化 `::git-*` directive は出さない。
- commit/push結果はCodex Desktop directiveではなく通常の文章で報告する。commit messageは日本語で書き、作業の意味・検証・残リスクを残す。
- Biz-compiler側に `commit-push-gate` Skillを作らない。commit/push込みの公開処理も `hello-world-gate.ps1` が担当する。
- UIやサンプルより先に、契約データ、IR、安全制約、運用ループへの接続を確認する。
- `MEMORY.md` は小さく保つ。詳細化した内容は `knowledge/docs/decisions/` または `knowledge/journal/` に移す。
- 迷う記憶更新は正式ファイルに直書きせず、まず `knowledge/pending/` に置く。
- ユーザーが出した言葉、ファイル名、概念の区別を勝手に潰さない。推測で置き換えた場合は誤りとして直す。
- `output/` 直下にサンプル業務、`example-business-id`、`_business-id` などのプレースホルダ業務フォルダを作らない。業務IDフォルダは実業務作成時に `Biz-001-業務名` のように採番して作る。
- リポジトリ直下に `docs/`、`pending/`、`journal/`、`samples/`、`internal/`、`scripts/`、`schemas/`、`runner/`、`tools/`、`validators/`、`phase-packs/` を増やさない。
- 実行時に業務フォルダへコピーされるものは `template/` 配下に置く。知識管理だけに使うものは `knowledge/` 配下に置く。
- ルート構成、読み込み順、`template/`、`knowledge/`、`output/` の業務ID生成ルールを変えたら、同じターンで `knowledge/ops/skills/hello-world-gate/hello-world-gate.ps1` を実行する。

## 次に整える候補

- `knowledge/docs/lexicon/` v0: `provenance`、`confidence`、`gate`、`irreversible`、`N-interface` などの語彙定義。
- `knowledge/docs/casebook/` v0: 良い判断/悪い判断の対比事例。
- `knowledge/docs/evaluation/` v0: Compassあり/なしで業務設計出力差を見るシナリオ。
- `knowledge/docs/ir/` v0: 同意ビューJSONと実行IRの関係を固定する最小スキーマ。
- `COMPASS.md` はv1 direction packetへ掃除済み。方法論は `knowledge/docs/method/empirical-business-design-loop.md`、IR要求は `knowledge/docs/ir/minimum-ir-attributes.md` へ退避済み。
- `map.md`: ファイルが増えてきたら、全体像・読み方・配置を把握するための地図として検討する。`MEMORY.md` とは役割を分ける。
- Output repo template v0: `template/` をコピーして `output/Biz-001-業務名/` を作る初期化規約。
- 開発運用メモリの自動/半自動レビュー: 会話長期化やコンテキスト圧縮に依存しないチェックポイント機構。















