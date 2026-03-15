#!/usr/bin/env zsh
set -euo pipefail

command -v stow >/dev/null 2>&1 || {
  echo "error: missing required command: stow" >&2
  exit 1
}

ROOT_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"
cd "$ROOT_DIR"

prompt_yn() {
  local prompt="$1"
  local default_yes="${2:-0}"
  local reply=""

  while true; do
    if [ "$default_yes" = "1" ]; then
      printf "%s [Y/n] " "$prompt"
    else
      printf "%s [y/N] " "$prompt"
    fi

    IFS= read -r reply || return 1
    reply="${reply:l}"

    if [ -z "$reply" ]; then
      [ "$default_yes" = "1" ] && return 0 || return 1
    fi

    case "$reply" in
      y|yes) return 0 ;;
      n|no) return 1 ;;
      *) echo "Please answer y or n." ;;
    esac
  done
}

configure_git_identity() {
  command -v git >/dev/null 2>&1 || {
    echo "warn: git not found; skipping git identity config" >&2
    return 0
  }

  echo "Git config: setting user.name and user.email (git package not bootstrapped)"

  local current_name=""
  local current_email=""
  local name=""
  local email=""

  current_name="$(git config --global --get user.name 2>/dev/null || true)"
  current_email="$(git config --global --get user.email 2>/dev/null || true)"

  while [ -z "$name" ]; do
    if [ -n "$current_name" ]; then
      printf "Git user.name [%s]: " "$current_name"
    else
      printf "Git user.name: "
    fi

    IFS= read -r name || return 1
    [ -z "$name" ] && name="$current_name"
  done

  while [ -z "$email" ]; do
    if [ -n "$current_email" ]; then
      printf "Git user.email [%s]: " "$current_email"
    else
      printf "Git user.email: "
    fi

    IFS= read -r email || return 1
    [ -z "$email" ] && email="$current_email"
  done

  git config --global user.name "$name"
  git config --global user.email "$email"
}

packages=(zsh ghostty zed git zellij)
selected_packages=()

for pkg in "${packages[@]}"; do
  [ -d "$pkg" ] || continue

  if prompt_yn "Bootstrap $pkg?" 1; then
    selected_packages+=("$pkg")
  fi
done

if [[ " ${selected_packages[*]} " != *" git "* ]]; then
  configure_git_identity
fi

if [ "${#selected_packages[@]}" -gt 0 ]; then
  stow --target="$HOME" --restow "${selected_packages[@]}"
else
  echo "No packages selected; skipping stow."
fi
