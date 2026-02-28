# Oh My Zsh bootstrap.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="corn"

plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh only when it is installed.
[ -r "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
