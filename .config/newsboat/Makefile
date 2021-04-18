.PHONY: highlights-autogen
highlights-autogen:
	@echo > highlights-autogen
	@grep "^-" "$$TH_PROJECTS_FOLDER/vimwiki/Topics.md" | cut -d- -f2 | tr '[:upper:]' '[:lower:]' | awk '{$$1=$$1};1' | awk '{print "highlight-article \"title =~ \\\""$$0"\\\"\" red default bold"}' >> highlights-autogen
	@grep "^-" "$$TH_PROJECTS_FOLDER/vimwiki/Topics.md" | cut -d- -f2 | tr '[:upper:]' '[:lower:]' | awk '{$$1=$$1};1' | awk '{print "highlight-article \"content =~ \\\""$$0"\\\"\" red default bold"}' >> highlights-autogen
