#!/bin/sh

STOW_IGNORE="--ignore=.DS_Store --ignore=.git"
STOW_OPTS="--restow --override=. --verbose=2"

# Ignore Library-folder for non macOS systems
uname -s | grep -v Darwin > /dev/null && STOW_IGNORE="$STOW_IGNORE --ignore=Library"

stow $STOW_OPTS --dir=$(pwd) --target=$HOME $STOW_IGNORE $*
