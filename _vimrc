" DOWNLOAD, PUT IN 	vimfiles/color 		https://raw.githubusercontent.com/jpo/vim-railscasts-theme/master/colors/railscasts.vim
" DOWNLOAD, PUT IN 	vimfiles/autoload 	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" SEPERATE WINDOWS BINARIES FOR FZF at https://github.com/junegunn/fzf-bin/releases
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
"file directory -> working directory
set autochdir

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

"autocompletion
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

"save
nnoremap <leader>fs :w<CR>

" buffer
nnoremap <leader>b :b 

""SPECIFIC
"Ctrlp
"nnoremap <leader>p :CtrlP ~/Projects<CR>
"fzf
nnoremap <leader>p :Files<CR>
"vimrc open
nnoremap <leader>fed :e ~/_vimrc<CR>

" Start maximized
au GUIEnter * simalt ~x

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
"PLUGINS
" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('$Home/vimfiles/plugged')
Plug 'rust-lang/rust.vim', { 'for': [ 'rust' ], 'do': 'cargo install rustfmt' }
Plug 'racer-rust/vim-racer'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Initialize plugin system
call plug#end()

"rustfmt execute on save
let g:rustfmt_autosave = 1

" auto nerdtree ctrlp does everything i want in filesearch probably already
" autocmd VimEnter * NERDTree | wincmd p
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
