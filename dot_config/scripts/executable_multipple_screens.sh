#!/bin/bash

confirm_continue() {
    local screen_count="$1"
    local prompt="Screens detected: $screen_count. Do you want to continue ?"
    local options=("Yes" "No")
    printf "%s\n" "${options[@]}" | rofi -dmenu -i -p "$prompt"
}

delete_monitors_non_active(){
    local monitor="$1"
    local active_monitors=("${@}")
    found=false
    for act_monitor in "${active_monitors[@]}";do
        if [[ "$act_monitor" == "$monitor" ]]; then
            found=true
            break
        fi
    done
    if [ "$found" == false ];then
        echo "$monitor" non active
        bspc monitor "$monitor" -r
        xrandr --output "$monitor" --off
    fi
}


screens=($(xrandr | awk '/ connected/{print $1}'))
screen_number="${#screens[@]}"


active_monitors=($(xrandr --listactivemonitors | awk 'NR > 1 {print $4}'))

for screen in "${screens[@]}";do
    delete_monitors_non_active "$screen" "${active_monitors[@]}"
done


# Afficher une boîte de dialogue Rofi pour continuer ou arrêter
response=$(confirm_continue "$screen_number")

if [ "$response" != "Yes" ]; then    
    exit 1
fi
if [ "$screen_number" == 2 ]; then
    PRIMARY=${screens[0]}
    bspc wm -r
fi
if [ "$screen_number" == 2 ]; then
    PRIMARY=${screens[0]}
    SECONDARY=${screens[1]}
    OPTIONS="  Up\n Left\n Right\n󱞠 Mirror\n second screen only"
    SELECTED_OPTION=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Place second screen to")
    case $SELECTED_OPTION in
    "  Up")
        xrandr --output "$PRIMARY" --primary --mode 1920x1080 --output "$SECONDARY" --mode 1920x1080 --rotate normal --above "$PRIMARY"
        bspc monitor "$PRIMARY" -d 1 2 3 
        bspc monitor "$SECONDARY" -d 4 5 6
        bspc desktop 7 -r 
        bspc desktop 8 -r 
        bspc desktop 9 -r 
        bspc wm --reorder-monitors "$PRIMARY" "$SECONDARY"
        ;;
    " Left")
        xrandr --output "$PRIMARY" --primary --mode 1920x1080 --output "$SECONDARY" --mode 1920x1080 --rotate normal --left-of "$PRIMARY"
        bspc monitor "$PRIMARY" -d 1 2 3 
        bspc monitor "$SECONDARY" -d 4 5 6
        bspc desktop 7 -r 
        bspc desktop 8 -r 
        bspc desktop 9 -r 
        bspc wm --reorder-monitors "$PRIMARY" "$SECONDARY"

        ;;
    " Right")
        bspc monitor "$PRIMARY" -d 1 2 3 
        bspc monitor "$SECONDARY" -d 4 5 6
        bspc desktop 7 -r 
        bspc desktop 8 -r 
        bspc desktop 9 -r 

        xrandr --output "$PRIMARY" --primary --mode 1920x1080 --output "$SECONDARY" --mode 1920x1080 --rotate normal --right-of "$PRIMARY"
        bspc wm --reorder-monitors "$PRIMARY" "$SECONDARY"
        ;;
    "󱞠 Mirror")
        xrandr --output "$PRIMARY" --primary --mode 1920x1080 --output "$SECONDARY" --mode 1920x1080 --rotate normal --same-as "$PRIMARY"
        ;;
    " second screen only")
        bspc desktop 1 -r 
        bspc desktop 2 -r 
        bspc desktop 3 -r 
        bspc desktop 4 -r 
        bspc desktop 5 -r 
        bspc desktop 6 -r 
        bspc desktop 7 -r 
        bspc desktop 8 -r 
        bspc desktop 9 -r 
        bspc desktop 10 -r 
        bspc monitor "$SECONDARY" -d 1 2 3 4 5 6 7 8 9 10
        xrandr --output "$PRIMARY" --off  --output "$SECONDARY" --primary --mode 1920x1080 --rotate normal
        ;;
    *)
        echo "Option non valide"
        ;;
    esac
fi

if [ "$screen_number" == 3 ]; then
    PRIMARY=${screens[0]}
    SECONDARY=${screens[1]}
    TERTIARY=${screens[2]}

    xrandr --output "$PRIMARY" --primary --mode 1920x1080 --output "$SECONDARY" --mode 1920x1080 --rotate normal --above "$PRIMARY" --output "$TERTIARY" --mode 2560x1440 --rotate normal --right-of "$SECONDARY"
    bspc wm --reorder-monitors "$PRIMARY" "$SECONDARY" "$TERTIARY"
    bspc monitor "$PRIMARY" -d 1 2 3 
    bspc monitor "$SECONDARY" -d 4 5 6
    bspc monitor "$TERTIARY" -d 7 8 9
fi
feh --randomize --bg-fill "$HOME/Pictures/Wallpapers/" &
