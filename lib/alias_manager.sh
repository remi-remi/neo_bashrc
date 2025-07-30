# DONT REMOVE THIS SCRIPT
# its not a simple alias, this script us used to add tools to allow some verification on alias pack
# if removed, neo_bash wont be able to seek alias on this dir
 
# this script provide my alias with a check of required package to avoid breaking the terminal if the required package is not available

requirePackage(){
	local requiredPackage='$1'
	command -v $1 >/dev/null 2>&1
}

echo_red() { echo -e "\e[31m$1\e[0m"; }
echo_green() { echo -e "\e[32m$1\e[0m"; }
echo_blue() { echo -e "\e[34m$1\e[0m"; }


{
	for alias in ~/NEO_BASHRC/alias/*.sh; do
	    [ -r "$alias" ] && source "$alias"
	done

} || {
	echo_red 'BUILD FAILURE';
}

unset -f requirePackage
