"autocmd BufWritePost markdown silent exec '%!markdownlint --fix --config "$HOME/markdownlint.yml" "%" > /dev/null; slmd "%" -o;" > /dev/null' | silent redraw!
