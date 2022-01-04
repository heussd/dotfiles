print("Starting Hammerspoon...")

hyper = hs.hotkey.modal.new({}, nil)
hyper.pressed = function()
  hyper:enter()
end
hyper.released = function()
  hyper:exit()
end
hs.hotkey.bind({}, 'F18', hyper.pressed, hyper.released)


hyper:bind({}, 'r', nil, function()
  hs.reload()
end)


hs.autoLaunch(false)
hs.automaticallyCheckForUpdates(true)
hs.preferencesDarkMode(true)
hs.accessibilityState(true) -- show System Preferences if Accessibility is not enabled for Hammerspoon
hs.dockIcon(false)
hs.menuIcon(false)
hs.consoleOnTop(false)


-- Highlight current window
-- Taken from https://github.com/shuxiao9058/dothammerspoon/blob/52e53d665c577f33235d92cf17ee8c74c924d5a2/windowHighlight.lua

hs.window.highlight.ui.overlay=true
hs.window.highlight.ui.overlayColor = {0, 0, 0, 0.3}
hs.window.highlight.ui.isolateColor = {0, 0, 0, 0.9}
hs.window.highlight.ui.isolateColorInverted = {1,1,1,0.95}

hs.window.highlight.ui.frameWidth = 10
hs.window.highlight.ui.frameColor = {0,0,1,0.2}
hs.window.highlight.ui.frameColorInvert = {1,0.4,0,0.5}

hs.window.highlight.ui.flashDuration = 2
hs.window.highlight.ui.windowShownFlashColor = {0,1,0,0.8}
hs.window.highlight.ui.windowHiddenFlashColor = {1,0,0,0.8}
hs.window.highlight.ui.windowShownFlashColorInvert = {1,0,1,0.8}
hs.window.highlight.ui.windowHiddenFlashColorInvert = {0,1,1,0.8}



require('utils')

require('apps-hotkeys')
require('vim-cursor')
-- require('window-move-resize') -- Not stable enough, replaced by Easy Move+Resize app
require('window-management')

require("global-mute")
require('menubar')

require('sleep-hooks')
require('playground')
require('spoons')
