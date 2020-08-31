" DOWNLOAD, PUT IN  vimfiles/autoload   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" SEPERATE WINDOWS BINARIES FOR FZF at https://github.com/junegunn/fzf-bin/releases

set encoding=utf-8

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              GVIM ON WINDOWS                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  PLUGINS                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('$Home/vimfiles/plugged')
Plug 'MeyerFabian/dokuvimki', {'on': 'DokuVimKi'}
Plug 'jpalardy/vim-slime'
Plug 'jvirtanen/vim-octave'
"Plug 'rust-lang/rust.vim', { 'for': [ 'rust' ], 'do': 'cargo install rustfmt' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'racer-rust/vim-racer'
Plug 'MeyerFabian/vim-railscasts-theme'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deol.nvim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Chiel92/vim-autoformat'
Plug 'tikhomirov/vim-glsl'
Plug 'easymotion/vim-easymotion'
Plug 'lervag/vimtex'
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
Plug 'wesQ3/vim-windowswap'
Plug 'tpope/vim-abolish'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-markdown'
Plug 'masukomi/vim-markdown-folding'
Plug 'Valloric/YouCompleteMe'
Plug 'Konfekt/FastFold'
"Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Alternative to YouCompleteMe
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
" try coc maybe
call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Initialize Plugins                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_max_diagnostics_to_display = 0
let active_coc = 0
let g:autoformat_verbosemode=1
let active_ycm =1
let g:ycm_use_clangd = 0
"let g:loaded_youcompleteme = 1

let active_vim_autoformat   = 1
let active_ulti_snippets    = 0
let active_vimtex           = 1
let active_rust             = 0

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

"folding
set foldmethod=syntax

"conemu+slime
let g:slime_target = "conemu"

" syntax highligting c++
let g:cpp_class_decl_highlight  = 1
let g:cpp_class_scope_highlight = 1

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

"spell checks
autocmd BufEnter *.txt  setlocal nospell
autocmd BufLeave *.txt  setlocal spell

augroup spellCheck
    autocmd!
    autocmd FileType *.rst setlocal spell
    autocmd BufRead,BufNewFile *.rst setlocal spell
augroup END


if active_vim_autoformat && !active_rust
"clang-format
augroup autoformat
    autocmd!
    autocmd Bufwrite * silent! :Autoformat
augroup END
endif
if active_ulti_snippets
"ulti snippets
    au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsListSnippets="<c-e>"
    " this mapping Enter key to <C-y> to chose the current highlight item
    " and close the selection list, same as other IDEs.
    " CONFLICT with some plugins like tpope/Endwise
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
if active_vimtex
    "tex
    let g:vimtex_view_general_method = 'SumatraPDF'
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options
                \ = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
    let g:vimtex_compiler_latexmk = {
                \ 'options' : [
                \   '-pdf',
                \   '-shell-escape',
                \   '-verbose',
                \   '-file-line-error',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
                \}

    if !exists('g:ycm_semantic_triggers')
        let g:ycm_semantic_triggers = {}
    endif
    let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
    let g:ycm_filetype_blacklist = {}

    let g:tex_flavor = "latex"
    let g:tex_fast = "cmMprs"
    let g:tex_conceal = ""
    let g:tex_fold_enabled = 0
    let g:tex_comment_nospell = 1
endif
"
"let g:vimwiki_list = [{'path':'~/Projects/vimwiki', 'path_html':'~/Projects/vimwiki_html/', 'auto_tags':1}]


" dokuwiki credentials
source ~/dokuwiki_auth.vim

" airline
let g:airline#extensions#tabline#enabled = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 FONT + GUI                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
colorscheme railscasts

set number
set t_Co=256
set nocompatible
filetype plugin on
syntax on
set modelines=0
set laststatus=2
highlight Pmenu guibg=#4f4f4f gui=bold

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

"auto resize when host window is resized
autocmd VimResized * wincmd =

set wildmenu
set wildmode=list,full

set guifont=Consolas:h10:cANSI

"set clipboard windows
set clipboard=unnamed

set scrolloff=1
set ts=4 sw=4 sts=4 et

call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                KEYMAPPINGS                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"
if active_ycm
  nnoremap gd :YcmCompleter GoTo<CR>
endif
if active_coc
  nmap <silent> gd <Plug>(coc-definition)
endif

let g:windowswap_map_keys = 0 "prevent default bindings

let g:NERDTreeQuitOnOpen=1

"remap cut-> <leader>d, delete -> cut DONT CHANGE ORDER
nnoremap <leader>d d
nnoremap <leader>D D
vnoremap <leader>d d

nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

"rebind shift-up/down not to do page up/down
nmap <S-Up> <Up>
nmap <S-Down> <Down>
nmap <S-CR> <CR>

"move line down up
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
"tabs
nnoremap <leader>te :tabnew %<CR>
nnoremap <leader>tn :tabn<CR>
nnoremap <leader>tp :tabp<CR>
nnoremap <leader>tL :tabm+<CR>
nnoremap <leader>tH :tabm-<CR>
"vimrc open
nnoremap <leader>ed :e ~/_vimrc<CR>
nnoremap <leader>es :w<CR>
":e in current filedir
nnoremap <leader>ee :e %:h
"jump back to previous file
nnoremap <leader>ep :e#<CR>
"nerdtree
nmap <leader>ef :call MyNerdToggle()<CR>
"mksession + load session
nnoremap <leader>ms :mksession! ~/vimfiles/sessions/temp.vim<CR>
nnoremap <leader>ml :so ~/vimfiles/sessions/temp.vim<CR>
nnoremap <leader>mn :mksession! ~/vimfiles/sessions/
nnoremap <leader>mm :so ~/vimfiles/sessions/
""SPECIFIC
"Ctrlp
"nnoremap <leader>p :CtrlP ~/Projects<CR>

"fzf
nnoremap <leader>// :Rg<CR>
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
tnoremap <ESC>   <C-\><C-n>

"vimwiki
nnoremap <leader>wbb :VimwikiRebuildTags!<cr>
nnoremap <leader>wbg :VimwikiGenerateTags<Space>
nnoremap <leader>wbh :VimwikiAll2HTML<cr>

"DokuVimKi
nnoremap <leader>ww :DokuVimKi<cr><c-w>c
nnoremap <leader>we :let @"=substitute(split(expand("%:r"),"pages\\")[1],'\\',':','g')<CR>:DWedit <C-R>"<cr><cr>
nnoremap <leader>wn :let @"=join(split(expand("%:r"),":")[:-2],':')<CR>:DWedit <C-R>"
"easymotion
" <Leader>f{char} to move to {char}
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" Move to line
map L <Plug>(easymotion-bd-jk)
nmap L <Plug>(easymotion-overwin-line)

"swap windows
nnoremap <silent> <C-w>w :call WindowSwap#EasyWindowSwap()<CR>

"search/replace of abolish
nmap <leader>s :%Subvert/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  COMMANDS                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" directory doesnt exist? Prompt to confirm one should be created
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir)
                    \   && (a:force
                    \       || input("'" . a:dir . "' does not exist. Create? [y/N]") =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

if active_rust
"Rust
  command! -bang -nargs=* FindSymbols
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always "(type|enum|struct|trait)[ \t]+([a-zA-Z0-9_]+)" -g "*.rs" -S | rg -S '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  command! -bang -nargs=* FindFunctions
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always "fn +([a-zA-Z0-9_]+)" -g "*.rs" | rg -g "*.rs" -S '.substitute(shellescape(<q-args>), " ", "|rg -g '*.rs' -S", ""), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:40%')
    \           : fzf#vim#with_preview('right:20%:hidden', '?'),
    \   <bang>0)

  command! -bang -nargs=* FindImpls
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always "impl([ \t\n]*<[^>]*>)?[ \t]+(([a-zA-Z0-9_:]+)[ \t]*(<[^>]*>)?[ \t]+(for)[ \t]+)?([a-zA-Z0-9_]+)" | rg -S '.substitute(shellescape(<q-args>), " ", "|rg ", ""), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
else
"C(++)
  command! -bang -nargs=* FindSymbols
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always "(typedef|using|enum|class|struct)[ \t]+([a-zA-Z0-9_]+)" -g "*.{hpp,h,cpp,c}" -S | rg -S '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)

  command! -bang -nargs=* FindFunctions
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always "^((::[[:space:]]*)?[A-Za-z_].*)$" -g "*.{hpp,h,cpp,c}" | rg -g "*.rs" -S '
    \.substitute(shellescape(<q-args>), " ", "|rg -g '*.rs' -S", ""), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:40%')
    \           : fzf#vim#with_preview('right:20%:hidden', '?'),
    \   <bang>0)


endif

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
                return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction


function! g:MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction


function! PlugCond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

