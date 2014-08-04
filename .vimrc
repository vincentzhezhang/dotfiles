if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set nocompatible                    " be iMproved, required
filetype off                        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'elzr/vim-json'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/csapprox'
Plugin 'justinmk/vim-sneak'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'morhetz/gruvbox'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-cucumber'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-ruby'
call vundle#end()

" turn back on after vundle
filetype plugin indent on

""""""""""""
let g:airline_powerline_fonts=1

" enable per-project .vimrc files
set exrc
" Only execute safe per-project vimrc commands
set secure

" needs cleanup
set cursorline
set list
set listchars=nbsp:¬,tab:»·,trail:·

" case-insensitive for some common commands
command! Q q
command! W w

" turn off Ex mode
map Q <Nop>
let loaded_matchparen = 1

" bind paste mode for ease of use
set pastetoggle=<F2>

" colortheme
set background=dark
" colorscheme solarized
if !has("gui_running")
  let g:gruvbox_italic=0
endif
colorscheme gruvbox
 
" Turn syntax highlighting on
syntax on

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=256
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems
 
" Highlight search results
set hlsearch
 
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

" start NERDTree by default
map <C-n> :NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
