#!/bin/sh

set -eu

xset r rate 300 28
xset b off

feh --bg-scale .local/share/wallpaper/elvish-falls-twilight.jpg &
xbanish &
slstatus &
exec ssh-agent dbus-launch --sh-syntax --exit-with-session dwm
