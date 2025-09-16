requirePackage(){
	local requiredPackage="$1"
	command -v "$1" >/dev/null 2>&1
}

echo_green "Loading Tool Aliases"

requirePackage nvim && {
	alias vimconf='nvim ~/.config/nvim/init.vim'
	alias vim='nvim'
	alias nv='nvim'
   alias v='nvim .'
}

if requirePackage bat; then
    alias ccat='bat -pp' # C4 !?   --S.Snake
    alias batcat='bat'
elif requirePackage batcat; then
    alias ccat='batcat -pp'
    alias bat='batcat'
fi


requirePackage toilet && {
	alias clera="clear ; toilet --gay 'clera ???' "
}

requirePackage alert && {
	alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
}

requirePackage trash-put && {
	alias rm='trash-put'
}

unset -f requirePackage

