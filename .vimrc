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


function Fullscreen()
	silent! set fu
endfunction

function FocusMode()
	Goyo
	set textwidth=0
	set spell spelllang=de,en
	if has("gui_running")
	  WriterToggle
	  Limelight
	  set lines=55 columns=120
	endif
	let foo = "bar"
	set wrap
	set linebreak
	set textwidth=0
	set wrapmargin=0
	" :set nolist In vim versions prior to 7.4.353 list disabled linebreak
endfunction
command FocusMode call FocusMode()


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
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'honza/writer.vim'
Plug 'vimwiki/vimwiki'
Plug 'tomasr/molokai'
Plug 'airblade/vim-gitgutter'
Plug 'APZelos/blamer.nvim'
Plug 'tpope/vim-fugitive'
Plug 'stsewd/gx-extended.vim'
call plug#end()


colorscheme molokai

" vimwiki settings
let g:vimwiki_list = [{ 
	\ 'path': "$HOME/Developer/vimwiki/",
	\ 'ext':'.md',
	\ 'syntax':'markdown',
	\ 'diary_rel_path': "/",
	\ 'diary_index': "index"
	\ }]
let g:vimwiki_markdown_link_ext = 1

" Allow other markdown files to be non-vimwiki files
let g:vimwiki_global_ext = 0


function VimwikiMode()
	" Change working copy (for rg, fzf) when entering vimwiki
	lcd %:p:h
	
	set autoread " Auto update on external file changes

	" Auto Commit vimwiki pages https://superuser.com/questions/286290/is-there-any-way-to-hook-saving-in-vim-up-to-commiting-in-git
	autocmd BufWritePost * silent exec '!markdownlint --config markdownlint.yml --fix "%"; git add "%" && git commit -n -m "% (auto commit)" > /dev/null'
	
	" Inspired by https://gist.github.com/jondkinney/2040114
	" FUZZY FIND
	nnoremap <C-f> :Rg<CR>

	set spell spelllang=de,en
	set spell

	" This line is causing display glitches on Linux terminals, so it's disabled for now.
	" https://stackoverflow.com/questions/20593268/vim-on-ubuntu-text-rendering-bug-repeating-and-disappearing-weirdly#25085808
	" set lines=50 columns=130

	nnoremap <C-p> :Git pull<CR>
    nnoremap <C-o> :Git push<CR>
    
	map <Leader>wp  :VimwikiDiaryPrevDay<CR>
    map <Leader>wn  :VimwikiDiaryNextDay<CR>
    set shiftwidth=2
    set expandtab


	set completefunc=CompleteLinks
	let g:vimwiki_table_mappings = 0
	nnoremap <C-Space> i
	inoremap <C-Space> <c-x><c-u>
	
endfunction
au FileType vimwiki call VimwikiMode()


" Open current editor file externally
nnoremap gO :!open '%:p'<CR>


" https://vim.fandom.com/wiki/Word_wrap_without_line_breaks
:set wrap
:set linebreak
" :set nolist In vim versions prior to 7.4.353 list disabled linebreak


let mapleader=","

" https://groups.google.com/forum/#!topic/vimwiki/ChSY9b4WBbQ
fun! CompleteLinks(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find files matching with "a:base"
        let res = []
        for m in split(globpath('.', '**/*.md'), '\n')
            let n = fnamemodify(m, ':t:r')
            if n =~ '^' . a:base
                call add(res, n)
            endif
        endfor
        return res
    endif
endfun

:autocmd VimEnter * if argc() == 0 | execute 'VimwikiIndex' | endif

" Map C-Y C-N to Control Space
" https://vi.stackexchange.com/questions/21457/how-to-remap-autocomplete-on-controln-to-controlspace#answer-21469
inoremap <c-@> <c-n>


" Folding
let g:vimwiki_folding = 'custom'

nnoremap <space> za
vnoremap <space> za

" https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-the-next-closed-fold-in-vim#answer-9407015
nnoremap <silent> <s-j> :call NextClosedFold('j')<cr>
nnoremap <silent> <s-k> :call NextClosedFold('k')<cr>

function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction



