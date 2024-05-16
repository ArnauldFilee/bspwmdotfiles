#!/bin/bash

overlay=/home/arnauld/Pictures/topsecretlockscreen.png

coreshot -f /tmp/currentworkspace.png
convert /tmp/currentworkspace.png -blur 0x5 /tmp/currentworkspaceblur.png
composite -gravity southeast $overlay /tmp/currentworkspaceblur.png /tmp/lockbackground.png
i3lock -i /tmp/lockbackground.png