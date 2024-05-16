xrandr --output eDP-1 --primary --mode 1920x1080 --output DP-1-1 --mode 1920x1080 --rotate normal --above eDP-1
bspc monitor eDP-1 -d 1 2 3 7 8 9
bspc monitor DP-1-1 -d 4 5 6
killall polybar
polybar &