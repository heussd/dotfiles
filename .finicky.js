module.exports = {
options: {
    hideIcon: true,
},
defaultBrowser: "Firefox",
rewrite: [
    {
      // Redirect all urls to use https
      match: ({ url }) => url.protocol === "http",
      url: { protocol: "https" }
    }
  ],
handlers: [
    {
        match: finicky.matchHostnames(["pwc.com", "accounts.google.com", "www.google.com", "stream.meet.google.com", "mail.google.com", "drive.google.com", "calendar.google.com", "chat.google.com", "docs.google.com"]),
        browser: "Google Chrome"
    },
    {
        // Open Google Meet in app mode
        match: finicky.matchHostnames(["meet.google.com"]),
        browser: (options) => ({
            name: "Google Chrome",
            args: [ "--app=" + options.urlString ]
        })
    }
]
};
