hyper = {"cmd", "alt", "control", "shift"}


hs.hotkey.bind(hyper, "r", function()
  hs.reload()
  hs.alert.show("Config loaded")
end)

hs.hotkey.bind(hyper, "E", function()
    hs.toggleConsole()
end)



hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.preferencesDarkMode(true)
hs.accessibilityState(true) -- show System Preferences if Accessibility is not enabled for Hammerspoon
hs.dockIcon(false)
hs.menuIcon(false)
hs.consoleOnTop(false)

require('apps')
require('window-move-resize')
require('window-management')
require('spoon-install')