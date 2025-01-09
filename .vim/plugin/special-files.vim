autocmd BufWritePre *.json,*.js,*.html,*.xml,*.css,*.ini,*.conf,*.py Neoformat

autocmd FileType conf setlocal filetype+=.tabsep

" https://www.reddit.com/r/KittyTerminal/comments/rzpjed/easier_ways_to_reload_kitty/
autocmd bufwritepost ~/.config/kitty/* :silent !kill -SIGUSR1 $(pgrep -a kitty)

autocmd BufWritePre ~/.vscode-packages :%sort
autocmd BufWritePre ~/.config/kitty/kitty.d/hotkeys.conf :%sort
autocmd BufWritePre ~/.config/kitty/kitty.d/hotkeys.conf :Tabularize/\t
autocmd BufWritePre ~/.requirements.txt :%sort
autocmd BufWritePre ~/.apt-packages :%sort
autocmd BufWritePre ~/.config/stew/Stewfile :%sort
autocmd BufWritePre ~/.config/newsboat/killfile :%sort
autocmd BufWritePre ~/.config/newsboat/killfiles/* :%sort
autocmd BufWritePre ~/.config/newsboat/killfiles/* :execute "make"
autocmd BufWritePre ~/.config/newsboat/highlights :%sort
autocmd BufWritePre ~/.config/newsboat/highlights :%sort
autocmd BufWritePre ~/.config/brew/* :%sort

autocmd BufRead,BufNewFile reflections setfiletype reflections
autocmd BufRead,BufNewFile urls,config setfiletype conf.tabsep

autocmd BufRead compose*.yml source ~/.vim/files/docker-compose.vim

