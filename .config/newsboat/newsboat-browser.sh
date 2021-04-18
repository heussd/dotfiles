#!/bin/sh

if [ -e /Applications/ ]; then
    open --background "$@" 2>/dev/null &
    exit 0
fi

if [ -e /usr/bin/firefox ]; then
    /usr/bin/firefox "$@" 2>/dev/null &
    exit 0
fi

exit 1
