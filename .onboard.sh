#!/usr/bin/env bash

# Taken from https://stackoverflow.com/questions/394230/how-to-detect-the-os-from-a-bash-script/18434831#answer-18434831
case "$OSTYPE" in
  solaris*) echo "SOLARIS" ;;
  darwin*)
    xcode-select --install;; 
  linux*)
    sudo apt install -y curl make git;;
  bsd*)     echo "BSD" ;;
  msys*)    echo "WINDOWS" ;;
  *)        echo "unknown: $OSTYPE" ;;
esac


curl -fsSL https://raw.githubusercontent.com/heussd/dotfiles/master/Makefile | make -f -
