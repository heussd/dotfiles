#!/bin/sh
# Memory pressure as integer percent, rounded.
# macOS reports free percentage; pressure is the inverse.
memory_pressure 2>/dev/null | awk '
  /System-wide memory free percentage:/ {
    free = $5
    gsub("%", "", free)
    free += 0
    pressure = 100 - free
    if (pressure < 0) pressure = 0
    if (pressure > 100) pressure = 100
    printf "%02.0f\n", pressure
    printed = 1
    exit
  }
  END {
    if (!printed) printf "%02d\n", 0
  }
'
