#!/bin/bash

# https://gist.github.com/webel/464f9c58b22979fa37d4d12eb6d4faae
layouts=('U.S.' 'German QWERTY')
ids=('0' '-1913')

# The keys we have to add for each layout
apple_keys=("AppleEnabledInputSources" "AppleInputSourceHistory" "AppleSelectedInputSources")

# Create the XML entries with defaults write
defaults -host "${USER}" write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID com.apple.keylayout.US

for key in "${apple_keys[@]}" ; do
	defaults -host "${USER}" delete com.apple.HIToolbox "$key";
done

for ((i=0 ; i<${#layouts[@]}; i++)) ; do
	for key in "${apple_keys[@]}" ; do
		defaults -host "${USER}" write com.apple.HIToolbox \
				"$key" \
				-array-add "<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>${ids[i]}</integer><key>KeyboardLayout Name</key><string>${layouts[i]}</string></dict>"
	done
done

