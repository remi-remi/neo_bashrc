requirePackage(){
    local requiredPackage="$1"
    command -v "$requiredPackage" >/dev/null 2>&1
}

# Remplacer "pluginName" par le nom de ton plugin
echo_green "Loading Plugin: fzf Integration"

requirePackage fzf && {
    # Ici tu configures fzf pour bash
    [[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
    [[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

    echo_green "fzf plugin loaded successfully."
} || {
    echo_red "Error: fzf is not installed. Plugin not loaded."
}

unset -f requirePackage

