SHELL         	 := bash
.SHELLFLAGS   	 := -eu -o pipefail -c
MAKEFLAGS     	 += --warn-undefined-variables
MAKEFLAGS     	 += --no-builtin-rules
MAKEFLAGS	+= -s
OS_NAME       	 := $(shell uname -s | tr A-Z a-z)


git-over-ssh: ## Configure git to prefer SSH
	@ln -s git-over-ssh git-over-ssh-enabled


