settings: 
	mkdir -p "$$HOME/Library/Application Support/Code/User/"
	@echo "{}" > "$$HOME/Library/Application Support/Code/User/settings.json"
	
	mkdir -p $(HOME)/Library/Application\ Support/Code/User
	touch $(HOME)/Library/Application\ Support/Code/User/settings.json
	@jq -s add $(HOME)/Library/Application\ Support/Code/User/settings.json settings.json > tmp; mv tmp $(HOME)/Library/Application\ Support/Code/User/settings.json
	mkdir -p $(HOME)/Library/Application\ Support/Cursor/User
	touch $(HOME)/Library/Application\ Support/Cursor/User/settings.json
	@jq -s add $(HOME)/Library/Application\ Support/Cursor/User/settings.json settings.json > tmp; mv tmp $(HOME)/Library/Application\ Support/Cursor/User/settings.json

