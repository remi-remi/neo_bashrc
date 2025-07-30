# this script provide my alias with a check of required package to avoid breaking the terminal if the required package is not available

requirePackage(){
	local requiredPackage='$1'
	command -v $1 >/dev/null 2>&1
}

echo_green() { echo -e "\e[32m$1\e[0m"; }

echo_red() { echo -e "\e[31m$1\e[0m"; }

echo_blue() { echo -e "\e[34m$1\e[0m"; }

echo_green 'Twysted Custom Alias Script'

# discrete color alias
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# troll but usefull alias
alias clera="clear ; toilet --gay 'clera ???' "

{

	echo -e 'alias\tcommand\tdescription'
	
	requirePackage ls && {
		alias ll='ls -alFh --color=auto'
		echo_blue 'll\t ls -alFh \t (All,Long list,classiFy,Human)'

		alias la='ls -Ah --color=auto'
		echo_blue 'la \t ls -A \t\t (Almost all) exclude . and ..'

		alias lr='ls -r1 --color=auto'
		echo_blue 'lr \t ls -r1 \t (Row 1)'
	}

	requirePackage nala && {
		alias apt='nala'
		echo_blue 'apt \t nala \t\t nala overwrite apt'
	}

	requirePackage nvim && {
		alias vimconf='nvim ~/.config/nvim/init.vim'
		echo_blue 'vimconf  nvim ~/.config/nvim/init.vim \t edit neovim configuration'
		
		alias vim='nvim'
		echo_blue 'vim \t nvim \t nvim overwrite vim'
	}

	requirePackage batcat && {
		
		alias ccat='batcat -pp '
		echo_red 'ccat dont work'
		echo_blue 'ccat \t batcat -pp \t ColoredCat use batcat to make a colored cat'

		alias bat='batcat'
		echo_blue 'bat \t batcat \t bat short batcat (bat or batcat may be used by default depending on your distro)'
	}

	requirePackage toilet && {
		alias clera="clear ; toilet --gay 'clera ???' "
	}

	requirePackage alert && {
		alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
		echo_blue 'alert \t notify-send \t too complex to explain here use it after a command (ls ; alert) to send a result notification '
	}

	requirePackage trash-put && {
		alias rm='trash-put'
		echo_blue 'rm \t trash-put \t send to a virtual trash instead of delete for real'
	}

	requirePackage docker && {
		dockerExecIt (){
			docker exec -it $1 $2 
		}
		alias d-psa='docker ps -a'
		echo_blue 'd-psa \t docker ps -a \t show all container'
	}

	docker compose version 2>&1>/dev/null && {
		alias dc-psa='docker compose ps -a'
		echo_blue 'dc-psa \t docker compose ps -a \t show all container in this context'

		echo_blue 'dc-reset_rebuild_allcontainers \t docker compose down,rm -f,up --build -d, logs -f \t ask confirmation before reset'
		dc-reset_rebuild_allcontainers(){

		echo_red "NON-PERSISTENT DATA WILL BE LOST"
		echo_red "(data overwrite by Dockerfile and entrypoint included)"
		echo_red "RESET ALL CONTAINER ? "
		echo_blue 'will use : docker compose : down, rm -f, up --build -d, logs -f'
		
		sleep 1

		userResponse='no'
		read -p '(YES) to confirm>' userResponse
		if [ "$userResponse" == "YES" ]; then
			
			echo_blue '_> docker compose down'
			
			docker compose down && {
				echo_blue '_> docker compose rm -f'
				docker compose rm -f 
			}|| exit

			echo_blue '_> docker compose up --build -d'
			
			docker compose up --build -d && {
				docker compose logs -f
			} || {
				echo_red 'BUILD FAILURE';
			}

			docker compose ps -a
		fi
		}


	}
} | sed 's/^/\t/'

unset -f requirePackage
