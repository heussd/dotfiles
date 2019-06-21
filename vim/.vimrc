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
" turn hybrid line numbers on
:set number relativenumber

" Highlight current line
:set cursorline
":hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white


" Taken from http://nvie.com/posts/how-i-boosted-my-vim/
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                    "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

" using Source Code Pro
" http://jonathanmh.com/using-adobes-source-code-pro-in-vim/
" set anti enc=utf-8
set guifont=Source\ Code\ Pro\ Regular\ 11


:function FocusMode()
:	silent! set fu
:	sleep 2
:	redraw
:	silent! WriterToggle
:	Goyo
:	Limelight
:	set wrapmargin=0
:	set textwidth=0
:	set wrap
:	set linebreak
:	set nolist  " list disables linebreak
: set spell spelllang=de,en
:endfunction
:command FocusMode call FocusMode()


function Date()
	:r! date "+\%A, \%d. \%B \%Y, \%H:\%M Uhr"
endfunction
command Date call Date()


" Taken from https://github.com/fitzage/.vim/blob/master/gvimrc#L9

set antialias		" MacVim: smooth fonts.
set encoding=utf-8	" Use UTF-8 everywhere.
set termencoding=utf-8


" Neocomplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1


hi CursorLine term=bold cterm=bold guibg=Grey40

syntax enable

set nocompatible
filetype plugin on


" Install VIM plug - https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'honza/writer.vim'
Plug 'https://github.com/alok/notational-fzf-vim'
Plug 'vimwiki/vimwiki'
Plug 'scrooloose/nerdtree'
Plug 'michal-h21/vim-zettel'
Plug 'tomasr/molokai'
call plug#end()


colorscheme Molokai

" Notational Velocity Vim settings
let g:nv_search_paths = ['~/vimwiki', '~/Documents', '~/projects', 'docs.md' , './notes.md']

" vimwiki settings
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]
" Filename format. The filename is created using strftime() function
let g:zettel_format = "%y%m%d-%H%M"
" Disable default keymappings
let g:zettel_default_mappings = 0
" This is basically the same as the default configuration
augroup filetype_vimwiki
  autocmd!
  autocmd FileType vimwiki imap <silent> [[ [[<esc><Plug>ZettelSearchMap
  autocmd FileType vimwiki nmap T <Plug>ZettelYankNameMap
  autocmd FileType vimwiki xmap z <Plug>ZettelNewSelectedMap
  autocmd FileType vimwiki nmap gZ <Plug>ZettelReplaceFileWithLink
augroup END

" Settings for Vimwiki
let g:vimwiki_list = [{'path':'~/vimwiki/','ext':'.md','syntax':'markdown', 'zettel_template': "~/mytemplate.tpl"}]
" Set template and custom header variable for the second Wiki
let g:zettel_options = [{},{"front_matter" : {"tags" : ""}, "template" :  "~/mytemplate.tpl"}]
