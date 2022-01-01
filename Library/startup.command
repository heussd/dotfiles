#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset


launchIfInstalled() {
	osascript -e "id of application \"$1\"" 2>/dev/null && \
		open --background -a "$1" || return 0
	
}


launchIfInstalled "Hammerspoon.app"

launchIfInstalled "Dropbox.app"
launchIfInstalled "Maestral.app"

launchIfInstalled "Dozer.app"
launchIfInstalled "Tiles.app"
launchIfInstalled "Maccy.app"
launchIfInstalled "Easy Move+Resize.app"
launchIfInstalled "Next Meeting.app"

launchIfInstalled "Multipass.app"
launchIfInstalled "Docker.app"

make sync


killall Terminal
