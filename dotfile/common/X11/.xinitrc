#!/bin/sh

set -eu

xset r rate 300 28
xset b off

feh --bg-scale .local/share/wallpaper/elvish-falls-twilight.jpg &
xbanish &
xidle -ne -program $(which slock) -timeout 300 &
~/bin/slstatus &
exec ssh-agent dbus-launch --sh-syntax --exit-with-session ~/bin/dwm
