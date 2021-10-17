" Folding for markdown-based vimwiki
" Taken and modified from https://vimwiki.github.io/vimwikiwiki/Tips%20and%20Snips.html

setlocal foldlevel=2
setlocal foldenable
setlocal foldmethod=expr
setlocal foldexpr=Fold(v:lnum)

function! Fold(lnum)
  let fold_level = strlen(matchstr(getline(a:lnum), 'Uhr$'))
  if (fold_level)
    return '>' . fold_level  " start a fold level
  endif
  return '=' " return previous fold level
endfunction


" Reload file after external change
set autoread

Goyo
set textwidth=0
set spell spelllang=de,en

if has("gui_running")
  WriterToggle
  Limelight
  set lines=55 columns=120
endif

let foo = "bar"
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
