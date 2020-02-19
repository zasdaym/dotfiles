" vim: set foldmethod=marker foldlevel=0 nomodeline:

" plugin
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'lifepillar/vim-gruvbox8'
Plug 'lifepillar/vim-solarized8'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" leader mapping
let mapleader = " "
nnoremap <silent> <leader>p :Files<CR>
nnoremap <silent> <leader>q :b#<CR>
nnoremap <silent> <leader>w :bd<CR>

" theme
colorscheme solarized8
set termguicolors
set background=dark

" editor
set number
set clipboard+=unnamedplus
set ignorecase
set smartcase
set hidden
set splitbelow
set splitright

" mucomplete
set completeopt+=menuone
set completeopt+=noselect
