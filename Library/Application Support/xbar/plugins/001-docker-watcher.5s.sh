#!/bin/bash
set -o errexit
set -o nounset

backendCPU="$(ps -p "$(pgrep com.docker.backend)" -o %cpu | tail -n 1 | awk -F'.' '{print $1}' )"

menubar=""
if [[ $backendCPU -ge 90 ]]; then
  menubar="Docker goes crazy | color=red size=6"
fi

echo "$menubar"
echo "---"
echo "Restart Docker | shell=\"~/Library/Application Support/xbar/plugins/helper/restart-docker.sh\" "
