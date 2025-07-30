if [ "$color_prompt" = yes ]; then
    # Définition des couleurs
    cyan='\[\033[1;36m\]'
    blue='\[\033[1;34m\]'
    light_cyan='\[\033[1;96m\]'
    reset_color='\[\033[0m\]'

    # Composants de l'invite
    user_host="${blue}\u${light_cyan}@${blue}\h"
    working_dir="${cyan}[${blue}\w${cyan}]"
    prompt_end="${blue} \$${reset_color}"

    # Fonction pour récupérer la branche Git
    getCurrentGitBranch() {
        git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '¤'
    }

    # Construction finale du PS1
    PS1="${cyan}${user_host}${light_cyan} - ${working_dir} $(getCurrentGitBranch)${prompt_end} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    echo "color_prompt=no using secondary PS1"
fi

