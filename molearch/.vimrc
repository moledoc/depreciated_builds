"""""""""""""""""""
" Define some stuff
"""""""""""""""""""

" Enable indentation, syntax and built-in plugins
filetype plugin indent on
syntax on

" Set color.
" Some defined color schemas can be found from /usr/share/vim/*/colors
color slate

" More efficient % search.
packadd! matchit

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80
augroup END

" Put these in an autocmd group, so that you can revert them with:
" ":augroup vimStartup | au! | augroup END"
augroup vimStartup
  au!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

augroup END


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


" Install ctags for this.
" Run :MakeTags.
" Now ^] will jump to tag, ^t jumps back in stack.
" Ambiguous tags g^]
command! MakeTags !ctags -R .

"" make a command to source .vimrc
"command! UpdateVim !source ~/.vimrc


"""""
" SET
"""""

""Set swap and persistant-undo files to given directory.
"set directory^=$HOME/.vim/tmp//
"set backupdir=./.backup,.,/tmp
"set directory=.,./.backup,/tmp
"set nobackup	" do not keep a backup file, use versions instead
"set backup	" keep a backup file (restore to previous version)
"set undofile	" keep an undo file (undo changes after closing)


" Highlight search
set hlsearch
" Use Vim settings, rather than Vi settings (much better!).
set nocompatible

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set path+=**		" Use with :find. Also, :b is useful. Basically fzf in vim
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Add dictionary complete.
" Experimenting on getting R functions to auto-compete without a plugin.
set complete+=kspell,s~/R/x86_64-pc-linux-gnu-library/4.0/*/INDEX

" Omnicomplete based on language
" Search /omincompl
setlocal omnifunc=syntaxcomplete#Complete

" Set line numbers
set number relativenumber

" Don't wrap lines.
"set nowrap

" Set search case insensitive.
set ic

" When running R or python with terminal reduces flickering (with this set up).
set lazyredraw

set mouse=nvi

" Tab is 4 char long.
set tabstop=4 
" Using < or > means to move until tabstop.
set shiftwidth=0

set columns=120

"""""
" LET 
"""""
"omnicompl
"let r_syntax_folding = 1
let r_syntax_hl_roxygen = 0

"<Leader> key
let mapleader=";"

" netrw config
let g:netrw_banner=0 " Disable banner
let g:netrw_liststyle=3 "tree view
let g:netrw_list_hide=netrw_gitignore#Hide() 
let g:netrw_browse_split=4 " Open in prior window
let g:netrw_altv=1 " Open split to right


""""""""""
"" PLUGINS
""""""""""
"call plug#begin('~/.vim/plugged')
"Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
"call plug#end()




""""""""""
" MAPPINGS
""""""""""

"""""
" map

" Run R,Python etc lines in the terminal like in RStudio
" add lazyredraw, so the line beginnings do not flicker when using
" the following keybindings.
map <C-\> "kyy:echo system("screen -S $(ls -R /run/screens/ \| tail -n -1) -X stuff ".escape(shellescape(@k),"$"))<CR>/^.<CR><CR>:noh<CR><CR>
vmap <C-\> "xy:echo system("screen -S $(ls -R /run/screens/ \| tail -n -1) -X stuff ".escape(shellescape(@x."\n"),"$"))<CR>/^.<CR><CR>:noh<CR><CR>
" Run starting from cursor, select to the end of the line.
map \ v$<C-\>

" Set spellcheck under F6.
map <F6> :setlocal spell! spelllang=en_us<CR>

" Don't use Ex mode, use Q for formatting.
" Revert with ":unmap Q".
map Q gq

""""""""""""""""""
" Command mode map

" use same paste for multiple times
xnoremap p pgvy


""""""""""""""""
"normal mode map

" Map copy to Ctrl-c/Ctrl-Shift-c and paste to Ctrl-p/Ctrl-Shift-p.
" The + register corresponds to Ctrl-c and Ctrl-p.
" The * register corresponds to the Mouse Button 2.
nnoremap <C-c> "+y
nnoremap <C-p> "+p

nnoremap <Leader>c "*y
nnoremap <Leader>p "*p

" moving - h,j,k,l 
" cycle - w
" vertical split - v, horisontal split - s
" resize - <,>,+,-,= (left,right,up,down,default)
" Map Ctrl+w to just use <Leader> in case of moving (h,j,k,l) 
" Map Ctrl+(h,l,j,k) as  resizing (<,>,+,-,=) (based as top left pane.
" Map Ctrl+w+c (close split) to Ctrl+w.
" Example: instead of Ctrl+w+j, now <C-j> does the same.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <F9>  <C-w><
nnoremap <F10> <C-w>+
nnoremap <F11> <C-w>-
nnoremap <F12> <C-w>>

nnoremap <C-x> <C-w>c

" Use ctrl-f and ctrl-F when searches from multiple files using grep
nnoremap <C-n> :cnext<Enter>
nnoremap <C-m> :cprevious<Enter>


"""""""""""""""""
" Insert mode map

" auto-complete parenthesis and quotes
inoremap <Leader>( ()<Esc>i
"inoremap { {}<Esc>o<Tab>
"inoremap {<CR> {<CR>}<Esc>O<Tab>
inoremap <Leader>{<CR> {<CR>}<Esc>O
inoremap <Leader>[ []<Esc>i
"inoremap < <><Esc>i 
inoremap <Leader>' ''<Esc>i
inoremap <Leader>" ""<Esc>i

" Use tab to omni-complete
inoremap <Leader><Tab> <C-x><C-o>" 

" When pressed space twice the cursor jumps to next location of <++>. 
""  "_ means delete it and put it into empty buffer so if we paste later it  won't be this.
inoremap <Space><Space> <Esc>/<++><Enter>"_c4l

" Add <++> to current place in work, so that if something before needs
" changing, I can easily continue where I left off.
inoremap ;; <++>


" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>



""""""""""""""
" Autocommands
""""""""""""""
"omincompl

au Syntax r runtime! syntax/r.vim
au Syntax python runtime! syntax/python.vim
au Syntax cpp runtime! syntax/cpp.vim
au Syntax c runtime! syntax/c.vim

autocmd BufWritePost config.h,config.def.h !sudo make clean install
" autocmd BufWritePost ~/.zshrc,~/.zsh_aliases !source ~/.zshrc

""""""""""""""
" More general

"" Set F4 to open the editing file in pdf
autocmd FileType rmd,nroff,tex map <F4> :!echo<space>%<space>\|<space>sed<space>'s/\.[^.]*$//'<space>\|<space>xargs<space>-I<space>file<space>zathura<space>"file".pdf<space>&<Enter><Enter>

""""""
"Groff

" Open temp pdf-s in zathura w/ F3 in groff.
autocmd Filetype nroff map <F3> :!echo<space>%<space>\|<space>xargs<space>-I<space>file<space>groff<space>-ms<space>file<space>-Tpdf<space>\|<space>zathura<space>-<space>&<Enter><Enter>

" Open pdf in zathura w/ F4 in groff. 
autocmd Filetype nroff map <F4> :!echo<space>%<space>\|<space>sed<space>'s/\.[^.]*$//'<space>\|<space>xargs<space>-I<space>file<space>zathura<space>"file".pdf<space>&<Enter><Enter>

" Update zathura document with F5 in groff.
autocmd Filetype nroff map <F5> :!echo<space>%<space>\|<space>sed<space>'s/\.[^.]*$//'<space>\|<space>xargs<space>-I<space>file<space>sh<space>~/.scripts/groff_pdf<space>file<Enter><Enter>

""""
"Rmd

"" Set F5 to knit .Rmd.
autocmd FileType rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<Enter>
" one can add <Enter> to end of previous line, if one is certain the code is correct.

"" Set F5 to run .R
autocmd FileType r map <F5> :!Rscript %<Enter>


"" function in R and Rmd
autocmd FileType rmd,r inoremap <C-f> function(){<Esc>o<++><Esc>o}<Esc>o<++><Esc>3k0f(ci(

"" Make title space
autocm FileType rmd inoremap ;hd ---<Esc>otitle: <Esc>oauthor: Meelis Utt<Esc>odate: <++><Esc>ooutput: pdf_document<Esc>o---<Esc>o<Esc>o<++><Esc>6kA

"" Make setup chunk
autocmd FileType rmd inoremap ;stp ```{r setup, include = FALSE}<Esc>oknitr::opts_chunk$set(echo = TRUE)<Esc>olibrary(dplyr)<Esc>o```<Esc>o<Esc>o<++><Esc>2kO

"" chunks for Rmd code
"" R code
autocmd FileType rmd inoremap ;ch <Enter>```{r}<Esc>o```<Esc>o<++><Esc>kO
" autocmd FileType rmd inoremap <C-i> ```{r}<Esc>o```<Esc>o<++><Esc>kO

"" Python code
autocmd FileType rmd inoremap ;pch <Enter>```{python}<Esc>o```<Esc>o<++><Esc>kO

""""""""""
" C/C++/C#
" TODO

""""
" py

" Set F5 to run the python code.
autocmd FileType python map <F5> :!python<Space>%<Enter>


"""""
" tex

" Update zathura document with F5 in tex.
autocmd Filetype tex map <F5> :!echo<space>%<space>\|<space>xargs<space>-I<space>{}<space>pdflatex<space>"{}"<Enter>

" Shortcuts for .tex files (also can use in .Rmd).
"" a in from on aen, ait, aeq means en, it or eq with asterisk (*)
autocmd FileType tex,rmd inoremap ;fr \frac{}{<++>}<++><Space><Esc>Fcla
autocmd FileType tex,rmd inoremap ;en \begin{enumerate}<Esc>o\end{enumerate}<Esc>o<++><Esc>kO\item 
autocmd FileType tex,rmd inoremap ;aen \begin{enumerate*}<Esc>o\end{enumerate*}<Esc>o<++><Esc>kO\item 
autocmd FileType tex,rmd inoremap ;it \begin{itemize}<Esc>o\end{itemize}<Esc>o<++><Esc>kO\item 
autocmd FileType tex,rmd inoremap ;ait \begin{itemize*}<Esc>o\end{itemize*}<Esc>o<++><Esc>kO\item 
autocmd FileType tex,rmd inoremap ;eq \begin{equation}<Esc>o\end{equation}<Esc>o<++><Esc>kO\label{<++>}<Esc>F\i
autocmd FileType tex,rmd inoremap ;aeq \begin{equation*}<Esc>o\end{equation*}<Esc>o<++><Esc>kO	
autocmd FileType tex,rmd inoremap ;al \begin{align*}<Esc>o\end{align*}<Esc>o<++><Esc>kO
autocmd FileType tex,rmd inoremap ;$ $$<Space><++><Esc>F$i
autocmd FileType tex,rmd inoremap ;_ _{}<++><Esc>F}i
autocmd FileType tex,rmd inoremap ;^ ^{}<++><Esc>F}i
autocmd FileType tex 	 inoremap ;sum \sum_{}^{<++>}<++><Esc>F^hci{
autocmd FileType tex 	 inoremap ;prod \prod_{}^{<++>}<++><Esc>F^hci{
autocmd FileType tex 	 inoremap ;int \int_{}^{<++>}<++><Esc>F^hci{
