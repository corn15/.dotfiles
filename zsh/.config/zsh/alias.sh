alias rmrf="rm -rf"
alias psef="ps -ef"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias tree='tree -CAFa -I "CVS|*.*.package|.svn|.git|.hg|node_modules|bower_components" --dirsfirst'
alias grep="grep -n --color"
alias vi="nvim"
alias vim="nvim"
alias apt="sudo apt"
alias brew="sudo brew"

if command -v batcat >/dev/null 2>&1; then
  alias cat="batcat"
elif command -v bat >/dev/null 2>&1; then
  alias cat="bat"
fi
