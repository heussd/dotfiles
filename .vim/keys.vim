" https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode#answer-2163
set backspace=indent,eol,start

let mapleader=","


nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

" Map C-Y C-N to Control Space
" https://vi.stackexchange.com/questions/21457/how-to-remap-autocomplete-on-controln-to-controlspace#answer-21469
inoremap <c-@> <c-n>

map <s-j> <S-}>
map <s-k> <S-{>


map <C-F> :GFiles <CR>
