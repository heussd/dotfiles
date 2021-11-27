SHELL   := bash
.SHELLFLAGS := -eu -o pipefail -c  
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

.PHONY: all $(MAKECMDGOALS)

all: vscode

vscode:
	@code --install-extension coenraads.bracket-pair-colorizer-2
	@code --install-extension dakara.transformer
	@code --install-extension esbenp.prettier-vscode
	@code --install-extension formulahendry.auto-close-tag
	@code --install-extension formulahendry.auto-rename-tag
	@code --install-extension streetsidesoftware.code-spell-checker

	@code --install-extension ms-azuretools.vscode-docker
	
	@code --install-extension vomout.latex-syntax
	
	@code --install-extension redhat.vscode-xml
	@code --install-extension dotjoshjohnson.xml
	@code --install-extension deltaxml.xslt-xpath
	