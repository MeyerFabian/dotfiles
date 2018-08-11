" DOWNLOAD, PUT IN	vimfiles/autoload	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" SEPERATE WINDOWS BINARIES FOR FZF at https://github.com/junegunn/fzf-bin/releases

set encoding=utf-8

"
" GVIM ON WINDOWS
"
if !has('nvim')
	source $VIMRUNTIME/vimrc_example.vim
	source $VIMRUNTIME/mswin.vim
	behave mswin

	set diffexpr=MyDiff()
	function MyDiff()
		let opt = '-a --binary '
		if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
		if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
		let arg1 = v:fname_in
		if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
		let arg2 = v:fname_new
		if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
		let arg3 = v:fname_out
		if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
		if $VIMRUNTIME =~ ' '
			if &sh =~ '\<cmd'
				if empty(&shellxquote)
					let l:shxq_sav = ''
					set shellxquote&
				endif
				let cmd = '"' . $VIMRUNTIME . '\diff"'
			else
				let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
			endif
		else
			let cmd = $VIMRUNTIME . '\diff'
		endif
		silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
		if exists('l:shxq_sav')
			let &shellxquote=l:shxq_sav
		endif
	endfunction
endif

"
"PLUGINS
"

call plug#begin('$Home/vimfiles/plugged')
Plug 'rust-lang/rust.vim', { 'for': [ 'rust' ], 'do': 'cargo install rustfmt' }
Plug 'racer-rust/vim-racer'
Plug 'jpo/vim-railscasts-theme'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/deol.nvim'
Plug 'Valloric/YouCompleteMe'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Chiel92/vim-autoformat'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

" Initialize plugin system
"let g:loaded_youcompleteme = 1

"if executable('cquery')
"   au User lsp_setup call lsp#register_server({
"   \ 'name': 'cquery',
"   \ 'cmd': {server_info->['cquery']},
"   \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
"   \ 'initialization_options': { 'cacheDirectory': '../../AppData/Local/Temp/cquery' },
"   \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
"   \ })
"   endif
"nn <silent> <leader>ld :LspDefinition<cr>
"nn <silent> <leader>lr :LspReferences<cr>
"nn <silent> <leader>lf :LspDocumentFormat<cr>
"nn <f2> :LspRename<cr>

"rustfmt
"let g:rustfmt_autosave = 1

" syntax highligting c++
let g:cpp_class_decl_highlight = 1
let g:cpp_class_scope_highlight = 1

"clang-format
au BufWrite * :Autoformat

"
"	 SET FONT + UI
"



colorscheme railscasts
set guifont=DejaVu\ Sans\ Mono:h10
set number
set t_Co=256
set nocompatible
set modelines=0
set laststatus=2
highlight Pmenu guibg=brown gui=bold

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

set wildmenu
set wildmode=list,full

"set clipboard windows
set clipboard=unnamed

"
"	"KEYMAPPINGS
"

let mapleader = "\<Space>"
nnoremap gd :YcmCompleter GoToDeclaration<CR>
"
"remap cut-> <leader>d, delete -> cut DONT CHANGE ORDER
nnoremap <leader>d d
nnoremap <leader>D D
vnoremap <leader>d d

nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
"move line down up
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
"tabs
nnoremap <leader>te :tabnew<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>

"vimrc open
nnoremap <leader>fed :e ~/_vimrc<CR>
nnoremap <leader>fs :w<CR>
":e in current filedir
nnoremap <leader>fee :e %:h
":e fast switch .cpp <->.hpp
nnoremap <leader>feh :e %:p:r.hpp<CR>
nnoremap <leader>fec :e %:p:r.cpp<CR>

""SPECIFIC
"Ctrlp
"nnoremap <leader>p :CtrlP ~/Projects<CR>

"fzf
nnoremap <leader>/p :Files<CR>
nnoremap <leader>/f :FindFunctions<CR>
nnoremap <leader>/s :FindSymbols<CR>
nnoremap <leader>/i :FindImpls<CR>

"git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gp :Gpush<CR>
nnoremap <leader>gd :Gdiff<CR>

"shell
nnoremap <leader>! :Deol -split<cr>

"nerdtree
nmap <leader>ff :NERDTreeToggle<CR>
"stolen from /github.com/MaikKlein/dotfiles
command! -bang -nargs=* FindSymbols
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --no-ignore --color=always "(type|enum|struct|trait)[ \t]+([a-zA-Z0-9_]+)" -g "*.rs" | rg '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)

command! -bang -nargs=* FindFunctions
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --no-ignore --color=always "fn +([a-zA-Z0-9_]+)" -g "*.rs" | rg '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\   <bang>0)

command! -bang -nargs=* FindImpls
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading ---no-ignore -color=always "impl([ \t\n]*<[^>]*>)?[ \t]+(([a-zA-Z0-9_:]+)[ \t]*(<[^>]*>)?[ \t]+(for)[ \t]+)?([a-zA-Z0-9_]+)" | rg '.shellescape(<q-args>), 1,
			\   <bang>0 ? fzf#vim#with_preview('up:60%')
			\           : fzf#vim#with_preview('right:50%:hidden', '?'),
			\ <bang>0)

