#!/bin/sh
# CPU usage as integer percent, rounded.

os="$(uname -s 2>/dev/null)"

if [ "$os" = "Darwin" ]; then
  # macOS: sum user + system percentages from top output.
  top -l 1 | awk '/^CPU usage:/ {
    user = $3
    sys = $5
    gsub("%", "", user)
    gsub("%", "", sys)
    gsub(",", ".", user)
    gsub(",", ".", sys)
    printf "%02.0f\n", (user + 0) + (sys + 0)
    found = 1
    exit
  }
  END {
    if (!found) printf "%02d\n", 0
  }'
elif [ "$os" = "Linux" ]; then
  # Linux KISS: two /proc/stat samples, then compute usage delta.
  read -r _ u1 n1 s1 i1 w1 irq1 sirq1 st1 _ < /proc/stat || {
    printf "%02d\n" 0
    exit 0
  }

  t1=$((u1 + n1 + s1 + i1 + w1 + irq1 + sirq1 + st1))
  id1=$((i1 + w1))

  sleep 1

  read -r _ u2 n2 s2 i2 w2 irq2 sirq2 st2 _ < /proc/stat || {
    printf "%02d\n" 0
    exit 0
  }

  t2=$((u2 + n2 + s2 + i2 + w2 + irq2 + sirq2 + st2))
  id2=$((i2 + w2))

  dt=$((t2 - t1))
  did=$((id2 - id1))

  if [ "$dt" -gt 0 ]; then
    used=$(((dt - did) * 100 / dt))
    if [ "$used" -lt 0 ]; then
      used=0
    fi
    if [ "$used" -gt 100 ]; then
      used=100
    fi
    printf "%02d\n" "$used"
  else
    printf "%02d\n" 0
  fi
else
  printf "%02d\n" 0
fi
