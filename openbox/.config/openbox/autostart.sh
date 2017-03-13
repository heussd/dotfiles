#!/bin/bash
# Load wallpaper
eval `cat ~/.fehbg` &

tilda &
#conky &
gpg-agent --daemon &
#psi &

# Load user keycodes
if [[ -e ~/.Xmodmap.$HOSTNAME ]]; then
	xmodmap ~/.Xmodmap.$HOSTNAME &
fi

#Tune terminal emulation
#xrdb -load ~/.Xdefaults

#xcompmgr -cC &
xscreensaver -no-splash &

urxvtd -f -q -o &

#sleep 3

(sleep 2; trayer --edge top --align right --widthtype request --heighttype request --transparent true --alpha 255 --SetPartialStrut false --SetDockType false) &

#(sleep 2; ipager) &
#(sleep 2; pypanel) &
tint2 &


if [ $HOSTNAME == "smithfield" ]; then
	#thunderbird &
fi


# Is an external screen attached?
if [[ `xrandr -q | grep 'VGA connected' ` ]]; then
	enableVGA 1024 768 &	
	
	# Reinit wallpaper
	eval `cat ~/.fehbg` &
fi

beagled &
