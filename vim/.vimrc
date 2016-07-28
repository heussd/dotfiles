" Essential: no automatic & persistent line breaks
set wrapmargin=0
set textwidth=0
set wrap
set linebreak
set nolist  " list disables linebreak

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
set anti enc=utf-8
set guifont=Source\ Code\ Pro\ 11
