// Global Privacy Control
user_pref("privacy.globalprivacycontrol.enabled", true);


// Disable Relay prompts for email fields
user_pref("signon.firefoxRelay.feature", "disabled");


// Hide adressbar in full screen mode
user_pref("browser.fullscreen.autohide", true);


user_pref("extensions.pocket.enabled", false);

// Show bookmarks toolbar only in new tab pages
user_pref("browser.toolbars.bookmarks.visibility", "newtab");


// Cookie Banner Rejection
// https://github.com/mozilla/cookie-banner-rules-list
user_pref("cookiebanners.service.mode", 1);
user_pref("cookiebanners.bannerClicking.enabled", true);
user_pref("cookiebanners.cookieInjector.enabled", true);


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
user_pref("browser.urlbar.maxRichResults", 20);


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


user_pref("dom.security.https_only_mode", true);

// Total Cookie Protection
// https://blog.mozilla.org/en/products/firefox/firefox-rolls-out-total-cookie-protection-by-default-to-all-users-worldwide/
user_pref("network.cookie.cookieBehavior", 5);



// Some basic privacy enhancements
// https://github.com/privacyint/website-guides/blob/master/guide-steps/en/firefox-adjusting-settings-enhance-your-online-privacy.md
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.firstparty.isolate", true);
user_pref("browser.send_pings", false);
user_pref("browser.send_pings.require_same_host", true);


// https://github.com/arkenfox/user.js
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.allowOverride", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// Disable PPA
// https://michael.kjorling.se/blog/2024/disabling-privacy-preserving-ad-measurement-in-firefox-128/
user_pref("dom.private-attribution.submission.enabled", false);

user_pref("signon.rememberSignons", false);

