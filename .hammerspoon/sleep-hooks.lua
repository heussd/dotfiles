require('utils')


function pre_lock()
    hs.execute("killall newsboat", true)
    hs.execute("make -f $HOME/Makefile push", true)
    hlspeak('doop')
end

function do_pull()
    hs.execute("make -f $HOME/Makefile pull", true)
    hlspeak('hello')
end

function post_lock()
    device = hs.audiodevice.defaultOutputDevice()
    device:setOutputVolume(20)

    hlspeak('bell')

    print("Current WIFI is "..hs.wifi.currentNetwork())
    if (not hs.wifi.currentNetwork()) then
        hs.timer.doAfter(3, do_pull)
    else
        do_pull()
    end
end

function sleepWatch(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidLock) then
        print("Screen lock detected")
        pre_lock()
    end

    if (eventType == hs.caffeinate.watcher.screensDidUnlock) then
        print("Wake-up detected")
        post_lock()
    end
end

sleepWatcher = hs.caffeinate.watcher.new(sleepWatch)
sleepWatcher:start()




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