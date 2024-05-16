#!/bin/bash

# Répertoire contenant les images de fond d'écran
WALLPAPER_DIR="$HOME/Pictures/Wallpapers/" 

# Liste des images dans le répertoire
IMAGES=$(ls "$WALLPAPER_DIR")

# Utiliser Rofi pour afficher la liste des images
SELECTED_IMAGE=$(echo "$IMAGES" | rofi -dmenu -p "Select Wallpaper" -lines 10 -theme /home/arnauld/.config/rofi/launcher.rasi)

# Vérifier si une image a été sélectionnée
if [ -n "$SELECTED_IMAGE" ]; then
    # Chemin complet de l'image sélectionnée
    IMAGE_PATH="$WALLPAPER_DIR$SELECTED_IMAGE"

    # Utiliser feh pour définir l'image comme fond d'écran
    feh --bg-fill "$IMAGE_PATH"

    # Afficher une notification pour confirmer le changement
    notify-send "Wallpaper set to $SELECTED_IMAGE"
fi
