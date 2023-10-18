set autoread
autocmd BufWritePost * silent exec '!prettier --write "%" &> /dev/null;'
