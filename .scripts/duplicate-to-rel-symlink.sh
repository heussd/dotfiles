#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

rdfind -makesymlinks true release


# https://unix.stackexchange.com/questions/100918/convert-absolute-symlink-to-relative-symlink-with-simple-linux-command#answer-513357
find . -type l | while read l; do
    target="$(realpath "$l")"
    ln -fs "$(realpath --relative-to="$(dirname "$(realpath -s "$l")")" "$target")" "$l"
done
