# Oh My Zsh bootstrap.
export ZSH="$HOME/.oh-my-zsh"
# Keep Oh My Zsh for plugins/completions only. Prompt rendering is handled by Starship.
ZSH_THEME=""

plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load Oh My Zsh only when it is installed.
[ -r "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
