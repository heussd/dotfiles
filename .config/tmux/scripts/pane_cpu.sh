#!/bin/sh
# CPU% for processes in the focused tmux pane (macOS).
# Extracts digits from tty name.

tty_raw=$(tmux display-message -p '#{pane_tty}' 2>/dev/null)
[ -z "$tty_raw" ] && exit 0

# ttys002 → 002 | ptys001 → 001 | strip last 's' or 't' then take digits
ts=$(echo "$tty_raw" | grep -o '[0-9]\+$')
[ -z "$ts" ] && exit 0

ps -t "s${ts}" -o pcpu --no-headers 2>/dev/null \
  | awk '{c+=$1} END{v=(c<0?0:c);if(v>100)v=100;printf "%02.0f\n",v}' || echo "00"
