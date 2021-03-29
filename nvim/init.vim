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
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'sheerun/vim-polyglot'
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
set termguicolors
set ts=4 sts=4 sw=4
colorscheme nord

" disable netrw
let g:netrw_dirhistmax = 0

" vim-airline
let g:airline#extensions#tabline#enabled = 1

" fzf
nmap <silent> <Leader>p :Files <CR>
nmap <silent> <Leader>b :Buffers <CR>
nmap <silent> <Leader>q :bd <CR>

" coc extensions
let g:coc_global_extensions = [
			\'coc-go',
			\'coc-json',
			\'coc-pairs',
			\'coc-snippets',
			\'coc-yaml',
			\]

" format file
nmap <silent> <Leader>l <Plug>(coc-format)

" rename symbol
nmap <silent> <F2> <Plug>(coc-rename)

" go to definition
nmap <silent> gd <Plug>(coc-definition)

" go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" go to references
nmap <silent> gr <Plug>(coc-references)

" find symbol (variables, functions)
nmap <silent> <Leader>g :CocList symbols <CR>

" show docs
nmap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	elseif (coc#rpc#ready())
		call CocActionAsync('doHover')
	else
		execute '!' . &keywordprg . " " . expand('<cword>')
	endif
endfunction

" trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" tab completion
inoremap <silent><expr> <TAB>
			\ pumvisible() ? coc#_select_confirm() :
			\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" coc keymap for Go
autocmd FileType go nmap gta :CocCommand go.tags.add.prompt <CR>
autocmd FileType go nmap gtr :CocCommand go.tags.remove.prompt <CR>

