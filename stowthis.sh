#!/bin/sh

STOW_IGNORE="--ignore=.DS_Store"

# Ignore Library-folder for non macOS systems
uname -s | grep -v Darwin > /dev/null && STOW_IGNORE="$STOW_IGNORE --ignore=Library"

stow --restow --verbose=2 --dir=$(pwd) --target=$HOME $STOW_IGNORE $*
