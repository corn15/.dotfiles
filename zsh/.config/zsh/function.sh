# Functions.

case "$(uname -s)" in
  Darwin)
    [ -f "$HOME/.config/zsh/darwin/function.sh" ] && source "$HOME/.config/zsh/darwin/function.sh"
    ;;
  Linux)
    [ -f "$HOME/.config/zsh/linux/function.sh" ] && source "$HOME/.config/zsh/linux/function.sh"
    ;;
esac
