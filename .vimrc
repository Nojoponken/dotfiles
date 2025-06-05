" Welcome to my Vim config!

" Colorscheme
colorscheme dim
set tm=1 " Removes lag from escape
let g:netrw_banner=0
let g:netrw_liststyle=3

packadd! matchit
runtime! ftplugin/man.vim

" Relative line numbers
set number
" set relativenumber 
set wildmenu

" Syntax
filetype indent plugin on
syntax on
autocmd filetype * setlocal fo-=cro
autocmd filetype org setlocal wrap spell
autocmd filetype org nn k gk
autocmd filetype org nn j gj
autocmd filetype netrw nn c :Ntree<cr>

" Wrap
set nowrap
set linebreak
set smoothscroll

" Search
set incsearch
set hlsearch

" Tabs
set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=8

" Bindings
inoremap  
inoremap  <nop>
nnoremap <space> :
nnoremap <cr> 
nnoremap <esc>n :cn<cr>
nnoremap <esc>p :cp<cr>
nnoremap <esc>o :cope<cr>
nnoremap <esc>c :ccl<cr>
nnoremap <esc>f :FZF<cr>

nnoremap <esc>h [c
nnoremap <esc>l ]c

command! Diff :vert diffs %:p.diff | silent r # | winc p
nnoremap <esc>b :bd! #<cr>

" Alt moves line
nnoremap <esc>k mm:m -2<cr>`m
nnoremap <esc>j mm:m +1<cr>`m
vnoremap <esc>k :m '<-2<cr>gv
vnoremap <esc>j :m '>+1<cr>gv


" Dotnet
autocmd BufRead *.cs set errorformat=\ %#%f(%l\\\,%c):\ %m
autocmd BufRead *.cs set makeprg=dotnet\ run

" History
set viminfo='10,<100,:100,%,n~/.vim/.viminfo


" Styled and colored underline support
let &t_AU = "\e[58:5:%dm"
let &t_8u = "\e[58:2:%lu:%lu:%lum"
let &t_Us = "\e[4:2m"
let &t_Cs = "\e[4:3m"
let &t_ds = "\e[4:4m"
let &t_Ds = "\e[4:5m"
let &t_Ce = "\e[4:0m"
" Strikethrough
let &t_Ts = "\e[9m"
let &t_Te = "\e[29m"
" Truecolor support
let &t_8f = "\e[38:2:%lu:%lu:%lum"
let &t_8b = "\e[48:2:%lu:%lu:%lum"
let &t_RF = "\e]10;?\e\\"
let &t_RB = "\e]11;?\e\\"
" Bracketed paste
let &t_BE = "\e[?2004h"
let &t_BD = "\e[?2004l"
let &t_PS = "\e[200~"
let &t_PE = "\e[201~"
" Cursor control
let &t_RC = "\e[?12$p"
let &t_SH = "\e[%d q"
let &t_RS = "\eP$q q\e\\"
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[1 q"
let &t_VS = "\e[?12l"
" Focus tracking
let &t_fe = "\e[?1004h"
let &t_fd = "\e[?1004l"
execute "set <FocusGained>=\<Esc>[I"
execute "set <FocusLost>=\<Esc>[O"
" Window title
let &t_ST = "\e[22;2t"
let &t_RT = "\e[23;2t"

" vim hardcodes background color erase even if the terminfo file does
" not contain bce. This causes incorrect background rendering when
" using a color theme with a background color in terminals such as
" kitty that do not support background color erase.
let &t_ut=''
