scrub:
	find ./ -type d \( \
		-name '.venv' -o \
		-name 'venv' -o \
		-name '.npm' -o \
		-name '.cache' -o \
		-name 'node_modules' \
		\) -depth -print -exec rm -Rf {} \;


git-clean-projects:
	mkdir -p "_DELETE_ME_"
	find ./ -type d -name ".git" | while read gitdir; do \
		repo=$$(dirname "$$gitdir"); \
		cd "$$repo"; \
		status=$$(git status --porcelain); \
		branch=$$(git rev-parse --abbrev-ref HEAD); \
		upstream=$$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null); \
		if [ -z "$$status" ] && [ -n "$$upstream" ]; then \
			ahead_behind=$$(git rev-list --left-right --count "$$branch...$$upstream"); \
			ahead=$$(echo $$ahead_behind | awk '{print $$1}'); \
			behind=$$(echo $$ahead_behind | awk '{print $$2}'); \
			if [ "$$ahead" = "0" ] && [ "$$behind" = "0" ]; then \
				echo "$$repo"; \
				cd .. ; \
				mv "$$repo" "_DELETE_ME_/"; \
			fi; \
		fi; \
		cd "$$HOME/Developer"; \
	done
