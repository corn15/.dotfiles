# zsh config entrypoint

# Load environment variables first.
[ -f "$HOME/.config/zsh/environment.sh" ] && source "$HOME/.config/zsh/environment.sh"

# Load user functions.
[ -f "$HOME/.config/zsh/function.sh" ] && source "$HOME/.config/zsh/function.sh"

# Load prompt setup before plugin widgets are finalized.
[ -f "$HOME/.config/zsh/prompt.sh" ] && source "$HOME/.config/zsh/prompt.sh"

# Load plugins after prompt setup so completion is initialized and syntax highlighting can wrap widgets.
[ -f "$HOME/.config/zsh/plugins.sh" ] && source "$HOME/.config/zsh/plugins.sh"

# Load tool-specific shell integrations.
for file in "$HOME/.config/zsh/tools/"*.sh(N); do
  source "$file"
done

# Load machine-local config.
[ -f "$HOME/.config/zsh/local.sh" ] && source "$HOME/.config/zsh/local.sh"

# Load key bindings after plugins/tools so custom bindings win.
[ -f "$HOME/.config/zsh/keybindings.sh" ] && source "$HOME/.config/zsh/keybindings.sh"

# Load aliases last so they can override plugin/tool aliases.
[ -f "$HOME/.config/zsh/alias.sh" ] && source "$HOME/.config/zsh/alias.sh"
