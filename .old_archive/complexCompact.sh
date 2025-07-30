    # Définition des couleursi
    cyan='\[\e[0;36m\]'
    blue='\[\e[38;5;27m\]'
    light_cyan='\[\e[38;5;73m\]'
    reset_color='\[\e[0;37m\]'

    # Composants de l'invite
    user_host="${blue}\u${light_cyan}(${cyan}@${light_cyan})${blue}\h"
    working_dir="${cyan}[${blue}\w${cyan}]"
    prompt_end="${blue}${reset_color} "
   
    getCurrentGitBranch() {
        git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '-'
    }
	
    # Construction finale du PS1
    PS1="${cyan}\[\e(0\]lq\[\e(B\]${working_dir}
\[\e(0\]mq\[\e(B\]<\$(getCurrentGitBranch)>${prompt_end}"
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    unset color_prompt force_color_prompt

