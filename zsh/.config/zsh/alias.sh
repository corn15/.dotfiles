alias rmrf="rm -rf"
alias psef="ps -ef"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias grep="grep -n --color"
alias vi="nvim"
alias vim="nvim"

case "$(uname -s)" in
  Darwin)
    [ -f "$HOME/.config/zsh/darwin/alias.sh" ] && source "$HOME/.config/zsh/darwin/alias.sh"
    ;;
  Linux)
    [ -f "$HOME/.config/zsh/linux/alias.sh" ] && source "$HOME/.config/zsh/linux/alias.sh"
    ;;
esac
