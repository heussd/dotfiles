#!/bin/bash
xrandr --output VGA-1 --above LVDS-1


# Load user keycodes
#if [[ -e ~/.Xmodmap.$HOSTNAME ]]; then
#	xmodmap ~/.Xmodmap.$HOSTNAME &
#fi

#Tune terminal emulation
#xrdb -load ~/.Xdefaults

#xcompmgr -cC &
#xscreensaver -no-splash &

urxvtd -f -q -o &
#sleep 2 & trayer --edge top --align right --widthtype request --heighttype request --transparent true --alpha 255 --SetPartialStrut false --SetDockType false &
glipper &


sleep 4 & eval `cat ~/.fehbg`
