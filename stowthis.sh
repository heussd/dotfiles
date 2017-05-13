#!/bin/sh

STOW_DIR=$(dirname $(readlink -f $0)) || STOW_DIR=$(pwd)
STOW_OPTS="--restow --override=. --verbose=2"

STOW_IGNORE="--ignore=.DS_Store --ignore=.git"
# Ignore Library-folder for non macOS systems
uname -s | grep -v Darwin > /dev/null && STOW_IGNORE="$STOW_IGNORE --ignore=Library"

stow $STOW_OPTS --dir=$STOW_DIR --target=$HOME $STOW_IGNORE $*
