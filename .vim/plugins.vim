" Install VIM plug - https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'dense-analysis/ale'
Plug 'dhruvasagar/vim-table-mode'
Plug 'godlygeek/tabular'
Plug 'honza/writer.vim'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mcchrish/nnn.vim'
Plug 'michal-h21/vim-zettel'
Plug 'morhetz/gruvbox'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'pseewald/vim-anyfold'
Plug 'sbdchd/neoformat'
Plug 'stsewd/gx-extended.vim'
Plug 'tpope/vim-fugitive'
Plug 'vimwiki/vimwiki'
Plug 'zivyangll/git-blame.vim'
call plug#end()
