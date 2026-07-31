#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd "$(dirname "$0")" && pwd)
. "$ROOT_DIR/lib/common.sh"

usage() {
  cat <<'USAGE'
Usage: ./setup.sh [--profile cli|desktop] [--update]

Set up a new machine with tools and dotfile symlinks.

Options:
  --profile cli|desktop  Tool profile to install. Defaults to cli.
  --update               Refresh standalone tools and Zsh plugins.
  -h, --help             Show this help message.
USAGE
}

ensure_shell_is_listed() {
  shell_path="$1"

  if [ -r /etc/shells ] && grep -Fx "$shell_path" /etc/shells >/dev/null 2>&1; then
    return 0
  fi

  echo "Adding $shell_path to /etc/shells requires sudo."
  if printf '%s\n' "$shell_path" | sudo tee -a /etc/shells >/dev/null; then
    return 0
  fi

  echo "warn: could not add $shell_path to /etc/shells" >&2
  echo "Run this manually, then retry chsh:" >&2
  echo "  printf '%s\\n' '$shell_path' | sudo tee -a /etc/shells" >&2
  return 1
}

maybe_make_zsh_default_shell() {
  zsh_path=$(command -v zsh || true)

  if [ -z "$zsh_path" ]; then
    echo "warn: zsh is not available; skipping default shell prompt" >&2
    return 0
  fi

  if [ "${SHELL:-}" = "$zsh_path" ]; then
    return 0
  fi

  if ! prompt_yn "Make zsh your default shell?" 0; then
    return 0
  fi

  if ! ensure_shell_is_listed "$zsh_path"; then
    return 0
  fi

  if chsh -s "$zsh_path"; then
    echo "Default shell changed to $zsh_path. Restart your login session for it to take effect."
    return 0
  fi

  echo "warn: chsh failed" >&2
  echo "Run this manually if you still want zsh as your default shell:" >&2
  echo "  chsh -s $zsh_path" >&2
}

profile="cli"
dotfiles_update="false"

while [ "$#" -gt 0 ]; do
  case "$1" in
    --profile)
      [ "$#" -ge 2 ] || error "--profile requires cli or desktop"
      profile="$2"
      shift 2
      ;;
    --update)
      dotfiles_update="true"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      error "unknown option: $1"
      ;;
  esac
done

validate_profile "$profile"

if [ "$dotfiles_update" = "true" ]; then
  "$ROOT_DIR/install.sh" --profile "$profile" --update
else
  "$ROOT_DIR/install.sh" --profile "$profile"
fi

add_homebrew_to_path
maybe_make_zsh_default_shell

zsh "$ROOT_DIR/bootstrap.sh"
