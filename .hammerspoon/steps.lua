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

function call_setup()
    hs.alert("CALL SETUP")

    local win = hs.window.focusedWindow()
    local f = win:frame()
	local screen = win:screen()
    local max = screen:frame()

	f.x = max.x + (max.w*0.7)
	f.y = max.y + (max.h*0)
	f.w = max.w*0.30
	f.h = max.h*1
	win:setFrame(f)

end
