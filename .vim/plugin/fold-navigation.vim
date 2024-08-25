nnoremap <space> za
vnoremap <space> za

nnoremap <leader>0 zczA
vnoremap <leader>0 zczA


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

