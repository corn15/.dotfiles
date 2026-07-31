#!/usr/bin/env zsh
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
source "$ROOT_DIR/lib/common.sh"

command -v stow >/dev/null 2>&1 || error "missing required command: stow"

cd "$ROOT_DIR"

prompt_value() {
  local prompt="$1"
  local default_value="$2"
  local value=""

  while true; do
    if [ -n "$default_value" ]; then
      printf "%s [%s]: " "$prompt" "$default_value"
    else
      printf "%s: " "$prompt"
    fi

    IFS= read -r value || return 1
    [ -z "$value" ] && value="$default_value"

    if [ -n "$value" ]; then
      printf '%s\n' "$value"
      return 0
    fi
  done
}

configure_git_identity() {
  command -v git >/dev/null 2>&1 || {
    echo "warn: git not found; skipping git identity config" >&2
    return 0
  }

  local git_config_file="$ROOT_DIR/git/.gitconfig.local"
  local git_config_example="$ROOT_DIR/git/.gitconfig.local.example"
  local current_name=""
  local current_email=""
  local name=""
  local email=""

  if [ ! -f "$git_config_file" ]; then
    cp "$git_config_example" "$git_config_file"
  fi

  current_name="$(git config --file "$git_config_file" --get user.name 2>/dev/null || true)"
  current_email="$(git config --file "$git_config_file" --get user.email 2>/dev/null || true)"

  echo "Git identity in git/.gitconfig.local:"
  echo "  user.name: ${current_name:-<unset>}"
  echo "  user.email: ${current_email:-<unset>}"

  if ! prompt_yn "Update git identity?" 0; then
    return 0
  fi

  name="$(prompt_value "Git user.name" "$current_name")"
  email="$(prompt_value "Git user.email" "$current_email")"

  git config --file "$git_config_file" user.name "$name"
  git config --file "$git_config_file" user.email "$email"
}

remove_identical_existing_target() {
  local source_path="$1"
  local target_path="$2"

  [ -e "$source_path" ] || return 0
  [ -e "$target_path" ] || return 0
  [ -L "$target_path" ] && return 0

  if diff -qr "$source_path" "$target_path" >/dev/null 2>&1; then
    rm -rf "$target_path"
    return 0
  fi

  error "$target_path already exists and differs from $source_path; move it aside before bootstrapping"
}

prepare_stow_targets() {
  remove_identical_existing_target "$ROOT_DIR/nvim/.config/nvim" "$HOME/.config/nvim"
}

packages=(zsh ghostty zed git zellij nvim)

for pkg in "${packages[@]}"; do
  [ -d "$pkg" ] || error "missing stow package: $pkg"
done

configure_git_identity
prepare_stow_targets

stow --target="$HOME" --restow "${packages[@]}"
