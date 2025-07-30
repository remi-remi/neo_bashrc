#!/bin/bash
FILE="$1"

# Si pas de fichier, tu ouvres quand même nvim
if [ -z "$FILE" ]; then
  terminator -e nvim
else
  terminator -e "nvim \"$FILE\""
fi
