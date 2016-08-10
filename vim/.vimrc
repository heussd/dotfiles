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


" Essential: use proper encryption by default
:setlocal cm=blowfish2

" Line Numbers
:set number


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
:	set guifont=Lucida_Console:h14
:	VimroomToggle
:	Limelight
:	set guioptions-=L
:endfunction
:command FocusMode call FocusMode()
