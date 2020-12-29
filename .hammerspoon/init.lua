hyper = {"cmd", "alt", "control", "shift"}


hs.hotkey.bind(hyper, "r", function()
  hs.reload()
  hs.alert.show("Config loaded")
end)

hs.hotkey.bind(hyper, "E", function()
    hs.toggleConsole()
end)


require('apps')
require('window-management')