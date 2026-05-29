#!/bin/bash
set -o errexit
set -o nounset

DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
	DRY_RUN=true
	echo "Running in dry-run mode — no directories will be deleted."
fi

for d in */ ; do
	if [ "$d" = "snippets/" ] || [ "$d" = "awesome-github-workflows/" ] || [ "$d" = "vimwiki/" ]; then
		continue
	fi

	# Skip non-git directories
	if [ ! -d "$d/.git" ]; then
		echo "⏭️  $d (not a git repo, skipping)"
		continue
	fi

	action=💾
	pushd "$d" > /dev/null

	if [[ -n "$(git remote 2>/dev/null)" ]]; then
		local_changes=$(git status --porcelain)

		# Check for unpushed commits only if an upstream tracking branch is configured.
		# If no upstream is set, treat as dirty (keep).
		if git rev-parse --abbrev-ref @{u} &>/dev/null; then
			unpushed=$(git rev-list @{u}..HEAD)
		else
			unpushed="no-upstream"
		fi

		if [[ -n "$local_changes" || -n "$unpushed" ]]; then
			action=💾
		else
			action=❌
		fi
	fi

	popd > /dev/null
	echo "$action $d"

	if [ "$action" = "❌" ]; then
		if [ "$DRY_RUN" = true ]; then
			echo "  [dry-run] would delete $d"
		else
			rm -Rf "$d"
		fi
	fi
done

