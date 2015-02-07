if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

set nocompatible                    " be iMproved, required
filetype off                        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim' "v
Plugin 'L9' "v
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter' "v
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim' " should be alright with airline
Plugin 'elzr/vim-json' " v
Plugin 'flazz/vim-colorschemes'
Plugin 'kchmck/vim-coffee-script' "v
Plugin 'kien/ctrlp.vim'
Plugin 'morhetz/gruvbox'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'othree/javascript-libraries-syntax.vim' "v
Plugin 'godlygeek/tabular'
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
Plugin 'Lokaltog/vim-easymotion'
" Plugin 'justinmk/vim-sneak'
call vundle#end()

" turn back on after vundle
filetype plugin indent on

""""""""""""

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

set background=dark

if !has("gui_running")
  let g:gruvbox_italic=0
endif

if has("gui_running")
  set guifont=Source\ Code\ Pro\ for\ Powerline\ 12
endif
let g:airline_powerline_fonts=1

colorscheme gruvbox

" Turn syntax highlighting on
syntax on

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024
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

" setup javascript-libraries-syntax
let g:used_javascript_libs = 'underscore,backbone'

" change leader key
let mapleader=","

" some key remappings to resolve conflict brought by vim-multiple-cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<S-n>'
let g:multi_cursor_prev_key='<S-p>'
let g:multi_cursor_skip_key='<S-x>'
let g:multi_cursor_quit_key='<Esc>'

" scss lint
" temporarly remove due to the it's bug
" let g:syntastic_scss_checkers = ['scss_lint']

" GUI related settings
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=l
set guioptions-=R
set guioptions-=r
:nnoremap <NL> i<CR><ESC>

" start NERDTree by default
"
map <C-n> :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>
