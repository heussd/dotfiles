require('steps')
require('utils')


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

