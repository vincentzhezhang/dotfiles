set t_Co=256
set nocompatible

call plug#begin('~/.vim/bundle')
Plug 'L9'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'floobits/floobits-neovim'
Plug 'godlygeek/tabular'
Plug 'gregsexton/gitv'
Plug 'hail2u/vim-css3-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'klen/python-mode'
Plug 'Lokaltog/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'mtscout6/vim-cjsx'
Plug 'mxw/vim-jsx'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'Raimondi/delimitMate'
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
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" case-insensitive for some common commands
command! Q q
command! W w

" turn off Ex mode
map Q <Nop>
" turn off Recording mode
map q <Nop>
let loaded_matchparen = 1

" strip trailing whitespace before save
autocmd BufWritePre * StripWhitespace

" bind paste mode for ease of use
set pastetoggle=<F2>

function LightSide()
  colorscheme solarized
  let g:airline_theme='solarized'
  set background=light
endfunction

function DarkSide()
  colorscheme gruvbox
  let g:airline_theme='zenburn'
  set background=dark
endfunction

function SwitchSide()
  let bg = &background
  if bg == 'dark'
    call LightSide()
  elseif bg == 'light'
    call DarkSide()
  else
    " ignored
  end
endfunction

" some quick color tweak
map <F5> :call SwitchSide()<CR>

let base16colorspace=256  " Access colors present in 256 colorspace


" some OS detection and customization here, should bind some dark/light theme
" switcher hotkey
let s:uname = system("uname -s")
let s:hostname = system("uname -n")

if s:uname =~ "Darwin"
  call DarkSide()

elseif s:uname =~ "Linux"
  if s:hostname =~ "xps" " For XPS 13

    " FUCKING HATE XPS 13 ADAPTIVE BRIGHTNESS, IT'S A BUG NOT A FEATURE, DELL FIX IT!!!
    let s:sys_hour = system("date '+%k'")
    " might use a more adaptive time or even sunset time?
    if s:sys_hour >= 7 && s:sys_hour <= 17
      call LightSide()
    else
      call DarkSide()
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

set synmaxcol=1024  " limit syntax color for long lines
set ttyfast         " fast terminal
set lazyredraw      " to avoid scrolling problems

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


" Default format config
set smartindent
set colorcolumn=80
set tabstop=2
set shiftwidth=2
set softtabstop=0
set smarttab
set expandtab

" language specific indentation settings
autocmd FileType c      setlocal tabstop=4 shiftwidth=4
autocmd FileType cpp    setlocal tabstop=4 shiftwidth=4
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType ruby   setlocal colorcolumn=100

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


" Git key mapping
map <C-`> :Gblame<CR>

" experimental key mapping
inoremap jk <Esc>

" spell checking
set spell spelllang=en_us

set nowrap
set number

" what's this for anyway?
nnoremap <NL> i<CR><ESC>

" Window related settings
map <C-j> <C-W>j<C-W>_
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
