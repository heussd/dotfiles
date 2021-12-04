" Visualize tabstops
set list
set listchars=tab:>-

syntax keyword cTodo contained "yes"
syn keyword basicLanguageKeywords "yes"
syntax on

autocmd BufWritePost * silent 1,%Tabularize/\t

