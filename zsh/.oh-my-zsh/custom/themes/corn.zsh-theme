CORN_ICON=$'\U000F07B8'
GIT_ICON=$'\U0000F418'

PROMPT="%(?:%{$fg_bold[yellow]%}${CORN_ICON}%{$reset_color%} :%{$fg_bold[yellow]%}${CORN_ICON}%{$reset_color%} ) %{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'
RPROMPT='%{$fg[yellow]%}%*%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[red]%}${GIT_ICON} "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
