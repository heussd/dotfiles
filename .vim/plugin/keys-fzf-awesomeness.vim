command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
    \   'git grep --line-number -- '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-i': 'split',
  \ 'ctrl-v': 'vsplit' }

map <C-F> :GFiles <CR>
map <C-G> :GGrep <CR>
