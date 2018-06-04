" DOWNLOAD, PUT IN 	vimfiles/autoload 	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" SEPERATE WINDOWS BINARIES FOR FZF at https://github.com/junegunn/fzf-bin/releases

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
"Plug 'ludovicchabant/vim-gutentags'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Initialize plugin system
call plug#end()

"
"CONFIGURE PLUGINS
"

"deoplete
let g:deoplete#enable_at_startup = 1

"rustfmt
let g:rustfmt_autosave = 1

"rusty-tags
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

"
"	 SET FONT + UI
"


"Start maximized
au GUIEnter * simalt ~x

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

"move line down up
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

"vimrc open
nnoremap <leader>fed :e ~/_vimrc<CR>
nnoremap <leader>fs :w<CR>

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

