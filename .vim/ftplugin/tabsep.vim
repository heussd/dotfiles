" Visualize tabstops
set list
set listchars=tab:>-

" Format whole file
" autocmd BufWritePost * silent :%Tabularize/\t

" Format current block
autocmd BufWritePost * silent :Tabularize/\t

