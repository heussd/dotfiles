#!/bin/sh
# CPU usage as integer percent, rounded.

export LC_ALL=C

out() {
  printf "%02d\n" "${1:-0}"
  exit 0
}

case "$(uname -s 2>/dev/null)" in
Darwin)
  # macOS: the first top sample is a since-boot average, so take two
  # samples 1s apart and use the last one. Usage = 100 - idle.
  top -l 2 -n 0 -s 1 2>/dev/null | awk '
    /^CPU usage:/ {
      for (i = 1; i <= NF; i++) if ($i ~ /^idle/) { idle = $(i - 1) }
      gsub(/[%,]/, "", idle)
      have = (idle != "")
    }
    END {
      if (!have) { print "00"; exit }
      used = 100 - idle
      if (used < 0) used = 0
      if (used > 100) used = 100
      printf "%02.0f\n", used
    }'
  ;;
Linux)
  # Linux: two /proc/stat samples, then compute usage delta.
  # Fields: user nice system idle iowait irq softirq steal (guest is
  # already counted in user/nice). Missing fields on old kernels default to 0.
  [ -r /proc/stat ] || out 0

  sample() {
    read -r _ u n s i w q sq st _ </proc/stat || return 1
    idle=$((i + ${w:-0}))
    total=$((u + n + s + i + ${w:-0} + ${q:-0} + ${sq:-0} + ${st:-0}))
  }

  sample || out 0
  t1=$total id1=$idle
  sleep 1
  sample || out 0

  dt=$((total - t1))
  did=$((idle - id1))
  [ "$dt" -gt 0 ] || out 0

  # Round to nearest integer.
  used=$(((200 * (dt - did) + dt) / (2 * dt)))
  [ "$used" -lt 0 ] && used=0
  [ "$used" -gt 100 ] && used=100
  out "$used"
  ;;
*)
  out 0
  ;;
esac
