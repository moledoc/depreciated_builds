let mapleader = ";"
let maplocalleader = "\\"

"colorscheme slate
autocmd vimenter * colorscheme gruvbox
set background=dark

set hlsearch 					"highlight search.
set incsearch					"Do incremental searching.
set ic							"case insensitive search.
set relativenumber number 		"number and relative number.
set ruler						"show cursor position all the time.
set showcmd						"display incomplete commands.
set wildmenu					"display completion matches in status line.
set backspace=indent,eol,start	"Allow backspace over everything.
set complete+=kspell			"Add dict complete.
set tabstop=4					"Tab is 4 char long.
set shiftwidth=0				"Indent to tabstop with > or <.
"set timeout					"Time out for key codes.
"set timeoutlen=100				"Wait up to 100ms.
"set nowrap
set clipboard+=unnamedplus		"Copy to system clipboard.
set mouse=nv					"Enable mouse support in nvim

" Use same paste multiple times
xnoremap p pgvy

" No highlight
nmap <M-f> :noh<CR>

" Netrw tree for the current dir
nmap <M-t> :edit . <CR>

" fzf
nmap <M-p> :Files<CR>

" Vim bindings for moving; All are prepended with <C-w>
" moving - h,j,k,l 
" move - H,J,K,L 
" cycle - w
" vertical split - v, horizontal split - s

nnoremap <M-j> <C-w>j
nnoremap <M-h> <C-w>h
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Make new split according to vim keys
nnoremap <M-S-h> :vertical leftabove new<CR>
nnoremap <M-S-j> :belowright new<CR>
nnoremap <M-S-k> :leftabove new<CR>
nnoremap <M-S-l> :vertical belowright new<CR>

" close split
nnoremap <M-x> <C-w>c
" cycle split
nnoremap <M-c> <C-w>w

" nnoremap <M-Left>  <C-w><
" nnoremap <M-Down> <C-w>+
" nnoremap <M-Up> <C-w>-
" nnoremap <M-Right> <C-w>>

nnoremap <C-M-j> <C-w>+
" TODO:  for some reason <C-h> related keybinding does not want to work
nnoremap <C-M-h> <C-w>< 
nnoremap <C-M-k> <C-w>-
nnoremap <C-M-l> <C-w>>
nnoremap <C-M-=> <C-w>=

" Go to next/prev file
nnoremap <M-n> :bn<CR>
nnoremap <M-p> :bp<CR>


call plug#begin('~/.config/nvim/plugged')

Plug 'jalvesaq/Nvim-R'	", {'branch': 'stable'}
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'morhetz/gruvbox'

call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ncm2 additional config from https://github.com/ncm2/ncm2
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new line.
inoremap <expr> <CR> (pumvisible() ?  "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ?  "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : \<S-Tab>"

" wrap existing omnifunc
" Note that omnifunc does not run in background and may probably block the
" editor. If you don't want to be blocked by omnifunc too often, you could
" add 180ms delay before the omni wrapper:
"	'on_complete': ['ncm2#on_complete#delay', 180, " \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
	\ 'name' : 'css', 
	\ 'priority': 9,
	\ 'subscope_enable': 1,
	\ 'scope': ['css','scss'],
	\ 'mark': 'css',
	\ 'word_pattern': '[\w\-]+',
	\ 'complete_pattern': ':\s*',
	\ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
	\ })
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" R
command RStart let oldft=&ft | set ft=r | exe 'set ft='.oldft | let b:IsInRCode = function("DefaultIsInRCode") | normal <LocalLeader>rf
autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") |endif
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
autocmd FileType r map <F5> :!Rscript %<Enter>

"let R_disable_cmds = ['']

" Use __ to make <- .
let R_assign = 2

" Autocomplete
imap <M-Space> <C-X><C-O>



