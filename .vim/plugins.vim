" Install VIM plug - https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'honza/writer.vim'
Plug 'vimwiki/vimwiki'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'stsewd/gx-extended.vim'
Plug 'godlygeek/tabular'

Plug 'dense-analysis/ale'
Plug 'pedrohdz/vim-yaml-folds'

Plug 'cespare/vim-toml', { 'branch': 'main' }

Plug 'pseewald/vim-anyfold'

Plug 'mcchrish/nnn.vim'

Plug 'morhetz/gruvbox'


Plug 'ervandew/supertab'

Plug 'dhruvasagar/vim-table-mode'

Plug 'jamessan/vim-gnupg'
call plug#end()
