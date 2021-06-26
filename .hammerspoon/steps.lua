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
    hlspeak('bell')

    print("Current WIFI is "..hs.wifi.currentNetwork())
    if (not hs.wifi.currentNetwork()) then
        hs.timer.doAfter(3, do_pull)
    else
        do_pull()
    end
end