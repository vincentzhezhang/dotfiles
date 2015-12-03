set t_Co=256
set nocompatible                    " be iMproved, required

" replace Vundle with vim-plug for the sake of active development/support
call plug#begin('~/.vim/bundle')
Plug 'gmarik/Vundle.vim'
Plug 'L9'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'https://github.com/klen/python-mode.git'
Plug 'Lokaltog/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'mtscout6/vim-cjsx'
Plug 'mxw/vim-jsx'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'slim-template/vim-slim'
Plug 'terryma/vim-multiple-cursors'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-ruby/vim-ruby'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zenorocha/dracula-theme', {'rtp': 'vim/'}
" Plug 'justinmk/vim-sneak' " FIXME seems conflicting with other montion plugin
call plug#end()


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

" strip trailing whitespaces before save
autocmd BufWritePre * StripWhitespace


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
