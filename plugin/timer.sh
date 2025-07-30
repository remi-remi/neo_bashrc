#!/bin/bash

timer() {
    # Affiche les instructions d'utilisation du script
    usage() {
        echo "Usage:"
        echo "  timer [time format]           (e.g., 1:20 or 120)"
        echo "  timer -h <hours> -m <minutes> -s <seconds>"
        return 1
    }

    # Analyse les arguments pour définir les heures, minutes et secondes
    parse_args() {
        local hours=0
        local minutes=0
        local seconds=0

        if [[ $# -eq 1 ]]; then
            if [[ "$1" =~ ^[0-9]+:[0-9]+$ ]]; then
                # Format mm:ss ou hh:mm
                IFS=':' read -r minutes seconds <<< "$1"
            elif [[ "$1" =~ ^[0-9]+$ ]]; then
                # Format en secondes uniquement
                seconds="$1"
            else
                usage
            fi
        elif [[ $# -gt 1 ]]; then
            # Format avec options -h -m -s
            while getopts "h:m:s:" opt; do
                case $opt in
                    h) hours="$OPTARG" ;;
                    m) minutes="$OPTARG" ;;
                    s) seconds="$OPTARG" ;;
                    *) usage ;;
                esac
            done
        else
            usage
        fi

        # Retourne les valeurs des heures, minutes et secondes
        echo "$hours $minutes $seconds"
    }

    # Convertit les heures, minutes et secondes en millisecondes
    convert_to_ms() {
        local hours="$1"
        local minutes="$2"
        local seconds="$3"
        echo $(( (hours * 3600 + minutes * 60 + seconds) * 1000 ))
    }

    # Affiche le temps restant sous le format [mm:ss:ms] avec des couleurs spécifiques
    display_time() {
        local total_time_ms="$1"
        local minutes=$((total_time_ms / 60000))
        local seconds=$(((total_time_ms / 1000) % 60))
        local milliseconds=$(( (total_time_ms % 1000) / 10 ))  # Millisecondes en deux chiffres

        # Codes couleurs : bleu pour les crochets, blanc pour le texte
        local blue="\e[34m"
        local white="\e[97m"
        local reset="\e[0m"

        # Affiche le timer avec un retour de chariot pour mettre à jour sur la même ligne
        printf "\r${blue}[${white}%02d:%02d:%02d${blue}]${reset}" "$minutes" "$seconds" "$milliseconds"
    }

    # Exécute le timer avec un compte à rebours
    run_timer() {
        local total_time_ms="$1"

        while [ "$total_time_ms" -gt 0 ]; do
            display_time "$total_time_ms"

            # Pause pour éviter une utilisation excessive du CPU
            sleep 0.01
            total_time_ms=$((total_time_ms - 10))
        done

        # Affichage final à [00:00:00]
        printf "\r\e[34m[\e[97m00:00:00\e[34m]\e[0m\n"
    }

    # Main - exécution de la commande timer
    read -r hours minutes seconds <<< "$(parse_args "$@")"
    total_time_ms=$(convert_to_ms "$hours" "$minutes" "$seconds")
    run_timer "$total_time_ms"
}

export -f timer

