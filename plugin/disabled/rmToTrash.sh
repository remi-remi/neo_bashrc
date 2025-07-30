# this plugin replace rm with trash put and keep the auto-completion
# on kde trash-put will realy put the files on your dolphin trash 

# Alias to use trash-cli instead of rm
alias rm='trash-put'

# Function to handle auto-completion for the rm alias
_trash_put_completion() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(compgen -o default -- "${cur}")

    COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
    return 0
}

# Bind the function to the alias
complete -F _trash_put_completion rm
