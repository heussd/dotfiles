" https://stackoverflow.com/questions/743150/how-to-prevent-vim-from-creating-and-leaving-temporary-files
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
" https://stackoverflow.com/questions/2816719/clear-the-viminfo-file
set viminfo=	   "no ~/.viminfo file

" Essential: use proper encryption by default
" https://dgl.cx/2014/10/vim-blowfish
:setlocal cm=blowfish2

" Line Numbers
set number
" turn hybrid line numbers on
set number relativenumber

" Highlight current line
set cursorline

" hlsearch word Taken from http://nvie.com/posts/how-i-boosted-my-vim/
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type


set encoding=utf-8	" Use UTF-8 everywhere.
set termencoding=utf-8


set wrap
set linebreak
syntax enable

set nocompatible
filetype plugin on




command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
    \   'git grep --line-number -- '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
