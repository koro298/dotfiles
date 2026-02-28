# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Claude Code のスキルを dotfiles として管理するリポジトリ。
`stow` でホームディレクトリにデプロイし、どの環境でも同じスキルセットを使えるようにする。

## ディレクトリ構造

```
~/dotfiles/
├── claude/                     ← stow パッケージ（デプロイ対象）
│   └── .claude/
│       └── skills/             ← デプロイされるポータブルスキル群
├── .claude/                    ← このリポジトリ自体の開発設定
│   ├── settings.json           ← 共有設定（Agent Teams 有効化など）
│   ├── settings.local.json     ← ローカル設定（パーミッション）
│   └── skills/                 ← このリポジトリ専用スキル
│       └── skill-creator-dotfiles/
├── CLAUDE.md                   ← このファイル
├── deploy.sh                   ← stow デプロイスクリプト
└── docs/                       ← 仕様書・ドラフト・参考スキルサンプル
```

## 二層のスキル配置

- `claude/.claude/skills/` — **ポータブルスキル（成果物）**。`stow -t ~ claude` で `~/.claude/skills/` にシンボリックリンクされ、全プロジェクトで使える
- `.claude/skills/` — **本リポジトリ専用スキル**。このリポジトリ内でのみ有効

### skill-creator の使い分け

| スキル | 用途 | 作成先 |
|---|---|---|
| `skill-creator`（デプロイ済） | 任意プロジェクトでプロジェクト固有スキルを作る | `.claude/skills/` |
| `skill-creator-dotfiles`（本リポジトリ専用） | ポータブルスキルをこのリポジトリに追加する | `claude/.claude/skills/` |

## デプロイ

```bash
./deploy.sh
# または手動: stow -t ~ claude
```

初回実行でシンボリックリンクが作成される。以降はリポジトリ内の変更が即反映される。

## スキル開発ワークフロー

1. このリポジトリで `claude/.claude/skills/<skill-name>/` 配下にスキルを作成・修正
2. `./deploy.sh` でデプロイ（初回のみ。以降はシンボリックリンク経由で即反映）
3. 実プロジェクトで Claude Code を起動し、スキルが意図通り動作するか検証
4. このリポジトリに戻ってフィードバックを反映

## スキル作成のルール

`claude/.claude/skills/skill-creator/references/skill-standard.md` にスキルの構造・命名・記述ルールが定義されている。新規スキル作成時は必ず参照すること。

ポータブルスキルの制約:

- **環境非依存**: 特定のプロジェクト構造やツールに依存しない
- **自己完結**: 必要なリソースはスキルディレクトリ内に含める
- **パス参照**: スキル内のファイル参照は相対パスで記述する
