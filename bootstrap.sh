#!/usr/bin/env zsh
set -euo pipefail

command -v stow >/dev/null 2>&1 || {
  echo "error: missing required command: stow" >&2
  exit 1
}

ROOT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$ROOT_DIR"

stow --target="$HOME" --restow zsh ghostty zed git
