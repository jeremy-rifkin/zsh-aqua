# Helper functions for getting info about git repositories
# Modified from: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bureau.zsh-theme

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_AHEAD=""
ZSH_THEME_GIT_PROMPT_BEHIND=""
ZSH_THEME_GIT_PROMPT_STAGED=""
ZSH_THEME_GIT_PROMPT_UNSTAGED=""
ZSH_THEME_GIT_PROMPT_UNTRACKED=""
git_branch() {
	local ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
	ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
	echo "${ref#refs/heads/}"
}
git_status() {
	local _STATUS=""
	# check status of files
	local _INDEX=$(command git status --porcelain 2> /dev/null)
	if [[ -n "$_INDEX" ]]; then
		if $(echo "$_INDEX" | command grep -q '^[AMRD]. '); then
			_STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_STAGED"
		fi
		if $(echo "$_INDEX" | command grep -q '^.[MTD] '); then
			_STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED"
		fi
		if $(echo "$_INDEX" | command grep -q -E '^\?\? '); then
			_STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
		fi
	else
		_STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
	fi
	# check status of local repository
	_INDEX=$(command git status --porcelain -b 2> /dev/null)
	if $(echo "$_INDEX" | command grep -q '^## .*ahead'); then
		_STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
	fi
	if $(echo "$_INDEX" | command grep -q '^## .*behind'); then
		_STATUS="$_STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
	fi
	echo $_STATUS
}
git_info() {
	local _branch=$(git_branch)
	local _status=$(git_status)
	local _result=""
	if [[ "${_branch}x" != "x" ]]; then
		_result="$ZSH_THEME_GIT_PROMPT_PREFIX$_branch"
		if [[ "${_status}x" != "x" ]]; then
			_result="$_result $_status"
		fi
		_result="$_result$ZSH_THEME_GIT_PROMPT_SUFFIX"
	fi
	echo $_result
}
