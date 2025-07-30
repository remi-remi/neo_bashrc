echo_green "Loading Package Managers Aliases"

requirePackage(){
	local requiredPackage="$1"
	command -v "$1" >/dev/null 2>&1
}

requirePackage nala && {
	alias apt='nala'
} || {
	echo "nala not available, cant alias apt->nala"
}

