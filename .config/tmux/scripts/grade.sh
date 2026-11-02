#!/bin/sh
# Wrap a usage script's percent in a tmux colour grade.
#   grade.sh cpu|memory  ->  #[fg=...]NN

dir=$(dirname "$0")
v=$("$dir/${1}_usage.sh")

n=$(printf '%s' "$v" | sed 's/^0*//')
n=${n:-0}

if   [ "$n" -ge 90 ]; then c='#ef476f' # vivid pink-red
elif [ "$n" -ge 75 ]; then c='#ffb145' # bright amber
else                       c='default' # terminal foreground
fi

printf '#[fg=%s]%s\n' "$c" "$v"
