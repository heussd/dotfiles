// Show bookmarks toolbar only in new tab pages
user_pref("browser.toolbars.bookmarks.visibility", "newtab");


// Cookie Banner Rejection
// https://github.com/mozilla/cookie-banner-rules-list
user_pref("cookiebanners.service.mode", 1);
user_pref("cookiebanners.bannerClicking.enabled", true);
user_pref("cookiebanners.cookieInjector.enabled", true);


// Do not automatically fill sign-in forms with known usernames and passwords
// This avoids hidden credentail steals as demonstrated here:
// https://senglehardt.com/demo/no_boundaries/loginmanager/
user_pref("signon.autofillForms", false);



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


// ##########################################################################################################
// https://github.com/pyllyukko/user.js/blob/master/user.js
// ##########################################################################################################

// PREF: Disable collection/sending of the health report (healthreport.sqlite*)
// https://support.mozilla.org/en-US/kb/firefox-health-report-understand-your-browser-perf
// https://gecko.readthedocs.org/en/latest/toolkit/components/telemetry/telemetry/preferences.html
user_pref("datareporting.healthreport.uploadEnabled",		false);
user_pref("datareporting.healthreport.service.enabled",		false);
user_pref("datareporting.policy.dataSubmissionEnabled",		false);
// "Allow Firefox to make personalized extension recommendations"
user_pref("browser.discovery.enabled",				false);

// PREF: Disable Shield/Heartbeat/Normandy (Mozilla user rating telemetry)
// https://wiki.mozilla.org/Advocacy/heartbeat
// https://trac.torproject.org/projects/tor/ticket/19047
// https://trac.torproject.org/projects/tor/ticket/18738
// https://wiki.mozilla.org/Firefox/Shield
// https://github.com/mozilla/normandy
// https://support.mozilla.org/en-US/kb/shield
// https://bugzilla.mozilla.org/show_bug.cgi?id=1370801
// https://wiki.mozilla.org/Firefox/Normandy/PreferenceRollout
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("extensions.shield-recipe-client.enabled",		false);
user_pref("app.shield.optoutstudies.enabled",			false);


// PREF: Do not check if Firefox is the default browser
user_pref("browser.shell.checkDefaultBrowser",			false);

// ##########################################################################################################

# Mozilla User Preferences
# kuketz-blog.de | Firefox-Kompendium | 10.11.2021 | Firefox 94.0.1
# Download: https://www.kuketz-blog.de/firefox-aboutconfig-user-js-firefox-kompendium-teil10/

#############
## PRIVACY ##
#############

## Disable Domain Guessing
user_pref("browser.fixup.alternate.enabled", false);

## Disable Normandy/Shield (FF60+)
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);

## Disable Activity Stream (AS)
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.system.topsites", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);

## Disable PingCentre Telemetry
user_pref("browser.ping-centre.telemetry", false);

## Disable NewTabPage
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);

## Disable Safe Browsing
# Disable binaries NOT in local lists being checked by Google (real-time checking)
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
# Disable "Block dangerous downloads" (under Options>Privacy & Security)
user_pref("browser.safebrowsing.downloads.enabled", false);
# This covers deceptive sites such as phishing and social engineering
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
# Disable "Warn me about unwanted and uncommon software" (under Options>Privacy & Security)
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous_host", false);
# Disable Mozilla's blocklist for known Flash tracking/fingerprinting
user_pref("browser.safebrowsing.blockedURIs.enabled", false);
# Disable reporting URLs
user_pref("browser.safebrowsing.provider.google.reportURL", "");
user_pref("browser.safebrowsing.reportPhishURL", "");
user_pref("browser.safebrowsing.provider.google4.reportURL", "");
user_pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", "");
# Disable data sharing (FF58+)
user_pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false);
user_pref("browser.safebrowsing.provider.google4.dataSharingURL", "");

## Disable location bar LIVE search suggestions
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);

## Disable Slow Startup Notifications and Telemetry
user_pref("browser.slowStartup.notificationDisabled", true);
user_pref("browser.slowStartup.maxSamples", 0);
user_pref("browser.slowStartup.samples", 0);

## Disable sending of crash reports (FF44+)
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);

## Disable Health Report
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

## Disable Extension Metadata updating to addons.mozilla.org
user_pref("extensions.getAddons.cache.enabled", false);

## Disable Telemetry
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.unified", false);

##############
## SECURITY ##
##############

## Enforce Punycode for Internationalized Domain Names to eliminate possible spoofing
user_pref("network.IDN_show_punycode", true);

## Display all parts of the URL in the location bar eg. http(s)://
user_pref("browser.urlbar.trimURLs", false);

## Display "insecure" icon (FF59+) and "Not Secure" text (FF60+) on HTTP sites
user_pref("security.insecure_connection_icon.enabled", true);
user_pref("security.insecure_connection_icon.pbmode.enabled", true);
user_pref("security.insecure_connection_text.enabled", true);
user_pref("security.insecure_connection_text.pbmode.enabled", true);
