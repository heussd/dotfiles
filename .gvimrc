" Taken from https://github.com/fitzage/.vim/blob/master/gvimrc

set guifont=Source\ Code\ Pro:h11
set antialias		" MacVim: smooth fonts.
set encoding=utf-8	" Use UTF-8 everywhere.
set guioptions-=r	" Don't show right scrollbar
set lines=40 columns=110          " Window dimensions.


set macligatures


au FileType vimwiki :set guifont=Source\ Code\ Pro:h13
"autocmd VimEnter * if argc() == 0 | execute 'VimwikiIndex' | endif
