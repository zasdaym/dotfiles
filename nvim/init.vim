" vim-plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
	silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
		\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin(stdpath('data') . '/plugged')
Plug 'antoinemadec/coc-fzf'
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
call plug#end()

" vim
colorscheme nord
set hidden
set ignorecase smartcase
set number relativenumber
set splitright splitbelow
set ts=4 sts=4 sw=4
set clipboard=unnamed

" coc extensions
let g:coc_global_extensions = [
			\'coc-go',
			\'coc-json',
			\'coc-pairs',
			\'coc-sh',
			\'coc-yaml',
			\]

" coc-fzf
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []

" coc keymap
nmap <leader>rn <Plug>(coc-rename)

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" fzf
nnoremap <silent> <Leader>p :FZF <CR>
