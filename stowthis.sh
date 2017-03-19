#!/bin/sh

stow -R -v --dir=$(pwd) --target=$HOME --ignore=.DS_Store $*
