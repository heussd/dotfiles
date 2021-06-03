require('utils')

function sleepWatch(eventType)
    if (eventType == hs.caffeinate.watcher.screensDidUnlock) then
        print("Wake-up detected")
		hlspeak('bell')
        hs.execute("make -f $HOME/Makefile pull", true)
        hlspeak('hello')
    end
end

sleepWatcher = hs.caffeinate.watcher.new(sleepWatch)
sleepWatcher:start()

