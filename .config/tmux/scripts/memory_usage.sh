#!/bin/sh
# Memory usage as integer percent, rounded.

os="$(uname -s 2>/dev/null)"

if [ "$os" = "Darwin" ]; then
  # macOS memory_pressure reports free percentage, so invert it.
  memory_pressure 2>/dev/null | awk '
    /System-wide memory free percentage:/ {
      free = $5
      gsub("%", "", free)
      free += 0
      used = 100 - free
      if (used < 0) used = 0
      if (used > 100) used = 100
      printf "%02.0f\n", used
      found = 1
      exit
    }
    END {
      if (!found) printf "%02d\n", 0
    }
  '
elif [ "$os" = "Linux" ]; then
  # Linux: compute used/total from `free`.
  LC_ALL=C free -m | awk '
    /^Mem:/ {
      total = $2 + 0
      used = $3 + 0
      if (total > 0) {
        pct = (used / total) * 100
      } else {
        pct = 0
      }
      if (pct < 0) pct = 0
      if (pct > 100) pct = 100
      printf "%02.0f\n", pct
      found = 1
      exit
    }
    END {
      if (!found) printf "%02d\n", 0
    }
  '
else
  printf "%02d\n" 0
fi
