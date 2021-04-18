#!/bin/sh

url="$1"
title="$2"
title=$(echo $title | sed -e 's/ (matches.*$//') 
tags="$3"
feed="$4"

file=$(date '+%Y-%m-%d')

cd "$TH_PROJECTS_FOLDER/vimwiki" || exit 1

echo "\n## $title \n
<$url>" >> ./$file.md


git add $file.md
git commit -m "$file.md (auto commit)" > /dev/null

exit 0
