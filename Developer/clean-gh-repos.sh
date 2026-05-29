#!/bin/bash
set -o errexit
set -o nounset

SKIP_DIRS=("snippets/" "awesome-github-workflows/" "vimwiki/")

is_skipped() {
	local dir=$1
	for skip in "${SKIP_DIRS[@]}"; do
		[[ "$dir" == "$skip" ]] && return 0
	done
	return 1
}

has_remote() {
	[[ -n "$(git remote 2>/dev/null)" ]]
}

has_upstream() {
	git rev-parse --abbrev-ref '@{u}' &>/dev/null
}

has_uncommitted_changes() {
	[[ -n "$(git status --porcelain)" ]]
}

has_unpushed_commits() {
	[[ -n "$(git rev-list '@{u}..HEAD')" ]]
}

try_push() {
	local dir=$1
	if [[ "$DRY_RUN" == true ]]; then
		echo "  [dry-run] would push $dir" >&2
		return 1
	fi
	git push
}

delete_dir() {
	local dir=$1
	if [[ "$DRY_RUN" == true ]]; then
		echo "  [dry-run] would delete $dir"
	else
		rm -Rf "$dir"
	fi
}


DRY_RUN=false
if [[ "${1:-}" == "--dry-run" ]]; then
	DRY_RUN=true
	echo "Running in dry-run mode — no directories will be deleted."
fi

for d in */; do
	is_skipped "$d" && continue

	if [[ ! -d "$d/.git" ]]; then
		echo "⏭️  $d (not a git repo, skipping)"
		continue
	fi

	# cd into a subshell so the outer loop's working directory is never
	# corrupted if a git command fails under set -o errexit.
	action=$(cd "$d" && {
		! has_remote            && echo "🔌" && exit
		has_uncommitted_changes && echo "✏️" && exit
		! has_upstream          && echo "⬆️" && exit

		if has_unpushed_commits; then
			try_push "$d" && echo "❌" || echo "💾"
			exit
		fi

		echo "❌"
	})
	echo "$action $d"

	[[ "$action" == "❌" ]] && delete_dir "$d"
done
