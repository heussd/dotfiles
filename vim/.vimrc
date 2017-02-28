" Essential: no automatic & persistent line breaks
set wrapmargin=0
set textwidth=0
set wrap
set linebreak
set nolist  " list disables linebreak


" https://stackoverflow.com/questions/743150/how-to-prevent-vim-from-creating-and-leaving-temporary-files
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
" https://stackoverflow.com/questions/2816719/clear-the-viminfo-file
:set viminfo=	   "no ~/.viminfo file

" Essential: use proper encryption by default
" https://dgl.cx/2014/10/vim-blowfish
:setlocal cm=blowfish2

" Line Numbers
:set number

" Highlight current line
:set cursorline


" Taken from http://nvie.com/posts/how-i-boosted-my-vim/
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

color molokai

" using Source Code Pro
" http://jonathanmh.com/using-adobes-source-code-pro-in-vim/
" set anti enc=utf-8
set guifont=Source\ Code\ Pro\ Regular\ 11



:function FocusMode()
:	WriterToggle
:	Goyo
:	Limelight
:	set fu
:	set wrapmargin=0
:	set textwidth=0
:	set wrap
:	set linebreak
:	set nolist  " list disables linebreak
:endfunction
:command FocusMode call FocusMode()

