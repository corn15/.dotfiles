export EDITOR="nvim"
export VISUAL="nvim"
export STARSHIP_CONFIG=~/.config/starship.toml

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi
