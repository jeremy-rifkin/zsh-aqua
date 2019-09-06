# Utility suite

# Git info format definitions
#  **master** ▾ ● ●
ZSH_THEME_GIT_PROMPT_PREFIX="$fg[green]\ue0a0$reset$fg[white] "
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]\u2713$reset "
ZSH_THEME_GIT_PROMPT_AHEAD="$fg[cyan]\u25b4$reset "
ZSH_THEME_GIT_PROMPT_BEHIND="$fg[magenta]\u25be$reset "
ZSH_THEME_GIT_PROMPT_STAGED="$fg[green]\u25cf$reset "
ZSH_THEME_GIT_PROMPT_UNSTAGED="$fg[yellow]\u25cf$reset "
ZSH_THEME_GIT_PROMPT_UNTRACKED="$fg[red]\u25cf$reset "

# ls wrapper - add color
function ls() {
	# Files
	/bin/ls --color "$@"
}

# ls with disk usage and git info
function dir() {
	# Files
	ls "$@"

	# Disk
	local _d=$(pwd)
	local d=$(pwd)
	# Get the dir we're working on... The first two args are considered
	if [ $# -gt 0 ]
	then
		local p=$(realpath $1 -q 2>/dev/null)
		if [ -e $p ]
		then
			d=$p
		elif [ $# -gt 1 ]
		then
			p=$(realpath $2 -q 2>/dev/null)
			if [ -e $p ]
			then
				d=$p
			fi
		fi
	fi
	echo "disk: $(du -cshPx $d 2>/dev/null | tail -n 1 | awk '{print $1;}')"

	# Git
	cd "$d"
	local _P=$(git_info)
	cd "$_d"
	if [ -n "$_P" ]; then
		echo "git: $_P"
	fi
}

# Helpful aliases
alias la="ls -a"
alias catn="cat --number"
alias g="grep"
alias cd..="cd .."
# lsblk column definition
alias lsblk="/bin/lsblk -o NAME,LABEL,FSTYPE,SIZE,TYPE,MOUNTPOINT "

# List top disk usage by item
function lu() {
	local d=.
	if [ $# -ne 0 ]
	then
		d=$1
	fi
	du $d/* -shcx | sort -rh
}

# Create directory and cd into it
function take() {
	if [ $# -eq 0 ]
	then
		echo "must specify name or path"
		return 1
	fi
	mkdir -p $1 && cd $1
}

# Get computer's global ip address
alias getip="curl \"https://api.ipify.org/?format=text\"; echo"

# Generate random password
function genpasswd() {
	local n=10
	if [ $# -ne 0 ]
	then
		local n=$1
	fi
	strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $n | tr -d '\n'; echo
}

# Directory tree
alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

# Perform md5, sha1, and sha256 checksums
function check() {
	if [ $# -eq 0 ]
	then
		echo "Must specify file."
		return 1
	fi
	if [ ! -f $1 ]
	then
		echo "$fg[red]Error:$reset File doesn't exist."
		return 1
	fi
	echo "md5 $(md5sum $1)\nsha1 $(sha1sum $1)\nsha256 $(sha256sum $1)" | column -t -s" "
}

# cd up $1 dirs (or 1 dir if $1 isn't provided)
function up() {
	local _u=1
	if [ $# -gt 0 ]
	then
		_u=$1
	fi
	if (($_u < 0))
	then
		echo "Nice try."
		return 1
	fi

	for i in {1..$1}
	do
		cd ..
	done
}

# Navigation helpers: back, forward
# back - goes back to a previous directory
# forward - goes forward in history (only remembers one directory TODO)
_lastd=""
function back() {
	_lastd=$(pwd)
	popd
}
function forward() {
	if [ $_lastd == "" ]
	then
		return 1
	fi
	cd "$_lastd"
	_lastd=""
}
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# More navigation helpers
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Display directory stack
alias d='dirs -v | head -10'


# Help on information on important library functions
function help() {
	echo "ZSH Aqua library function help"
	echo "la - eqivilent to ls -a
lu [path] - list disk usage by item in path (default path=.)
dir - shows directory contents as well as some extra directory information
take <dir> - make dir and cd into it
tree - list directory tree
up <n> - cd up n dirs
back - go back to the previous dir
forward - go forward
d - print dir history stack
genpasswd [n] - generate random password of length n (default n=10)
check <file> - perform md5, sha1, and sha256 checksums on file
catn - eqivilent to cat --numbered
getip - retrieve computer's public ip
g - shorthand for grep
zsh_stats - show statistics on your command history" | column -s"-" -t
}
