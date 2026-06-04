#!/bin/sh
# CPU load as integer percent (user + system), rounded.
top -l 1 | awk '/^CPU usage:/ {
  user = $3
  sys = $5
  gsub("%", "", user)
  gsub("%", "", sys)
  gsub(",", ".", user)
  gsub(",", ".", sys)
  printf "%02.0f\n", (user + 0) + (sys + 0)
  exit
}'
