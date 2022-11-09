set list
set listchars=tab:>-

"autocmd BufWritePost * silent 1,%g/^\s*[^#]/Tabularize/\t
"autocmd BufWritePost * silent 1,%Tabularize/\t
autocmd BufWritePost * silent :Tabularize /^[^\t]*\zs=



syn region myFold start="^\w*[-]*\w*:" end="\n\n" transparent fold
syn sync fromstart
set foldmethod=syntax
