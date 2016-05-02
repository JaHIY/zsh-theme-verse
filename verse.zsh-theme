function virtualenv_info {
    [ "$VIRTUAL_ENV" ] && printf '(%s) \n' "$(basename "$VIRTUAL_ENV")"
}

function battery_charge {
    [ -x "$BATTERY_CHARGE" ] && printf ' using %s\n' "$("$BATTERY_CHARGE")" 2>/dev/null
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}%~%{$reset_color%}$(git_prompt_info)$(battery_charge)
$(virtualenv_info)%(?..%{${fg_bold[white]}%}[%?]%{$reset_color%} )%(!.#.$) '

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}✘"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]}+"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[green]}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[green]}%%"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[green]}*"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[green]}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local return_status="%{$fg[red]%}%(?..✘)%{$reset_color%}"
RPROMPT='${return_status}'
