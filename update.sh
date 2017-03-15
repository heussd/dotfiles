#!/bin/sh

git fetch --all
git reset --hard origin/master
git submodule update --init --remote _externals/

source "`uname -s`.md"
stow -v --dir=$(pwd) --target=$HOME --ignore=.DS_Store [^_]*/
