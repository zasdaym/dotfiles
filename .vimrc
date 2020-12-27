if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'doums/darcula'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme nord
set number
set relativenumber
set splitright
set splitbelow
set clipboard=unnamed
set tabstop=4
set softtabstop=4
set shiftwidth=4
