require('utils')

function reduce_sound_level()
    if (hs.host.localizedName() ~= "kabylake") then
        device = hs.audiodevice.defaultOutputDevice()
        device:setOutputVolume(5)
    end
end


function pre_lock()
    print("Executing pre lock...")
    hs.execute("killall newsboat")
    hs.execute("~/.local/bin/gita push &", false)
    --reduce_sound_level()

    --if (hs.wifi.currentNetwork() == "Wachtberg") then
    --    hs.execute("make -f $HOME/Makefile push &", true)
    --end

    hlspeak('doop')
end


function post_lock()
    print("Executing post lock...")
    hlspeak('bell')
    hs.execute("~/.local/bin/gita pull &", false)
    hlspeak('hello')

    --print("Current WIFI is "..hs.wifi.currentNetwork())
    --if (hs.wifi.currentNetwork() == "Wachtberg") then
    --    hs.execute("make -f $HOME/Makefile pull &", true)
    --    hlspeak('hello')
    --end
end

function sleepWatch(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidLock) then
        print("Screen was locked")
        pre_lock()
    end

    if (eventType == hs.caffeinate.watcher.screensDidUnlock) then
        print("Screen was unlocked")
        --hs.timer.doAfter(3, post_lock
        post_lock()
    end
end

sleepWatcher = hs.caffeinate.watcher.new(sleepWatch):start()



hyper:bind({}, "q", nil, function()
    pre_lock()
    
    local message = "Going down for sleep..."
    hs.alert.show(message, 2)
    
    local duration = 2.5
    hs.timer.doAfter(duration, function()
        hs.alert(message .. " 3")
    end)
    hs.timer.doAfter(2*duration, function()
        hs.alert(message .. " 2")
    end)
    hs.timer.doAfter(3*duration, function()
        hs.alert(message .. " 1")
    end)
    hs.timer.doAfter(4*duration, function()
        hs.caffeinate.lockScreen()
        hs.caffeinate.systemSleep()
    end)
end)
