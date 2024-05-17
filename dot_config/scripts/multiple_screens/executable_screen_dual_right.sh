second_screen=$(xrandr | awk '/ connected/{print $1, $2}' | awk 'NR==2 {print $1}')
xrandr --output eDP-1 --primary --mode 1920x1080 --output "$second_screen" --mode 1920x1080 --rotate normal --right-of eDP-1
bspc monitor eDP-1 -d 1 2 3 
bspc monitor "$second_screen" -d 4 5 6
feh --randomize --bg-fill $HOME/Pictures/Wallpapers/ &