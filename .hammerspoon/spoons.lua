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