" vim-plug auto install
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
	silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
				\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" plugins
call plug#begin(stdpath('data') . '/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tomasiser/vim-code-dark'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
call plug#end()

" basic config
set clipboard+=unnamedplus
set ignorecase smartcase
set hidden
set mouse=a
set noshowmode
set number relativenumber
set splitright splitbelow
set shortmess+=c

" color
set termguicolors
colorscheme codedark

" disable netrw
let g:netrw_dirhistmax = 0

" vim-airline
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 0
let g:airline_section_z = airline#section#create_right(['%l|%c'])

" fzf
nmap <silent> <Leader>p :Files <CR>
nmap <silent> <Leader>b :Buffers <CR>
nmap <silent> <Leader>q :bd <CR>
