# Logic for displaying the runtime of slow commands

_lasttime=0
_cmd_time_preexec() {
	_lasttime=$(date +%s)
}
_cmd_time_precmd() {
	local t=$(date +%s)
	if [ $(($t - $_lasttime)) -gt 5 ] && [ $_lasttime -ne 0 ]
	then
		echo "Time: $(timetohuman $(($t - $_lasttime)))"
	fi
}

precmd_functions+=(_cmd_time_precmd)
preexec_functions+=(_cmd_time_preexec)

# from SO
function timetohuman {
	local T=$1
	local D=$((T/60/60/24))
	local H=$((T/60/60%24))
	local M=$((T/60%60))
	local S=$((T%60))
	(( $D > 0 )) && printf "$fg[red]%d $fg[default]day%s " $D $((($D != 1)) && printf "s")
	(( $H > 0 )) && printf "$fg[yellow]%d $fg[default]hour%s " $H $((($H != 1)) && printf "s")
	(( $M > 0 )) && printf "$fg[green]%d $fg[default]minute%s " $M $((($M != 1)) && printf "s")
	(( $D > 0 || $H > 0 || $M > 0 )) && printf "and "
	printf "$fg[blue]%d $fg[default]second%s\n" $S $((($S != 1)) && printf "s")
}
