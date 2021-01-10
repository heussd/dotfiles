
--hs.loadSpoon("global-mute-spoon/GlobalMute")
globalmute = require('global-mute-spoon/GlobalMute')

globalmute:init()
globalmute:configure({
  enforce_desired_state = true
})

globalmute:mute()

hyper:bind({}, 'ö', nil, function()
  globalmute:toggle()
  
  if (globalmute.muted) then
    hl2play("off1")
  else
    hl2play("on1")
  end
end)