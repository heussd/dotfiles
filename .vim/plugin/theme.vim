hi CursorLine term=bold cterm=bold guibg=Grey40
hi Folded ctermbg=NONE guibg=NONE

" Fix fold background color
" https://stackoverflow.com//questions/16014361/how-to-set-a-custom-color-to-folded-highlighting-in-vimrc-for-use-with-putty#answer-16029014
au VimEnter * :hi! Folded guibg=NONE ctermbg=NONE
set t_Co=256

" Workaround for creating transparent bg
" https://stackoverflow.com/questions/37712730/set-vim-background-transparent/67569365#answer-67569365
autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
        \ |    highlight LineNr     ctermbg=NONE guibg=NONE
        \ |    highlight SignColumn ctermbg=NONE guibg=NONE
