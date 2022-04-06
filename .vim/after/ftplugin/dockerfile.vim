set list
set listchars=tab:>-

"autocmd BufWritePost * silent 1,%g/^\s*[^#]/Tabularize/\t
"autocmd BufWritePost * silent 1,%Tabularize/\t
autocmd BufWritePost * silent Tabularize/\t

