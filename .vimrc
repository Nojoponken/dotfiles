" Welcome to my Vim config!

"" Syntax
filetype plugin on
filetype indent on
syntax on

""" Tabs
set expandtab
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=8

"" Line numbers
set number
set relativenumber

"" Bindings
nnoremap <space> :
" nnoremap  :cn<cr> 
" nnoremap  :cp<cr>

"" Fuzzy find files
set path+=**
set wildmenu

"" Search
set incsearch
set hlsearch

"" Tags command
command! MakeTags !ctags -R .

"" History
set viminfo='10,<100,:100,%,n~/.vim/.viminfo
