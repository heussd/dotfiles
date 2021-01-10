
--hs.loadSpoon("global-mute-spoon/GlobalMute")
globalmute = require('global-mute-spoon/GlobalMute')

globalmute:init()
globalmute:configure({
  enforce_desired_state = true
})

globalmute:mute()
globalmute.mb:removeFromMenuBar()


function toggleMic()
  globalmute:toggle()

  if (globalmute.muted) then
    hl2play("off1")
  else
    hl2play("on1")
  end
  generate_menu()
end

hyper:bind({}, 'ö', nil, toggleMic)