" vim-plug
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
	silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs
				\ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

call plug#begin(stdpath('data') . '/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'josa42/vim-lightline-coc'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
" Plug 'vim-airline/vim-airline'
call plug#end()

" vim
colorscheme nord
set clipboard=unnamed
set ignorecase smartcase
set hidden
set mouse=a
set noshowmode
set number relativenumber
set showtabline=2
set splitright splitbelow
set termguicolors
set ts=4 sts=4 sw=4

" coc extensions
let g:coc_global_extensions = [
			\'coc-go',
			\'coc-json',
			\'coc-pairs',
			\'coc-sh',
			\'coc-snippets',
			\'coc-yaml',
			\]

" coc keymap
nmap <silent> <F2> <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <Leader>g :CocList symbols <CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction
autocmd FileType go nmap gt :CocCommand go.tags.add.prompt <CR>
inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

" fzf
nmap <silent> <Leader>p :Files <CR>
nmap <silent> <Leader>b :Buffers <CR>
nmap <silent> <Leader>q :bd <CR>

" vim-airline
" let g:airline#extensions#tabline#enabled = 1

" lightline
let g:lightline = {
			\	'colorscheme': 'nord',
			\	'active': {
			\		'left': [ 
			\			[ 'mode', 'paste' ],
			\			[ 'gitbranch', 'readonly', 'filename', 'modified' ],
			\		],
			\		'right': [
			\			[ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok'],
			\			[ 'coc_status' ],
			\			[ 'lineinfo' ],
			\			[ 'percent' ],
			\			[ 'fileformat', 'fileencoding', 'filetype' ]
			\		]
			\	},
			\	'tabline': {
			\		'left': [
			\			[ 'buffers' ]
			\		],
			\		'right': [
			\			[]
			\		]
			\	},
			\	'component_expand': {
			\		'buffers': 'lightline#bufferline#buffers'
			\	},
			\	'component_function': {
			\		'gitbranch': 'fugitive#head',
			\	},
			\	'component_raw': {
			\		'buffers': 1
			\	},
			\	'component_type': {
			\		'buffers': 'tabsel'
			\	}
			\ }
let g:lightline#bufferline#clickable = 1
call lightline#coc#register()
