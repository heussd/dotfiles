" Folding for markdown-based vimwiki
" Taken and modified from https://vimwiki.github.io/vimwikiwiki/Tips%20and%20Snips.html

setlocal foldlevel=1
setlocal foldenable
setlocal foldmethod=expr
setlocal foldexpr=Fold(v:lnum)

function! Fold(lnum)
  let fold_level = strlen(matchstr(getline(a:lnum), '^#\+'))
  if (fold_level)
    return '>' . fold_level  " start a fold level
  endif
  return '=' " return previous fold level
endfunction


" Reload file after external change
set autoread


let b:ale_enabled = 0


autocmd BufWritePost * silent exec '%!markdownlint --fix --config "$HOME/.markdownlint.yml" "%" > /dev/null; slmd "%" -o'

silent TableModeEnable
silent TableModeRealign
