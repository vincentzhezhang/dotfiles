set t_Co=256
set nocompatible                    " be iMproved, required
filetype off                        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'ap/vim-css-color'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'elzr/vim-json'
Plugin 'ervandew/supertab'
Plugin 'flazz/vim-colorschemes'
Plugin 'godlygeek/tabular'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'klen/python-mode.git'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'mhinz/vim-startify'
Plugin 'morhetz/gruvbox'
Plugin 'mtscout6/vim-cjsx'
Plugin 'mxw/vim-jsx'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'plasticboy/vim-markdown'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-ruby/vim-ruby'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}


" FIXME
" Plugin 'justinmk/vim-sneak' " seems conflicting with other montion plugin
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

" Recommended settings from powerline
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" case-insensitive for some common commands
command! Q q
command! W w

" turn off Ex mode
map Q <Nop>
let loaded_matchparen = 1

" bind paste mode for ease of use
set pastetoggle=<F2>

" bind F5 to toggle background color
call togglebg#map("<F5>")

let g:airline_powerline_fonts=1
let base16colorspace=256  " Access colors present in 256 colorspace


" some OS detection and customization here, should bind some dark/light theme
" switcher hotkey
let s:uname = system("uname -s")
let s:hostname = system("uname -n")

if s:uname =~ "Darwin"
  colorscheme gruvbox
  set background=dark

elseif s:uname =~ "Linux"
  if s:hostname =~ "xps" " For XPS 13

    " FUCKING HATE XPS 13 ADAPTIVE BRIGHTNESS, IT'S A BUG NOT A FEATURE, DELL FIX IT!!!
    let s:sys_hour = system("date '+%k'")
    if s:sys_hour >= 9 && s:sys_hour <= 10 " might use dynamic sunset time?
      colorscheme solarized
      set background=light
    else
      colorscheme gruvbox
      set background=dark
    endif
  end
else
 " ignored
endif


" SYNTAX
syntax on

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set synmaxcol=1024 " Syntax coloring lines that are too long just slows down the world
set ttyfast " u got a fast terminal
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
highlight Search ctermfg=202 ctermbg=NONE cterm=bold,underline


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
let mapleader=" "

" some key remappings to resolve conflict brought by vim-multiple-cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_next_key            = '<S-n>'
let g:multi_cursor_prev_key            = '<S-p>'
let g:multi_cursor_skip_key            = '<S-x>'
let g:multi_cursor_quit_key            = '<Esc>'

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


" Rails specific plugin settings
vmap <Leader>z :call I18nTranslateString()<CR>
vmap <Leader>dt :call I18nDisplayTranslation()<CR>

" spell checking
set spell spelllang=en_us

set colorcolumn=80
set nowrap
set number

" what's this for anyway?
nnoremap <NL> i<CR><ESC>

" Window related settings
map <C-J> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_
nmap <A--> <C-w>-
nmap <A-=> <C-w>+


" Run current script!
nnoremap <F8> :!%:p<Enter>


" NERDTree
map <C-\> :NERDTreeFind<CR>

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "╖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif
