" vim: set foldmethod=marker foldlevel=0 nomodeline:

" plugin
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'vim-airline/vim-airline'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-endwise'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'jiangmiao/auto-pairs'
Plug 'janko/vim-test'
call plug#end()

" leader mapping
let mapleader = " "
nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>q :b#<CR>
nnoremap <silent> <leader>w :bd<CR>

" theme
colorscheme gruvbox
set termguicolors
set background=dark

" editor
set mouse=a
set number
set clipboard+=unnamedplus
set ignorecase
set smartcase
set hidden
set splitbelow
set splitright
set autowrite
set noshowmode

" mucomplete
set completeopt+=menuone
set completeopt-=preview
set shortmess+=c
set belloff+=ctrlg

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
