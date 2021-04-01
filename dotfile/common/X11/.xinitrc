#!/bin/sh

set -eu

host_include=~/.xinitrc@$(hostname -s)
if [ -f "${host_include}" ]; then
    # shellcheck disable=SC1090
    . "${host_include}"
fi
unset host_include

xset r rate 300 28

feh --bg-scale .local/share/wallpaper/elvish-falls-twilight.jpg &
xbanish &
slstatus &
exec ssh-agent dbus-launch --sh-syntax --exit-with-session dwm
