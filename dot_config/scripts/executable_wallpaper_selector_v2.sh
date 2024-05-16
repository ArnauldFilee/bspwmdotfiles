#!/bin/bash

# Répertoire contenant les images de fond d'écran
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/"

# Définir la commande pour afficher les images avec prévisualisation
# Cette commande affiche chaque image avec son chemin complet et une prévisualisation dans Rofi
ROFI_COMMAND="ls $WALLPAPER_DIR | xargs -I{} echo \"$WALLPAPER_DIR{}\""

# Utiliser Rofi pour afficher les images avec prévisualisations
SELECTED_IMAGE=$(eval "$ROFI_COMMAND" | rofi -dmenu -p "Select Wallpaper" -theme /home/arnauld/.config/rofi/launcher.rasi -format i)

# Vérifier si une image a été sélectionnée
if [ -n "$SELECTED_IMAGE" ]; then
    # Récupérer le chemin complet de l'image sélectionnée en utilisant l'index
    IMAGE_PATH=$(eval "$ROFI_COMMAND" | sed "${SELECTED_IMAGE}q;d")

    # Utiliser feh pour définir l'image comme fond d'écran
    feh --bg-fill "$IMAGE_PATH"

    # Afficher une notification pour confirmer le changement
    notify-send "Wallpaper set to $(basename "$IMAGE_PATH")"
fi
