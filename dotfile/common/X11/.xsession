#!/bin/sh

set -eu

syncthing --no-browser &
trap 'kill $!' EXIT

xset r rate 300 28
xset b off

xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation" 1
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Button" 2
xinput set-prop "/dev/wsmouse" "WS Pointer Wheel Emulation Axes" 6 7 4 5

feh --bg-scale .local/share/wallpaper/elvish-falls-twilight.jpg &
xbanish &
xidle -ne -program "$(which slock)" -timeout 600 &
~/bin/slstatus &
ssh-agent dbus-launch --sh-syntax --exit-with-session ~/bin/dwm
