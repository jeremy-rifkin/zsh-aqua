# Color and formatting definitions

# Unset pre-defined colors
unset fg
unset bg

typeset -AHg fx fg bg
fx=(
	reset     $'\x1b[00m'
	bold      $'\x1b[01m' no-bold      $'\x1b[22m'
	italic    $'\x1b[03m' no-italic    $'\x1b[23m'
	underline $'\x1b[04m' no-underline $'\x1b[24m'
	blink     $'\x1b[05m' no-blink     $'\x1b[25m'
	reverse   $'\x1b[07m' no-reverse   $'\x1b[27m'
)
fg=(
	black    $'\x1b[30m'
	red      $'\x1b[31m'
	green    $'\x1b[32m'
	yellow   $'\x1b[33m'
	blue     $'\x1b[34m'
	magenta  $'\x1b[35m'
	cyan     $'\x1b[36m'
	white    $'\x1b[37m'

	bblack   $'\x1b[90m'
	bred     $'\x1b[91m'
	bgreen   $'\x1b[92m'
	byellow  $'\x1b[93m'
	bblue    $'\x1b[94m'
	bmagenta $'\x1b[95m'
	bcyan    $'\x1b[96m'
	bwhite   $'\x1b[97m'

	default  $'\x1b[39m'
)
bg=(
	black    $'\x1b[40m'
	red      $'\x1b[41m'
	green    $'\x1b[42m'
	yellow   $'\x1b[43m'
	blue     $'\x1b[44m'
	magenta  $'\x1b[45m'
	cyan     $'\x1b[46m'
	white    $'\x1b[47m'

	bblack   $'\x1b[100m'
	bred     $'\x1b[101m'
	bgreen   $'\x1b[102m'
	byellow  $'\x1b[103m'
	bblue    $'\x1b[104m'
	bmagenta $'\x1b[105m'
	bcyan    $'\x1b[106m'
	bwhite   $'\x1b[107m'

	default  $'\x1b[49m'
)
reset=$'\x1b[0m'

_lscolors() {
	for key in black red green yellow blue magenta cyan white bblack bred bgreen byellow bblue bmagenta bcyan bwhite default
	do
		echo -e "$key $fg[$key].AAA. $reset$bg[$key].AAA.$reset"
	done
	for key in bold italic underline blink reverse
	do
		echo -e "$key $fx[$key].AAA.$reset"
	done
}
alias lscolors="_lscolors | column -s\" \" -t -n"
