// Enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);


// Disable urlbar topsites suggestion
user_pref("browser.urlbar.suggest.topsites", false);


// Disable DNT as it is widely ignored and adds an unique characteristic to Firefox
// https://www.privacy-handbuch.de/handbuch_21i.htm
user_pref("privacy.donottrackheader.enabled",  false);


// Disable checking of downloads
// https://wiki.mozilla.org/Security/Features/Application_Reputation_Design_Doc
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);


// Display more hits in the Awesome Bar
user_pref("browser.urlbar.maxRichResults", 25);


// Disable mouse wheel zoom
user_pref("mousewheel.with_control.action", 0);
user_pref("mousewheel.with_meta.action", 0);


// Media opened in a new tab is played when the tab is visible
user_pref("media.block-play-until-visible", true);
user_pref("media.block-autoplay-until-in-foreground", true);


user_pref("media.videocontrols.picture-in-picture.enabled", "true");


user_pref("browser.altClickSave", true);

// Backspace to "Go back"
user_pref("browser.backspace_action", 0);


user_pref("browser.tabs.closeWindowWithLastTab", false);
