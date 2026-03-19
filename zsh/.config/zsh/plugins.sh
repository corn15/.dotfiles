_zsh_plugin_dir="${ZSH_PLUGIN_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins}"

typeset -U fpath
[ -d "${_zsh_plugin_dir}/zsh-completions/src" ] && fpath=("${_zsh_plugin_dir}/zsh-completions/src" $fpath)

autoload -Uz compinit
compinit -d "${ZDOTDIR:-$HOME}/.zcompdump"

[ -r "${_zsh_plugin_dir}/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "${_zsh_plugin_dir}/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting must be sourced after prompt/widgets/completion initialization.
[ -r "${_zsh_plugin_dir}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "${_zsh_plugin_dir}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unset _zsh_plugin_dir
