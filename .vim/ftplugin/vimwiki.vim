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
  if getline(a:lnum) =~? '\v^\s*$'
    if (strlen(matchstr(getline(a:lnum + 1), '^#\+')) > 0 )
      return '-1' " don't fold last blank line before header
    endif
  endif
  return '=' " return previous fold level
endfunction
