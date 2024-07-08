module.exports = {
    options: {
        hideIcon: true,
    },
    defaultBrowser: 'Firefox',
    handlers: [
        {
            match: ['*.apple.com/*'],
            browser: 'Safari',
        },
        {
            match: [
                '*.pwc.com/*',
            	'*.pwc.de/*',
                '*.sharepoint.com/*',
                '*.microsoftonline.com/*',
                'gitlab.com/*',
                'statics.teams.cdn.office.net/*' // Teams link verification
            ],
            browser: 'Microsoft Edge',
        },
        {
            match: finicky.matchHostnames([
                'replicon.com',
            	'pwcinternal.com',
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
            browser: 'Microsoft Edge',
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
            match: finicky.matchHostnames(['teams.microsoft.com']),
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
