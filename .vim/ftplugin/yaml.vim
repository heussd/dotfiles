set autoread
autocmd BufWritePost * silent exec '!prettier --write --tab-width 2 "%" &> /dev/null;'
