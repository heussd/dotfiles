" Install VIM plug - https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.config/vim/dotfiles/autoload/plug.vim'))
silent !curl -fLo ~/.config/vim/dotfiles/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/vim/dotfiles/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'morhetz/gruvbox'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'zivyangll/git-blame.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

