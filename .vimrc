if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

" set nocompatible setting makes vim behave in a more useful way
set nocompatible
" required to be off before vundle
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""""""""""""""""""""""""""""""""""
"          Bundles start         "
""""""""""""""""""""""""""""""""""
" let vundle handle itself
Bundle 'gmarik/vundle'

" original repos on GitHub
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'mattn/emmet-vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'slim-template/vim-slim.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-surround'
Bundle 'Valloric/YouCompleteMe'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'

" non-GitHub repos
Bundle 'git://git.wincent.com/command-t.git'

""""""""""""""""""""""""""""""""""
"          Bundles ends          "
""""""""""""""""""""""""""""""""""

" needs cleanup

set cursorline
set list
set listchars=nbsp:¬,tab:»·,trail:·


" case-insensitive for some common commands
command! Q q
command! W w

" turn off Ex mode
map Q <Nop>
let loaded_matchparen =1

" bind paste mode for ease of use
set pastetoggle=<F2>

" turn back on after vundle 
filetype plugin indent on

" colortheme
set background=dark
colorscheme solarized
 
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

" change leader key
let mapleader=","

" some magic for better tabs
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-n> :tabnew<CR>

" some tweak for CommandT
set wildignore+=.*,vendor/*,public/*

" start NERDTree by default
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
