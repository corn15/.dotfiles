# zsh config entrypoint

# Load environment variables first.
[ -f "$HOME/.config/zsh/environment.sh" ] && source "$HOME/.config/zsh/environment.sh"

# Load user functions.
[ -f "$HOME/.config/zsh/function.sh" ] && source "$HOME/.config/zsh/function.sh"

# Load aliases last so they can override plugin aliases.
[ -f "$HOME/.config/zsh/alias.sh" ] && source "$HOME/.config/zsh/alias.sh"

# Load prompt setup before plugin widgets are finalized.
[ -f "$HOME/.config/zsh/prompt.sh" ] && source "$HOME/.config/zsh/prompt.sh"

# Load plugins after prompt setup so completion is initialized and syntax highlighting can wrap widgets.
[ -f "$HOME/.config/zsh/plugins.sh" ] && source "$HOME/.config/zsh/plugins.sh"

# Load key bindings after plugins so custom bindings win.
[ -f "$HOME/.config/zsh/keybindings.sh" ] && source "$HOME/.config/zsh/keybindings.sh"


