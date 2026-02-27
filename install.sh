#!/usr/bin/env zsh
set -euo pipefail

# Install (or update) Oh My Zsh without touching ~/.zshrc or changing the default shell.

ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-$ZSH_DIR/custom}"

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "error: missing required command: $1" >&2
    exit 1
  }
}

clone_or_update() {
  local repo="$1"
  local dest="$2"

  if [ -d "$dest/.git" ]; then
    git -C "$dest" pull --ff-only
    return
  fi

  if [ -e "$dest" ]; then
    echo "error: $dest exists but is not a git repo; please move it aside and re-run" >&2
    exit 1
  fi

  git clone --depth=1 "$repo" "$dest"
}

main() {
  require_cmd git

  if [ -d "$ZSH_DIR/.git" ]; then
    git -C "$ZSH_DIR" pull --ff-only
  elif [ -e "$ZSH_DIR" ]; then
    echo "error: $ZSH_DIR exists but is not a git repo; please move it aside and re-run" >&2
    exit 1
  else
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
  fi

  mkdir -p "$ZSH_CUSTOM_DIR/plugins"
  clone_or_update https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM_DIR/plugins/zsh-completions"
  clone_or_update https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"
  clone_or_update https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"
}

main "$@"
