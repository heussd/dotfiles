#!/bin/sh

if type "mpv" > /dev/null; then
	mpv "$@" &> /dev/null &
else
	echo "$@" | less 
fi

