# ZSH Aqua Stingray Theme

_USERNAME=""
if [[ $UID -eq 0 ]]; then
	_USERNAME="%{$fg[red]%}"
else
	_USERNAME="%{$fg[black]%}"
fi
_USERNAME="$_USERNAME%n"

SEPERATOR="%{$fx[bold]%}›"

setopt prompt_subst

PROMPT="%{$fg[blue]$fx[bold]%}%~ %{$fx[no-bold]$fg[bblack]%}!%! %{$fg[green]%}%(?..%{$fg[red]%})$SEPERATOR%{$reset%} "

RPROMPT="%(?..%{$bg[red]$fg[black]%} %? %{$reset%})%{$bg[bwhite]$fx[bold]%} $_USERNAME %{$fx[no-bold]$bg[bblack]$fg[black]%} %m %{$reset%}"

title "[ $USER $(hostname) ]"
