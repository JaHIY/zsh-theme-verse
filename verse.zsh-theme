if [ -z "$OH_MY_ZSH_HG" ]; then
    OH_MY_ZSH_HG='hg'
fi

function virtualenv_info {
    [ "$VIRTUAL_ENV" ] && printf '(%s) \n' "$(basename "$VIRTUAL_ENV")"
}

function battery_charge {
    [ -x "$BATTERY_CHARGE" ] && printf ' using %s\n' "$("$BATTERY_CHARGE")" 2>/dev/null
}

function hg_prompt_info {
    $OH_MY_ZSH_HG prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

PROMPT='
%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg_bold[green]%}%~%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)$(battery_charge)
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
