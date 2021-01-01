-- https://zzamboni.org/post/my-hammerspoon-configuration-with-commentary/
hs.loadSpoon("SpoonInstall")
Install=spoon.SpoonInstall

Install:asyncUpdateAllRepos()


Install:andUse("TimeMachineProgress", {
  start = true
})

Install:andUse("TextClipboardHistory", {
  config = {
    show_in_menubar = false,
    paste_on_select = true
  },
  hotkeys = {
    toggle_clipboard = { { "cmd", "shift" }, "v" } },
  start = true,
})

Install:andUse("KSheet", {
  hotkeys = {
    toggle = { hyper, "k" }
}})

Install:andUse("DeepLTranslate", {
  hotkeys = {
    translate = { hyper, "t" },
  }
})

Install:andUse("Caffeine", {
  start = true
})

Install:andUse("FadeLogo", {
  config = {
    run_time = 3.0,
  },
  start = true
})