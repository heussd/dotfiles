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
            match: ["*.pwc.com/*", "*.pwc.de/*", "*.replicon.com/*","gitlab.com/*"],
            browser: "Google Chrome"
        },
        {
            match: ["*.azure.com/*", "*.microsoft.com/*"],
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
