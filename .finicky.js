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
        match: finicky.matchHostnames(["pwc.com", "mail.google.com", "meet.google.com", "drive.google.com", "calendar.google.com", "chat.google.com", "docs.google.com"]),
        browser: "Google Chrome"
    }
]
};
