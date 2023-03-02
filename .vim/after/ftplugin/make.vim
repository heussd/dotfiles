set list
set listchars=tab:>-

"autocmd BufWritePost * silent 1,%g/^\s*[^#]/Tabularize/\t
"autocmd BufWritePost * silent 1,%Tabularize/\t
autocmd BufWritePost * silent :Tabularize /^[^\t]*\zs=




setlocal foldlevel=0 
setlocal foldenable
setlocal foldmethod=expr
setlocal foldexpr=Fold(v:lnum)

function! Fold(lnum)
  let fold_level = strlen(matchstr(getline(a:lnum), '^.*:'))
  if (fold_level)
    return '>1'  ". fold_level  " start a fold level
  endif
  return '=' " return previous fold level
endfunction


