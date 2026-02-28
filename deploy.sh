#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STOW_PACKAGE="claude"

cd "$SCRIPT_DIR"

# stow がインストールされているか確認
if ! command -v stow &>/dev/null; then
  echo "Error: stow がインストールされていません。"
  echo "  Ubuntu/Debian: sudo apt install stow"
  echo "  macOS: brew install stow"
  exit 1
fi

# デプロイ（冪等: 既存のシンボリックリンクがあっても安全に再実行可能）
stow -v -t "$HOME" --restow "$STOW_PACKAGE"

echo "デプロイ完了: ~/.claude/skills/ にシンボリックリンクを作成しました。"
