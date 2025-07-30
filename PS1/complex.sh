# Définition des couleurs en RGB
# \[\033[38;2; R;G;B m\]
cyan='\[\033[38;2;0;255;255m\]'        # Cyan
dark_cyan='\[\033[38;2;0;150;150m\]'  # Cyan foncé
blue='\[\033[38;2;0;100;255m\]'         # Bleu foncé
reset_color='\[\033[0m\]'             # Reset couleur

# Composants du prompt
user_host="${blue}\u${dark_cyan}(${cyan}@${dark_cyan})${dark_cyan}${blue}\h"  # username(@)hostname
working_dir="${cyan}[${blue}\w${cyan}]"        # [~/path]
prompt_end="${cyan}╰─<${cyan}\$(getCurrentGitBranch)${cyan}> ${reset_color}"  # Footer avec branche Git

# Fonction pour récupérer la branche Git
getCurrentGitBranch() {
git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '¤'
}

# Construction finale
PS1="${cyan}╭─(${user_host}${cyan})${blue}-${working_dir}\n${prompt_end}"
