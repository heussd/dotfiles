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


hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.preferencesDarkMode(true)
hs.accessibilityState(true) -- show System Preferences if Accessibility is not enabled for Hammerspoon
hs.dockIcon(false)
hs.menuIcon(false)
hs.consoleOnTop(false)


require('utils')

require('keys')
require('vim')
-- require('window-move-resize') -- Not stable enough, replaced by Easy Move+Resize app
-- require('window-management') -- Not working properly, disabled

require("global-mute")
require('menubar')

require('sleepwatcher')
require('playground')
require('spoons')