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
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
call plug#end()

" vim
set clipboard+=unnamedplus
set ignorecase smartcase
set hidden
set mouse=a
set noshowmode
set number relativenumber
set splitright splitbelow
set termguicolors
set ts=4 sts=4 sw=4
colorscheme nord

" disable netrw
let g:netrw_dirhistmax = 0

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" coc extensions
let g:coc_global_extensions = [
			\'coc-go',
			\'coc-json',
			\'coc-pairs',
			\'coc-snippets',
			\'coc-svelte',
			\'coc-yaml',
			\]

" coc keymap
nnoremap <silent> <Leader>l <Plug>(coc-format)
nnoremap <silent> <F2> <Plug>(coc-rename)
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <silent> <Leader>g :CocList symbols <CR>
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

" coc keymap for Go
autocmd FileType go nmap gta :CocCommand go.tags.add.prompt <CR>
autocmd FileType go nmap gtr :CocCommand go.tags.remove.prompt <CR>

" fzf
nnoremap <silent> <Leader>p :Files <CR>
nnoremap <silent> <Leader>b :Buffers <CR>
nnoremap <silent> <Leader>q :bd <CR>
