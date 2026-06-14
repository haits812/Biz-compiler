# SOUL.md / USER.md をrepo-local初期文脈として採用する

- Status: Accepted
- Date: 2026-06-14

## Context

長い会話やコンテキスト圧縮をまたいでも、Biz-compilerの作業姿勢とユーザーの作業モデルを落とさないため、Hermes系の `SOUL.md` / `USER.md` の分離をrepo-localに取り込む案を検討した。

この導入は、Biz-compiler本体の業務メモリや将来のランタイム機能ではなく、このリポジトリで開発を進めるための運用上の初期文脈である。

## Decision

ルートに `SOUL.md` と `USER.md` を追加し、`AGENTS.md` の読み込み順に明記する。

読み込み順は次とする。

1. `AGENTS.md`
2. `SOUL.md`
3. `USER.md`
4. `COMPASS.md`
5. `MEMORY.md`
6. `knowledge/docs/requirements/Biz-compiler_要求定義.md`
7. 必要なサンプル/Decision

`SOUL.md` は、汎用的な「優秀なビジネスコンサル」ではなく、Biz-compilerを一緒に作る聞き取り型の共同設計者としての姿勢を置く。

`USER.md` は、主に話しかけてくる相手の作業モデルを置く。個人プロフィールの保存場所ではない。

`map.md` は導入しない。ただし、将来作る場合は全体像・配置・読み方の地図であり、`MEMORY.md` とは別物として扱う。

## Consequences

- 後続agentは、Compassや要求定義の前に対話姿勢とユーザーモデルを読む。
- `MEMORY.md` は常時参照メモリに留め、`SOUL.md` / `USER.md` / 将来の `map.md` と役割を混同しない。
- ユーザーが出したファイル名や概念を、確認なしに別のファイルへ吸収しないことを作業制約として扱う。

