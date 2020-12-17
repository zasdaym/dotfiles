if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'doums/darcula'
Plug 'sheerun/vim-polyglot'
call plug#end()

colorscheme darcula
set number
set relativenumber
set splitright
set splitbelow
set clipboard=unnamed
set tabstop=4
set softtabstop=4
set shiftwidth=4
