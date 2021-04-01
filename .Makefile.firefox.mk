
firefox: ## Symlinks Firefox user config files to all Firefox profiles
	@for profile in $(FIREFOX_PROFILES_LOCATION)/*/; do \
		echo "$$profile"; \
		ln -sFf $$HOME/.mozilla/firefox/user.js "$$profile"; \
		mkdir -p "$$profile/chrome"; \
		ln -sFf $$HOME/.mozilla/firefox/chrome/userChrome.css "$$profile/chrome/"; \
	done
.PHONY: firefox


firefox-policies: firefox-policies-$(OS_NAME) ## Install Firefox policies
	@:
firefox-policies-darwin: /Applications/Firefox.app/Contents/Resources/distribution/policies.json
firefox-policies-linux:  /etc/firefox/policies/policies.json

/Applications/Firefox.app/Contents/Resources/distribution/policies.json: $(HOME)/.mozilla/firefox/policies.json
	@printf "\e[1;34m[Home Makefile]\e[0m Installing Firefox policies to $@...\n"
	@mkdir -p /Applications/Firefox.app/Contents/Resources/distribution/
	@cp $$HOME/.mozilla/firefox/policies.json /Applications/Firefox.app/Contents/Resources/distribution/policies.json
/etc/firefox/policies/policies.json: $(HOME)/.mozilla/firefox/policies.json
	@printf "\e[1;34m[Home Makefile]\e[0m Installing Firefox policies to $@...\n"
	@sudo mkdir -p /etc/firefox/policies/
	@sudo cp $$HOME/.mozilla/firefox/policies.json /etc/firefox/policies/policies.json

.PHONY: firefox-policies firefox-policies-darwin firefox-policies-linux
