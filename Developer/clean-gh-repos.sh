#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset


for d in */ ; do
	if [ "$d" = "snippets/" ] || [ "$d" = "vimwiki/" ]; then
		continue
	fi

	action=💾
	pushd "$d" > /dev/null

	if [[ `git remote -v | grep github.com:heussd` ]]; then
		if [[ `git status --porcelain` ]]; then
			action=💾
		else
			git push
			action=❌
		fi
	fi
	popd > /dev/null
	echo "$action $d"

	if [ "$action" = "❌" ]; then
		rm -Rf "$d"
	fi
done

