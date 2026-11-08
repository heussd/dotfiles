scrub:
	find ./ -type d \( \
		-name '.venv' -o \
		-name 'venv' -o \
		-name '.npm' -o \
		-name '.cache' -o \
		-name 'node_modules' \
		\) -depth -print -exec rm -Rf {} \;

podman-update-and-run:
	@failed=""; \
	for dir in */; do \
	    dir=$${dir%/}; \
	    ls "$$dir"/compose.y*ml "$$dir"/docker-compose.y*ml 2>/dev/null | grep -q . || continue; \
	    echo "== Updating $$dir"; \
	    (cd "$$dir" && podman compose pull && podman compose up -d --remove-orphans) \
	        || failed="$$failed $$dir"; \
	done; \
	if [ -n "$$failed" ]; then echo "== Failed:$$failed"; exit 1; fi
