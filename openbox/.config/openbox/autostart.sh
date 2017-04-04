#!/bin/bash
xrandr --output VGA-1 --above LVDS-1
(sleep 5; sh ~/.fehbg) &

# Load user keycodes
#if [[ -e ~/.Xmodmap.$HOSTNAME ]]; then
#	xmodmap ~/.Xmodmap.$HOSTNAME &
#fi

#Tune terminal emulation
#xrdb -load ~/.Xdefaults

#xcompmgr -cC &
#xscreensaver -no-splash &

urxvtd -f -q -o &
sleep 5 && trayer --edge top --align right --widthtype request --heighttype request --transparent true --alpha 255 --SetPartialStrut false --SetDockType false &
glipper &

# Reset audio levels
sleep 5 && (
	amixer set PCM 85% &
	amixer set Headphone 95% &
	amixer set Master 100% &
)

