set guifont=SauceCodeProNerdFontCompleteM-Regular:h14
set antialias		" MacVim: smooth fonts.
set encoding=utf-8	" Use UTF-8 everywhere.
set guioptions-=r	" Don't show right scrollbar
set lines=40 columns=100          " Window dimensions.

set macligatures

autocmd VimEnter * if argc() == 0 | execute 'VimwikiIndex' | endif
