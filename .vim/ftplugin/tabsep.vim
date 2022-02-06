" Visualize tabstops
set list
set listchars=tab:>-

autocmd BufWritePost * silent Tabularize/\t

