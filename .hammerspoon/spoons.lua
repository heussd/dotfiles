-- https://zzamboni.org/post/my-hammerspoon-configuration-with-commentary/
hs.loadSpoon("SpoonInstall")
Install=spoon.SpoonInstall

Install:asyncUpdateAllRepos()


Install:andUse("ReloadConfiguration", {
  start = true
})


Install:andUse("FadeLogo", {
  config = {
    run_time = 3.0,
  },
  start = true
})


local SkyRocket = hs.loadSpoon("SkyRocket")

sky = SkyRocket:new({
  opacity = 0.3,
  moveModifiers = {'cmd'},
  moveMouseButton = 'left',
  resizeModifiers = {'cmd', 'shift'},
  resizeMouseButton = 'right',
})