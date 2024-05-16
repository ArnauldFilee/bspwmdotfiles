second_screen=$(xrandr | awk '/ connected/{print $1, $2}' | awk 'NR==2 {print $1}')
xrandr --output eDP-1 --off  --output "$second_screen" --primary --mode 1920x1080 --rotate normal --right-of eDP-1
bspc monitor "$second_screen" -d 1 2 3 4 5 6 7 8 9 10
feh --randomize --bg-fill $HOME/Pictures/Wallpapers/ &