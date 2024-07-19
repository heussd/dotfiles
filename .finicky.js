module.exports = {
    options: {
        hideIcon: true,
    },
    defaultBrowser: 'LibreWolf',
    handlers: [
        {
            match: ['*.apple.com/*'],
            browser: 'Safari',
        },
        {
            match: [
                '*.pwc.com/*',
            	'*.pwc.de/*',
            	'*pwcnetwork*/*',
                '*.sharepoint.com/*',
                '*.microsoftonline.com/*',
                '*.microsoft.com/*',
            	'*.pwcinternal.com/*',
                'gitlab.com/*',
                'statics.teams.cdn.office.net/*' // Teams link verification
            ],
            browser: 'Google Chrome',
        },
        {
            match: finicky.matchHostnames([
                'replicon.com',
                'cloudapp.azure.com',
                'microsoft.com',
                'urldefense.com',
                'office.com',
                'office.net',
               	'azure.com',
                'docs.google.com',
                'stream.meet.google.com',
                'accounts.google.com',
                'drive.google.com',
            ]),
            browser: 'Google Chrome',
        },
        {
            match: finicky.matchHostnames([
                'mail.google.com',
                'calendar.google.com',
                'chat.google.com',
                'script.google.com' // MO Plus
            ]),
            browser: 'Google Chrome',
        },
        {
            // Open Google Meet in app mode
            match: finicky.matchHostnames(['meet.google.com']),
            browser: (options) => ({
                name: 'Google Chrome',
                args: ['--app=' + options.urlString],
            }),
        },
        {
            match: ['*.teams.microsoft.com/*'],
            browser: 'com.microsoft.teams2',
            url({ url }) {
                return {
                    ...url,
                    protocol: 'msteams',
                };
            },
        },
    ],
};
