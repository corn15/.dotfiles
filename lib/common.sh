# Shared POSIX shell helpers for dotfiles bootstrap scripts.

error() {
  echo "error: $*" >&2
  exit 1
}

prompt_yn() {
  prompt="$1"
  default_yes="${2:-0}"

  while :; do
    if [ "$default_yes" = "1" ]; then
      printf "%s [Y/n] " "$prompt"
    else
      printf "%s [y/N] " "$prompt"
    fi

    IFS= read -r reply || return 1
    reply=$(printf '%s' "$reply" | tr '[:upper:]' '[:lower:]')

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

add_homebrew_to_path() {
  # Homebrew normally adds its path through macOS path_helper via /etc/paths.d/homebrew.
  # For bootstrap, only patch PATH for this script run so we can find newly installed
  # Homebrew tools without mutating user shell startup files.
  if [ -x /opt/homebrew/bin/brew ]; then
    PATH="/opt/homebrew/bin:$PATH"
  elif [ -x /usr/local/bin/brew ]; then
    PATH="/usr/local/bin:$PATH"
  fi

  export PATH
}

validate_profile() {
  case "$1" in
    cli|desktop) ;;
    *) error "--profile must be cli or desktop" ;;
  esac
}
