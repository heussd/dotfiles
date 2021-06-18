require('utils')

local function pull()
    hs.execute("make -f $HOME/Makefile pull", true)
    hlspeak('hello')
end

function sleepWatch(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidUnlock) then
        print("Wake-up detected")
		hlspeak('bell')
        hs.timer.doAfter(1, pull)
    end
end

sleepWatcher = hs.caffeinate.watcher.new(sleepWatch)
sleepWatcher:start()

