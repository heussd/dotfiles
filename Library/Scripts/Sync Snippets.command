#!/bin/bash

cd ~/projects/snippets
git pull

git add *
git commit -m "Unattended shell commit"
git push

killall Zazu
open -a Zazu
