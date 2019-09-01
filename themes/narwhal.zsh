# ZSH Aqua Narwhal Theme

_USERNAME="%n"
_SERVER="%m"
_PATH="%~"

setopt prompt_subst

# Segment generation functions
SEPR=$'\ue0b0'
SEPL=$'\ue0b2'
CURRENT_BG=""
# Builder functions
function prompt_segment() {
	# prompt_segment background foreground
	if [ -z $CURRENT_BG ]
	then
		PROMPT="$PROMPT%{$bg[$1]%}%{$fg[$2]%} $3"
	else
		PROMPT="$PROMPT%{$bg[$1]%}%{$fg[$CURRENT_BG]%}$SEPR%{$fg[$2]%} $3"
	fi
	CURRENT_BG=$1
}
function prompt_segment_end() {
	if [ -z $CURRENT_BG ]
	then
		return 1
	fi
	PROMPT="$PROMPT%{$reset_color%}%{$fg[$CURRENT_BG]%}$SEPR%{$reset_color%} "
	CURRENT_BG=""
}
function rprompt_segment() {
	# prompt_segment background foreground
	RPROMPT="$RPROMPT%{$fg[$1]%}$SEPL%{$bg[$1]%}%{$fg[$2]%}$3 "
}
function rprompt_segment_end() {
	# prompt_segment background foreground
	RPROMPT="$RPROMPT%{$reset_color%}"
}

# Build left prompt
PROMPT=""
prompt_segment bblack black $_SERVER
prompt_segment bwhite black $_USERNAME
prompt_segment blue bwhite "%{$fx[bold]%}$_PATH%{$fx[no-bold]%}"
prompt_segment bblack black "!%!"
#prompt_segment green black ""
PROMPT="$PROMPT%{$bg[green]%}%{$fg[$CURRENT_BG]%}%(?..%{$bg[red]%})$SEPR%{$bg[default]%}%{$fg[green]%}%(?..%{$fg[red]%})$SEPR%{$reset%} "

# Build right prompt
RPROMPT="%(?.."
rprompt_segment red black "%?"
RPROMPT="$RPROMPT%{$reset%})"

title "[ $USER $(hostname) ]"
