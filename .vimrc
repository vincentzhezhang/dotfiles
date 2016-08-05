" TODO: try fzf, vim-easy-align
" TODO: extract variables into .vim/variables.vim
" set useful variables
source ~/.vim/variables.vim
" load helper functions
source ~/.vim/functions.vim
set termguicolors
filetype off

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has('nvim'))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has('termguicolors'))
    set termguicolors
  endif
endif

call plug#begin('~/.vim/bundle')
Plug 'L9'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'digitaltoad/vim-pug'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'gregsexton/gitv'
Plug 'hail2u/vim-css3-syntax'
Plug 'kchmck/vim-coffee-script'
Plug 'klen/python-mode'
Plug 'Lokaltog/vim-easymotion'
Plug 'lifepillar/vim-solarized8'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
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
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ruby/vim-ruby', { 'do': function('InstallRubySupport') }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zenbro/mirror.vim'
call plug#end()

" General formatting config
set encoding=utf-8              " Use UTF-8 encoding
set fileencodings=utf-8
scriptencoding utf-8
set autoindent
set autoread                    " Autoreload buffers
set autowrite                   " Save changes before switching buffers
set backspace=indent,eol,start  " Make backspace behave more normally
set expandtab                   " Expand tabs to spaces
set nobackup                    " Don't backup
set noswapfile                  " Don't use swap files (.swp)
set nowrap                      " Don't wrap lines
set nowritebackup               " Write file in place
set number                      " Show line numbers
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=0
set tabstop=2

" needs cleanup
set cursorline
set list
set listchars=nbsp:¬,tab:»·,trail:·
syntax enable         " Enable syntax highlight
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
" enable per-project .vimrc files
set exrc
" Only execute safe per-project vimrc commands
set secure
" Recommended settings from powerline
set laststatus=2        " Always display the statusline in all windows
set showtabline=2       " Always display the tabline, even if there is only one tab
set noshowmode          " Hide the default mode text
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" settings for gui
if has('gui_running')
  set guifont=Input\ Mono:h16
endif

" case-insensitive for some common commands
command! Q q
command! W w

" turn off Ex mode
map Q <Nop>
" turn off Recording mode
map q <Nop>

let loaded_matchparen = 1
" strip trailing whitespace before save
"
augroup cleanup
  autocmd!
  autocmd BufWritePre * StripWhitespace
augroup END

" TODO: migrate from function keys to other combination as I am going to use
" smaller keyboard layout
" bind paste mode for ease of use
set pastetoggle=<F2>
" Quick switch between numbers ruler
noremap <silent> <F12> :set number!<CR>

" Base16 colorscheme plugin settings
let base16colorspace=256  " Access colors present in 256 colorspace
" some OS detection and customization here, should bind some dark/light theme
" switcher hotkey
let s:uname = system('uname -s')
let s:hostname = system('uname -n')
let s:sys_hour = system("date '+%k'")
" TODO: dynamic day/night range from system or external API
let s:sunrise = 6
let s:sunset = 18
if s:uname =~? 'Darwin'
  call DarkSide()
elseif s:uname =~? 'Linux'
  if s:hostname =~? 'xps' " For XPS 13
    if s:sys_hour >= s:sunrise && s:sys_hour <= s:sunset
      call LightSide()
    else
      call DarkSide()
    endif
  end
else
 " ignored
endif
if exists('+colorcolumn')
  let &colorcolumn='80,'.join(range(120,360),',')
  if s:sys_hour >= s:sunrise && s:sys_hour <= s:sunset
    highlight ColorColumn ctermbg=7
  else
    highlight ColorColumn ctermbg=237
  end
endif

" Syntastic recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_vim_checkers = ['vint']
set synmaxcol=1024  " limit syntax color for long lines
set ttyfast         " fast terminal
set lazyredraw      " to avoid scrolling problems
" Have some context around the current line always on screen
set scrolloff=3
" Highlight search results
set hlsearch
highlight Search ctermfg=202 ctermbg=NONE cterm=bold,underline

augroup ruby_rails
  " Make those debugger statements painfully obvious
  au BufEnter *.rb syn match error contained "\<binding.pry\>"
  au BufEnter *.rb syn match error contained "\<debugger\>"
augroup END

" language specific indentation settings
augroup indentations
  autocmd FileType c      setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType cpp    setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" change leader key
let mapleader=' '

" some key remappings to resolve conflict brought by vim-multiple-cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_next_key            = '<S-n>'
let g:multi_cursor_prev_key            = '<S-p>'
let g:multi_cursor_skip_key            = '<S-x>'
let g:multi_cursor_quit_key            = '<Esc>'
" JavaScript settings
let g:javascript_conceal_function   = 'ƒ'
let g:javascript_conceal_null       = 'ø'
let g:javascript_conceal_this       = '@'
let g:javascript_conceal_return     = '⇚'
let g:javascript_conceal_undefined  = '¿'
let g:javascript_conceal_NaN        = 'ℕ'
let g:javascript_conceal_prototype  = '¶'
let g:javascript_conceal_static     = '•'
let g:javascript_conceal_super      = 'Ω'
" setup javascript-libraries-syntax
let g:used_javascript_libs = 'underscore,backbone'

" TypeScript settings
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

" jsx settings if want to have jsx in side js
let g:jsx_ext_required = 0

" Git key mapping
nnoremap <space>gb :Gblame<CR>
nnoremap <space>gs :Gstatus<CR>

" experimental key mapping for escape to normal mode
inoremap jk <Esc>

" spell checking, en_us for better collaboration
set spell spelllang=en_us

" what's this for anyway?
nnoremap <NL> i<CR><ESC>

" Window related settings
map <C-j> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_

" Run current script!
nnoremap <F8> :!%:p<Enter>

" Clean highlight when esc is pressed
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" Break line, note this catches control + enter in my terminal, ymmv
nnoremap <C-J> i<return><esc>
" Break line using ctrl + enter, note this maps to ^J in Ubuntu,
" but in MacOS, it maps to ^M
if s:uname =~? 'Darwin'
  nnoremap <C-M> i<return><esc>
elseif s:uname =~? 'Linux'
  nnoremap <C-J> i<return><esc>
else
  " ignored for now
endif

" NERDTree
map <C-\> :NERDTreeFind<CR>
let g:NERDTreeWinSize=30
let g:NERDTreeIndicatorMapCustom = {
    \ 'Modified'  : '✹',
    \ 'Staged'    : '✚',
    \ 'Untracked' : '✭',
    \ 'Renamed'   : '➜',
    \ 'Unmerged'  : '╖',
    \ 'Dirty'     : '✗',
    \ 'Clean'     : '✔︎',
    \ 'Unknown'   : '?'
    \ }

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
augroup on_startup
  autocmd VimEnter *
              \   if !argc()
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | endif
augroup END
