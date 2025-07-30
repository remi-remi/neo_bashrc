requirePackage(){
	local requiredPackage="$1"
	command -v "$1" >/dev/null 2>&1
}

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

requirePackage ls && {
	alias ll='ls -alFh --color=auto'
	alias la='ls -Ah --color=auto'
	alias lr='ls -r1 --color=auto'
}

unset -f requirePackage

