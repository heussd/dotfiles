#!/bin/bash

cd "$TH_PROJECTS_FOLDER/snippets" || exit 1
git pull

git add *
git commit -m "Unattended shell commit"
git push

killall Zazu
open -a Zazu
