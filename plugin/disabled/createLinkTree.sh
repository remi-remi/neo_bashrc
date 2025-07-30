#!/bin/bash

echo "THIS SCRIPT IS NOT READY"

# Répertoire source (à copier)
SOURCE_DIR="/home/remi/cmus"

# Répertoire cible (où créer les liens symboliques)
TARGET_DIR="/home/remi/cmus_nat"

# Créer la structure de répertoires dans le dossier cible
#find "$SOURCE_DIR" -type d -exec bash -c 'mkdir -p "$1/${0#"$1"}"' {} "$TARGET_DIR" \;

# Créer les liens symboliques pour chaque fichier
#find "$SOURCE_DIR" -type f -exec bash -c 'ln -s "$0" "$1/${0#"$1"}"' {} "$TARGET_DIR" \;

echo "L'arborescence a été copiée avec des liens symboliques dans $TARGET_DIR."

