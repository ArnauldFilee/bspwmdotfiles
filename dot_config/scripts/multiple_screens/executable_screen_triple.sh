xrandr --output eDP-1 --primary --mode 1920x1080 --output DP-1-1 --mode 1920x1080 --rotate normal --above eDP-1 --output DP-1-2 --mode 2560x1440 --rotate normal --right-of DP-1-1
bspc wm --reorder-monitors eDP-1 DP-1-1 DP-1-2
bspc monitor eDP-1 -d 1 2 3 
bspc monitor DP-1-1 -d 4 5 6
bspc monitor DP-1-2 -d 7 8 9
feh --randomize --bg-fill $HOME/Pictures/Wallpapers/ &