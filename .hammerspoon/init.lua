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


require('f18')
require('utils')

--require('focussed-border')

require('apps-hotkeys')
require('logi-options-minus')

require('vim-cursor')
-- require('window-move-resize') -- Not stable enough, replaced by Easy Move+Resize app
require('window-management')
require('window-management-next-window-fix')

--require("global-mute")
require('menubar')

require('sleep-hooks')
--require('playground')
require('spoons')
