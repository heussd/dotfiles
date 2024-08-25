vim9script

var options = {
    completor: {
    	alwaysOn: true,
    	shuffleEqualPriority: true,
    	postfixHighlight: true
    },
    buffer: { enable: true, priority: 10, urlComplete: true, envComplete: true },
    abbrev: { enable: true, priority: 10 },
    omnifunc: { enable: false, priority: 8, filetypes: ['python', 'javascript'] },
    ngram: {
	enable: true,
        priority: 10,
        bigram: false,
        filetypes: ['text', 'help', 'markdown'],
        filetypesComments: ['c', 'cpp', 'python', 'java'],
    },
}
g:vimcomplete_tab_enable = 1
g:vimcomplete_cr_enable = 0

autocmd VimEnter * g:VimCompleteOptionsSet(options)
