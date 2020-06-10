" plugin
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" conf
set termguicolors
set number relativenumber
set ignorecase smartcase
set clipboard+=unnamedplus
set splitright splitbelow
colorscheme nord
