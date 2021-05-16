#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

osascript -e 'quit app "Docker"'
open -a Docker