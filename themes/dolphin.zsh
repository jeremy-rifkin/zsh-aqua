# ZSH Aqua Dolphin Theme

# Color the username red if root
_USERNAME=""
if [[ $UID -eq 0 ]]; then
	_USERNAME="%{$fg[red]%}"
else
	_USERNAME="%{$fg[white]%}"
fi

# Values
_USERNAME="$_USERNAME%n"
_SERVER="%m"
_PATH="%~"

setopt prompt_subst
SEPERATOR="%{$fx[bold]%}›"

# Left prompt
PROMPT="%{$fg[bblack]%}$_SERVER %{$fx[bold]%}$_USERNAME %{$fg[blue]%}$_PATH %{$fx[no-bold]$fg[bblack]%}!%! %{$fg[white]%}%(?..%{$fg[red]%})$SEPERATOR %{$reset%}"
# Right prompt
return_code=""
RPROMPT="%(?..%{$fg[red]%}%? ↵%{$reset%})%{$reset%}"

title "[ $USER $(hostname) ]"
