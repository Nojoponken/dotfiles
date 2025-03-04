" Welcome to my Vim config!

let g:netrw_liststyle=3

"" Syntax
filetype plugin on
filetype indent on
syntax on

"" Tabs
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

"" Fuzzy find files
set path+=**
set wildmenu

"" Search
set incsearch
set hlsearch

"" Tags command
command! MakeTags !ctags -R .

"" Dotnet
set errorformat=\ %#%f(%l\\\,%c):\ %m
set makeprg=dotnet\ run

"" Spell
set spell
highlight clear SpellBad
highlight clear SpellRare
highlight clear SpellCaps
highlight clear SpellLocal

"" History
set viminfo='10,<100,:100,%,n~/.vim/.viminfo
