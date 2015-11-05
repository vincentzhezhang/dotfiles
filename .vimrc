set t_Co=256
set nocompatible                    " be iMproved, required
filetype off                        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ap/vim-css-color'
Plugin 'bling/vim-airline'
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'elzr/vim-json'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode.git'
Plugin 'morhetz/gruvbox'
Plugin 'mtscout6/vim-cjsx'
Plugin 'mxw/vim-jsx'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'rizzatti/dash.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-ruby/vim-ruby'
" Plugin 'justinmk/vim-sneak' " seems conflicting with other montion plugin
"
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

let g:airline_powerline_fonts=1
let base16colorspace=256  " Access colors present in 256 colorspace

" some OS detection and customization here
if has("gui_running")
  let s:uname = system("uname -s")
  if s:uname =~ "Darwin"
    set guifont=Source\ Code\ Pro\ for\ Powerline:h12
  else
    " let s:dpi = system("xrdb -query -all | grep dpi | awk '{ print $(NF) }'")
    " workaround since dpi is not correctly detected
    let s:hostname = system("uname -n")
    if s:hostname =~ "xps"
      set guifont=Source\ Code\ Pro\ for\ Powerline\ 12
      " FUCKING HATE XPS 13 ADAPTIVE BRIGHTNESS, DELL FIX IT PLZ
      let s:sys_hour = system("date +'%k'")
      if s:sys_hour >= 9 && s:sys_hour <= 17
        colorscheme solarized
        set background=light
      endif
    else
      set guifont=Source\ Code\ Pro\ for\ Powerline\ 10
    end
  endif

else

  let g:gruvbox_italic=1
endif

colorscheme gruvbox
set background=dark


" nmap <C-F9> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
" nmap <C-F10> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

" Turn syntax highlighting on
syntax on

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1024
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

function! ToggleSyntax()
  if exists("g:syntax_on")
    syntax off
  else
    syntax enable
  endif
endfunction

nmap <silent> <C-F12> :call ToggleSyntax()<CR>

" Highlight search results
set hlsearch

" Make backspce behave more normally
set backspace=indent,eol,start

" Turn on automatic indenting
set smartindent

" Set tabs
set tabstop=2 shiftwidth=2 softtabstop=0 smarttab expandtab
" language specific settings
autocmd FileType python setlocal tabstop=4 shiftwidth=4

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

" JavaScript settings
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "•"
let g:javascript_conceal_super      = "Ω"

" jsx settings
" if want to have jsx in side js
let g:jsx_ext_required = 0
" only for compatibility of pre-v0.12 react
" let g:jsx_pragma_required = 1

" scss lint
" temporarly remove due to the it's bug
" let g:syntastic_scss_checkers = ['scss_lint']


" spell checking
set spell spelllang=en_gb

" 80 column reminder
set colorcolumn=80

" no soft wrap
set nowrap

" GUI related settings
set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=l
set guioptions-=R
set guioptions-=r
:nnoremap <NL> i<CR><ESC>

" Window related settings
map <C-J> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_
nmap <A--> <C-w>-
nmap <A-=> <C-w>+

" Run current script!
nnoremap <F8> :!%:p<Enter>

" start NERDTree by default
"
map <C-n> :NERDTreeFind<CR>
