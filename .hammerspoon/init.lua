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


function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

function play(word)
  local file = os.getenv("HOME") .. "/projects/hl2/sound/npc/combine_soldier/vo/" .. word .. ".wav"
  if file_exists(file) then
    local sound = hs.sound.getByFile(file)
    sound:play()
  end
end



hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(true)
hs.preferencesDarkMode(true)
hs.accessibilityState(true) -- show System Preferences if Accessibility is not enabled for Hammerspoon
hs.dockIcon(false)
hs.menuIcon(false)
hs.consoleOnTop(false)



--hs.loadSpoon("global-mute-spoon/GlobalMute")
globalmute = require('global-mute-spoon/GlobalMute')

globalmute:bindHotkeys({
  unmute = {{'ctrl-command-option'}, "u"},
  mute   = {{'ctrl-command-option'}, "m"},
  toggle = {{'ctrl-command-option'}, "space"}
})
globalmute:init()

hyper:bind({}, 'ö', nil, function()
  hs.alert("HAI")
  globalmute:toggle()
  play("off1")
end)



require('apps')
require('vim')
require('window-move-resize')
require('window-management')
require('menubar')
require('playground')
require('spoons')