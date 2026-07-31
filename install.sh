#!/bin/sh
set -eu

ROOT_DIR=$(CDPATH= cd "$(dirname "$0")" && pwd)
. "$ROOT_DIR/lib/common.sh"

usage() {
  cat <<'USAGE'
Usage: ./install.sh [--profile cli|desktop] [--update]

Install tools required by these dotfiles.

Options:
  --profile cli|desktop  Tool profile to install. Defaults to cli.
  --update               Refresh standalone tools and Zsh plugins.
  -h, --help             Show this help message.
USAGE
}

install_homebrew() {
  command -v curl >/dev/null 2>&1 || error "curl is required to install Homebrew"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  add_homebrew_to_path
}

ensure_ansible_on_macos() {
  add_homebrew_to_path

  if ! command -v brew >/dev/null 2>&1; then
    if prompt_yn "Homebrew is required to install Ansible on macOS. Install Homebrew?" 0; then
      install_homebrew
    else
      error "Homebrew is required to install Ansible on macOS"
    fi
  fi

  if ! command -v ansible-playbook >/dev/null 2>&1; then
    brew install ansible
  fi
}

ensure_ansible_on_ubuntu() {
  if command -v ansible-playbook >/dev/null 2>&1; then
    return 0
  fi

  command -v sudo >/dev/null 2>&1 || error "sudo is required to install Ansible on Ubuntu"
  sudo apt-get update
  sudo apt-get install -y ansible
}

ensure_ansible() {
  os_name=$(uname -s)
  case "$os_name" in
    Darwin)
      ensure_ansible_on_macos
      ;;
    Linux)
      if [ -r /etc/os-release ]; then
        . /etc/os-release
      else
        error "cannot detect Linux distribution"
      fi

      if [ "${ID:-}" = "ubuntu" ]; then
        ensure_ansible_on_ubuntu
      else
        error "only Ubuntu is supported for Linux installs"
      fi
      ;;
    *)
      error "unsupported OS: $os_name"
      ;;
  esac

  command -v ansible-playbook >/dev/null 2>&1 || error "ansible-playbook is still unavailable after installation"
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

PLAYBOOK="$ROOT_DIR/ansible/playbook.yml"

ensure_ansible

if [ "$(uname -s)" = "Linux" ] && ! sudo -n true 2>/dev/null; then
  ansible-playbook -i localhost, --ask-become-pass "$PLAYBOOK" --extra-vars "profile=$profile dotfiles_update=$dotfiles_update"
else
  ansible-playbook -i localhost, "$PLAYBOOK" --extra-vars "profile=$profile dotfiles_update=$dotfiles_update"
fi
