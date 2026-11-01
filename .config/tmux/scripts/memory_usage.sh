#!/bin/sh
# Memory usage as integer percent, rounded.

export LC_ALL=C

case "$(uname -s 2>/dev/null)" in
Darwin)
  # macOS: memory pressure, i.e. 100 - system-wide free percentage.
  # kern.memorystatus_level is the value memory_pressure prints; fall back
  # to parsing memory_pressure if the sysctl is unavailable.
  free=$(sysctl -n kern.memorystatus_level 2>/dev/null)
  case "$free" in
  '' | *[!0-9]*)
    free=$(memory_pressure 2>/dev/null |
      awk '/free percentage:/ { v = $NF; gsub(/%/, "", v); print v + 0; exit }')
    ;;
  esac
  case "$free" in
  '' | *[!0-9]*) printf "00\n" ;;
  *)
    used=$((100 - free))
    [ "$used" -lt 0 ] && used=0
    [ "$used" -gt 100 ] && used=100
    printf "%02d\n" "$used"
    ;;
  esac
  ;;
Linux)
  # Linux: (MemTotal - MemAvailable) / MemTotal from /proc/meminfo.
  # Kernels < 3.14 lack MemAvailable; approximate it from free + caches.
  awk '
    $1 == "MemTotal:"     { total = $2 }
    $1 == "MemAvailable:" { avail = $2; have_avail = 1 }
    $1 == "MemFree:"      { free = $2 }
    $1 == "Buffers:"      { buffers = $2 }
    $1 == "Cached:"       { cached = $2 }
    $1 == "SReclaimable:" { srecl = $2 }
    END {
      if (total <= 0) { print "00"; exit }
      if (!have_avail) avail = free + buffers + cached + srecl
      pct = (total - avail) / total * 100
      if (pct < 0) pct = 0
      if (pct > 100) pct = 100
      printf "%02.0f\n", pct
    }' /proc/meminfo 2>/dev/null || printf "00\n"
  ;;
*)
  printf "00\n"
  ;;
esac
