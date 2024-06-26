" Execute for all
augroup Prettier
  au!
  au BufWritePre * Prettier
augroup END


" https://www.reddit.com/r/KittyTerminal/comments/rzpjed/easier_ways_to_reload_kitty/
autocmd bufwritepost ~/.config/kitty/* :silent !kill -SIGUSR1 $(pgrep -a kitty)


autocmd BufWritePre ~/.vscode-packages :%sort
autocmd BufWritePre ~/.requirements.txt :%sort
autocmd BufWritePre ~/.apt-packages :%sort
autocmd BufWritePre ~/.Stewfile :%sort
autocmd BufWritePre ~/.config/newsboat/killfile :%sort
autocmd BufWritePre ~/.config/newsboat/highlights :%sort
autocmd BufWritePre ~/.config/newsboat/highlights :%sort

