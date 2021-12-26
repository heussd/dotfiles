" Visualize tabstops
set list
set listchars=tab:>-

autocmd BufWritePost * silent 1,%g/^\s*[^#]/Tabularize/\t

