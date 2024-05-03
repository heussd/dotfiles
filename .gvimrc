set guifont=SauceCodeProNerdFontCompleteM-Regular:h14
" using Source Code Pro
" http://jonathanmh.com/using-adobes-source-code-pro-in-vim/
" set anti enc=utf-8
set guifont=Source\ Code\ Pro\ Regular\ 11

" Taken from https://github.com/fitzage/.vim/blob/master/gvimrc#L9
set antialias		" MacVim: smooth fonts.


set guioptions-=r	" Don't show right scrollbar
set lines=40 columns=100          " Window dimensions.

set macligatures

autocmd VimEnter * if argc() == 0 | execute 'VimwikiIndex' | endif
