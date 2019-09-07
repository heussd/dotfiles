

// http://kb.mozillazine.org/Browser.search.suggest.enabled
user_pref("browser.search.suggest.enabled",			false);
// Disable "Show search suggestions in location bar results"
user_pref("browser.urlbar.suggest.searches", false);


// Disable mouse wheel zoom
user_pref("mousewheel.with_control.action", 0);
user_pref("mousewheel.with_meta.action", 0);

// Disable session restore, legend says that this saves quite some hard disk I/O
// https://forums.servethehome.com/index.php?threads/firefox-is-chewing-through-your-nand.11346/page-3
//user_pref("browser.sessionstore.max_tabs_undo", 0);
//user_pref("browser.sessionstore.max_windows_undo", 0);
//user_pref("browser.sessionstore.resume_from_crash", false);
//user_pref("browser.sessionstore.max_resumed_crashes", 0);
//user_pref("browser.sessionstore.restore_on_demand", false);


// Media opened in a new tab is played when the tab is visible
user_pref("media.block-play-until-visible", true);
user_pref("media.block-autoplay-until-in-foreground", true);

// Enable containers
//user_pref("privacy.userContext.enabled", true);

user_pref("browser.altClickSave", true);


// Taken from https://www.ghacks.net/2015/08/18/a-comprehensive-list-of-firefox-privacy-and-security-settings/

// 0410a: disable "Block dangerous and deceptive content" This setting is under Options>Security
// in FF47 and under this is was titled "Block reported web forgeries"
// this covers deceptive sites such as phishing and social engineering
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false); // (FF50+)
// 0410b: disable "Block dangerous downloads" This setting is under Options>Security
// in FF47 and under this was titled "Block reported attack sites"
// this covers malware and PUPs (potentially unwanted programs)
user_pref("browser.safebrowsing.downloads.enabled", false);
// disable "Warn me about unwanted and uncommon software" Also under Options>Security (FF48+)
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
// yet more prefs added (FF49+)
user_pref("browser.safebrowsing.downloads.remote.block_dangerous", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous_host", false);
// 0410c: disable Google safebrowsing downloads, updates
user_pref("browser.safebrowsing.provider.google.updateURL", ""); // update google lists
user_pref("browser.safebrowsing.provider.google.gethashURL", ""); // list hash check
user_pref("browser.safebrowsing.provider.google4.updateURL", ""); // (FF50+)
user_pref("browser.safebrowsing.provider.google4.gethashURL", ""); // (FF50+)
