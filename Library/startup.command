#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

open --background -a "Maestral.app"
open --background -a "Dozer.app"
open --background -a "Tiles.app"
open --background -a "Maccy.app"
open --background -a "Hammerspoon.app"
open --background -a "Easy Move+Resize.app"
open --background -a "Docker.app"
open --background -a "Next Meeting.app"

make sync
