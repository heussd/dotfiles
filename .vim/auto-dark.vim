" https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
function! ChangeBackground()
  if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark   " for the dark version of the theme
  else
    set background=light  " for the light version of the theme
  endif
endfunction

autocmd SigUSR1 * call ChangeBackground()

call ChangeBackground()
