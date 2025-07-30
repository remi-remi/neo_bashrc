#!/bin/bash
# Plugin: endPlay
# Description: Joue un son en fonction du succès ou de l'échec de la commande précédente.

# Chemin vers les fichiers audio
ENDPLAY_AUDIO_DIR="$(dirname "${BASH_SOURCE[0]}")/audio"
ENDPLAY_SUCCESS_FILE="$ENDPLAY_AUDIO_DIR/done.wav"
ENDPLAY_FAIL_FILE="$ENDPLAY_AUDIO_DIR/fail.wav"

# Vérification des prérequis au sourcing
_endPlay_check_requirements() {
    local missing_items=()

    # Vérifie si la commande `play` est disponible
    if ! command -v play >/dev/null 2>&1; then
        missing_items+=("Commande 'play' introuvable (installez 'sox').")
    fi

    # Vérifie si les fichiers audio nécessaires existent
    if [ ! -f "$ENDPLAY_SUCCESS_FILE" ]; then
        missing_items+=("Fichier succès manquant : $ENDPLAY_SUCCESS_FILE")
    fi
    if [ ! -f "$ENDPLAY_FAIL_FILE" ]; then
        missing_items+=("Fichier échec manquant : $ENDPLAY_FAIL_FILE")
    fi

    # Affiche les alertes si des éléments manquent
    if [ ${#missing_items[@]} -ne 0 ]; then
        echo "⚠️ Plugin endPlay : Problèmes détectés !"
        for item in "${missing_items[@]}"; do
            echo "  - $item"
        done
        echo "⚠️ Le plugin ne fonctionnera pas correctement."
    fi
}

# Fonction exposée par le plugin
endPlay() {
    local last_exit_code=$?
    # Joue le son en fonction du résultat
    if [ $last_exit_code -eq 0 ]; then
	echo "code 0 -> endPlay done.wav"
        play "$ENDPLAY_SUCCESS_FILE" >/dev/null 2>&1
    else
	echo "code $? -> endPlay fail.wav"
        play "$ENDPLAY_FAIL_FILE" >/dev/null 2>&1
    fi
    return $last_exit_code
}

# Lancer les vérifications au sourcing
_endPlay_check_requirements

