# zsh config entrypoint

# Load Oh My Zsh setup.
[ -f "$HOME/.config/zsh/oh-my-zsh.sh" ] && source "$HOME/.config/zsh/oh-my-zsh.sh"

# Load user functions.
[ -f "$HOME/.config/zsh/function.sh" ] && source "$HOME/.config/zsh/function.sh"

# Load aliases last so they can override plugin aliases.
[ -f "$HOME/.config/zsh/alias.sh" ] && source "$HOME/.config/zsh/alias.sh"
