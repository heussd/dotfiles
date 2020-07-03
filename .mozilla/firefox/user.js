// ##########################################################
//   Timm's prefered Firefox Settings
// Inspired by https://github.com/ghacksuserjs/ghacks-user.js
// ##########################################################



// ##########################################################
//   UI / UX optimisations
// ##########################################################

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


// ##########################################################
//   Privacy Settings
// ##########################################################

// Enable Containers
user_pref("privacy.userContext.enabled", true);

user_pref("privacy.donottrackheader.enabled", true);

// http://kb.mozillazine.org/Browser.search.suggest.enabled
user_pref("browser.search.suggest.enabled", false);
// Disable "Show search suggestions in location bar results"
user_pref("browser.urlbar.suggest.searches", false);

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



# Mozilla User Preferences
# kuketz-blog.de | Firefox-Kompendium | 06.12.2018
# Download: https://www.kuketz-blog.de/firefox-aboutconfig-user-js-firefox-kompendium-teil10/

#############
## PRIVACY ##
#############

## Disable Domain Guessing
user_pref("browser.fixup.alternate.enabled", false);

## Disable Normandy/Shield (FF60+)
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("app.shield.optoutstudies.enabled", false);

## Disable "Savant" Shield study (FF61+) 
user_pref("shield.savant.enabled", false);

## Disable "Snippets" (Mozilla content shown on about:home screen)
user_pref("browser.aboutHomeSnippets.updateUrl", "");

## Disable Activity Stream (AS)
# Disable AS Telemetry
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry.ping.endpoint", "");
# Disable AS Snippets
user_pref("browser.newtabpage.activity-stream.disableSnippets", true);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
## Disable AS in new Tabs
user_pref("browser.library.activity-stream.enabled", false);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.enabled", false);
user_pref("browser.newtabpage.enabled", false);
user_pref("browser.newtab.preload ", false);

## Disable PingCentre Telemetry
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.ping-centre.production.endpoint", "");
user_pref("browser.ping-centre.staging.endpoint", "");

## Disable Onboarding (FF55+) | Onboarding uses Google Analytics and leaks resource://URIs
user_pref("browser.onboarding.enabled", false);

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

## Disable Mozilla permission to silently opt you into tests 
user_pref("network.allow-experiments", false);

## Disable Telemetry
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); 
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); 
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false); // 
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); 
user_pref("toolkit.telemetry.hybridContent.enabled", false);

## Disable experiments
user_pref("experiments.enabled", false);
user_pref("experiments.manifest.uri", "");
user_pref("experiments.supported", false);
user_pref("experiments.activeExperiment", false);

## Disable uploading to the Screenshots server
user_pref("extensions.screenshots.upload-disabled", true);

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



// Overwrite newtab page setting to have a black background on new tabs ¯\_(ツ)_/¯
user_pref("browser.newtabpage.enabled", true);


// Enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);


// Disable urlbar topsites suggestion
user_pref("browser.urlbar.suggest.topsites", false);