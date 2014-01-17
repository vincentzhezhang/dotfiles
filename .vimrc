if $COLORTERM == 'gnome-terminal'
  set t_Co=16
endif

"pathogen
execute pathogen#infect()

"colortheme
let g:rehash256 = 1
set background=dark
colorscheme solarized

"set nocompatible setting makes vim behave in a more useful way
set nocompatible
 
" Enable filetype-specific indenting and plugins
filetype plugin indent on
 
" Turn syntax highlighting on
syntax on
 
" Highlight search results
set hlsearch
 
" Turn on line numbering
set number
 
" Make backspce behave more normally
set backspace=indent,eol,start
 
" Turn on automatic indenting
set smartindent
 
" Insert space characters whenever the tab key is pressed
set expandtab
 
" Set tabs
set tabstop=2
set shiftwidth=2

" some magic for better tabs
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

autocmd VimEnter * NERDTree | wincmd p
