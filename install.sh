#!/usr/bin/env zsh
set -euo pipefail

# Install (or update) Starship and standalone Zsh plugins used by this dotfiles setup.

ZSH_PLUGIN_DIR="${ZSH_PLUGIN_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins}"
PLUGINS=(
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

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

starship_bin_dir() {
  if [ -n "${STARSHIP_BIN_DIR:-}" ]; then
    printf '%s\n' "$STARSHIP_BIN_DIR"
    return
  fi

  if command -v starship >/dev/null 2>&1; then
    dirname -- "$(command -v starship)"
    return
  fi

  printf '%s\n' "/usr/local/bin"
}

install_starship() {
  require_cmd curl

  local bin_dir=""
  bin_dir="$(starship_bin_dir)"

  curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$bin_dir"
}

main() {
  require_cmd git
  install_starship

  mkdir -p "$ZSH_PLUGIN_DIR"

  local plugin=""
  for plugin in "${PLUGINS[@]}"; do
    clone_or_update "https://github.com/zsh-users/${plugin}" "$ZSH_PLUGIN_DIR/${plugin}"
  done
}

main "$@"
