module.exports = {
    options: {
        hideIcon: true,
    },
    defaultBrowser: "Firefox",
    handlers: [
        {
            match: ["*.apple.com/*"],
            browser: "Safari"
        },
        {
            match: ["*.pwc.com/*", "*.pwc.de/*", "*.replicon.com/*","gitlab.com/*",
            	    "statics.teams.cdn.office.net/*"  // Teams link verification
            ],
            browser: "Google Chrome"
        },
        {
		match: ({ url }) => url.host.endsWith("azure.com"),
            	browser: "Google Chrome"
	},
        {
            match: finicky.matchHostnames([
            	    "cloudapp.azure.com",
            	    "*.microsoft.com",
            	    "microsoftonline.com",
            	    "sharepoint.com"
            ]),
            browser: "Google Chrome"
        },
        {
            match: finicky.matchHostnames(["accounts.google.com", "stream.meet.google.com", "mail.google.com", "drive.google.com", "calendar.google.com", "chat.google.com", "docs.google.com"]),
            browser: "Google Chrome"
        },
        {
            // Open Google Meet in app mode
            match: finicky.matchHostnames(["meet.google.com"]),
            browser: (options) => ({
                name: "Google Chrome",
                args: [ "--app=" + options.urlString ]
            })
        },
        {
            match: finicky.matchHostnames(["teams.microsoft.com"]),
            browser: "Microsoft Teams"
        },
    ]
};
