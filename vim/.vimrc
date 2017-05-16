" TODO: extract variables into .vim/variables.vim
" TODO: add contional loading for pluggins
" TODO: try https://github.com/Chiel92/vim-autoformat

" Make use of bash utilities in vim
let $BASH_ENV = '~/.bash_utilities'

if !empty(glob('~/.vimrc.before'))
  source ~/.vimrc.before
end

source ~/.vim/variables.vim
source ~/.vim/functions.vim

" in case vim-plug is missing
call SetupVimPlug()

" temporary workaround for editorconfig-vim slowness
let g:EditorConfig_core_mode = 'external_command'

" TODO try to make a vim plugin to add descriptions for pluggins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-pug'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
" TODO file a pull request to fix loading for nvim, instead of hook
Plug 'ericpruitt/tmux.vim', { 'rtp': 'vim' }
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'klen/pylama'
Plug 'kewah/vim-stylefmt'
Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
Plug 'moll/vim-node'
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx'
Plug 'mileszs/ack.vim'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wakatime/vim-wakatime'
Plug 'wavded/vim-stylus'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

if has('nvim')
  " Window related settings
  " mitigate ctrl-h mess within some terminal
  nmap <BS> <C-W>h
else
  " Backwards compatibility for Vim, most of them are set by default in NeoVim
  " vint: -ProhibitSetNoCompatible
  set autoindent
  set autoread                   " Autoreload buffers, note this works differently, see :checktime
  set backspace=indent,eol,start " Make backspace behave more normally
  set encoding=utf-8             " Use UTF-8 encoding
  set hlsearch                   " Highlight search results
  set laststatus=2               " Always display the statusline in all windows
  set nocompatible               " be advanced
  set smarttab
  set softtabstop=0              " moved up from below
  set ttyfast
  syntax enable                  " Enable syntax highlight
end

" force utf-8 encoding cause we have multi-bytes chars here
scriptencoding utf-8

set autowrite                       " Save changes before switching buffers
set cursorline                      " Highlight the screen line of the cursor
set expandtab                       " Expand tabs to spaces
set list                            " Enable whitespace characters' display
set listchars=nbsp:¬,tab:»·,trail:· " Better whitespace symbols
set mouse=a                         " Grab mouse event within tmux
set nobackup                        " Be environment friendly
set noshowmode                      " Hide the default mode text
set noswapfile                      " Get rid of the annoying .swp file
set nowrap                          " Don't wrap on long lines
set nowritebackup                   " Write file in place
set number                          " Display line numbers on the left
set pastetoggle=<F2>                " bind paste mode for ease of use
set scrolloff=3                     " Have some context around the current line always on screen
set shiftwidth=2                    " Number of spaces to use for each step of (auto)indent
set showtabline=2                   " Always display the tabline, even if there is only one tab
set smartindent                     " Do smart auto indenting when starting a new line
set spell                           " Enable spell check
set spelllang=en_us                 " Use en_us for better collaboration
set splitbelow                      " Intuitively split to below when doing horizontal split
set splitright                      " Split to right when doing vertical split
set synmaxcol=256                   " Limit syntax color for long lines to improve rendering speed
set tabstop=2                       " Number of spaces that a <Tab> in the file counts for
set tags=./.tags,.tags;             " Use hidden tags files
set undodir=~/.vim/undo/            " Persistent undo directory
set undofile                        " Persistent undo
set updatetime=3000                 " Make update related events slightly faster

let &showbreak='↪ '     " Make soft wrap visually appealing

" TODO verify airline symbol display with Fantastique Sans Mono on different
" screen/font-size/dpi combinations, see left/right_sep below
" airline tweaks
let g:airline#extensions#branch#enabled                 = 0
let g:airline#extensions#bufferline#enabled             = 0
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline#extensions#tabline#enabled                = 1
let g:airline#extensions#whitespace#enabled             = 0
let g:airline_detect_spell                              = 0
let g:airline_inactive_collapse                         = 1
let g:airline_left_alt_sep                              = '│'
let g:airline_left_sep                                  = ''
let g:airline_powerline_fonts                           = 1
let g:airline_right_alt_sep                             = '│'
let g:airline_right_sep                                 = ''
let g:airline_section_x                                 = ''
let g:airline#parts#ffenc#skip_expected_string          = 'utf-8[unix]'


" make some commands case-insensitive
command! Q q
command! W w

" turn off Ex mode
map Q <Nop>
" turn off Recording mode
map q <Nop>

"
" auto commands that make your life easier
"
augroup general_enhancements
  autocmd!
  autocmd BufEnter * checktime % " make autoread behave intuitively

  if line('$') <= 999
    " temporary disabled during the refactoring period
    " autocmd BufWritePre * StripWhitespace
    autocmd BufReadPost * Neomake
    autocmd BufWritePost * Neomake
  endif

  " TODO should replace with proper partial linting, seem in progress now
  " see https://github.com/neomake/neomake/pull/1167
  if line('$') <= 100
  " this is kinda laggy for large files, will see if NeoMake support make on
  " partial of file
  " autocmd CursorHold * Neomake
  endif

  " make panes responsive
  autocmd VimResized * wincmd =

  autocmd InsertLeave,WinEnter * set cursorline
  autocmd InsertEnter,WinLeave * set nocursorline

  autocmd FocusLost * silent! syntax off
  autocmd FocusGained * silent! syntax on
augroup END

call PreferLocalNodeBinaries()

" should add proper ability detection
if empty($TERMINATOR_UUID) && empty($SESSION_TYPE)
  if exists('+termguicolors')
    set termguicolors
  endif
endif

" some OS detection and customization here, should bind some dark/light theme
" switcher hotkey
let s:uname = system('uname -s')
let s:hostname = system('uname -n')

" make search highlight more obvious
highlight Search ctermfg=202 ctermbg=NONE cterm=bold,underline

" change leader key
let g:mapleader=' '

" some key remappings to resolve conflict brought by vim-multiple-cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
" setup javascript-libraries-syntax
let g:used_javascript_libs = 'underscore,backbone,lodash,jquery'


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

" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" experimental key mapping for escape to normal mode
inoremap jk <Esc>
inoremap kj <Esc>

" simple spell correction
" TODO needs a better solution, including but not limited to:
" 1. Faster check
" 2. Dropdown with length limit
" 3. Use online service
noremap <space>c ea<C-x><C-s>

" Run the current script according to shebang!
nnoremap <F8> :!%:p<Enter>

nnoremap <silent> <CR> :nohlsearch<CR><CR>

" quick jump between recent two files
nnoremap <leader>b :b#<CR>

" Quick switch between numbers ruler
nnoremap <silent> <F12> :set number!<CR>

" Tagbar Toggle
nnoremap <silent> <C-t> :TagbarToggle<CR>

" quick edit .mimic
nnoremap <leader>V :e $MYVIMRC<CR>

" Break line at cursor
nnoremap <leader>j i<return><esc>

" NERDTree
map <C-\> :NERDTreeFind<CR> | wincmd p
let g:NERDTreeWinSize=30

" Nerd Commenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" NerdTree git plugin
" TODO: find better icons, the previous one looks too bulky and not
" consistent, thus replaced by ascii characters
let g:NERDTreeIndicatorMapCustom = {
    \ 'Modified'  : '*',
    \ 'Staged'    : '+',
    \ 'Untracked' : 'u',
    \ 'Renamed'   : '»',
    \ 'Unmerged'  : '≠',
    \ 'Dirty'     : '*',
    \ 'Clean'     : '✓',
    \ 'Unknown'   : '?'
    \ }

" Disable vim-json double quotes concealing as it's a bit awkward for me
let g:vim_json_syntax_conceal = 0

" disable folding on markdown which is annoying
let g:vim_markdown_folding_disabled = 1

" seamless vim/tmux navigation
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-,> :TmuxNavigatePrevious<CR>

" use ag if possible, for better performance
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" prefer eslint_d for better speed, note current version is patched by me
" let g:neomake_javascript_enabled_makers = ['eslint_d']

"
" neomake tweaks, note that gui color settings should also be set because +termguicolors is set
" TODO: should adapt color with different themes
"
augroup neomake_signs_customization
  au!
  autocmd ColorScheme *
        \ hi NeomakeErrorSign   guifg=#ff3300 guibg=#3a3a3a |
        \ hi NeomakeWarningSign guifg=#ff9900 guibg=#3a3a3a |
        \ hi NeomakeMessageSign guifg=#0099aa guibg=#3a3a3a |
        \ hi NeomakeInfoSign    guifg=#666666 guibg=#3a3a3a |
augroup END

let g:neomake_javascript_enabled_makers = ['eslint']

" handy selection of symbols
" suits of poker: ♠ ♥ ♣ ♦
" •
" table maker:    ─━
" block symbols:  ░▒▓
" white space:    ] [(em)
"
let g:neomake_error_sign = {
   \   'text': ' ━',
   \   'texthl': 'NeomakeErrorSign',
   \ }

let g:neomake_warning_sign = {
   \   'text': ' ━',
   \   'texthl': 'NeomakeWarningSign',
   \ }

let g:neomake_message_sign = {
   \   'text': ' ━',
   \   'texthl': 'NeomakeMessageSign',
   \ }

let g:neomake_info_sign = {
   \   'text': ' ━',
   \   'texthl': 'NeomakeInfoSign',
   \ }

" adaptive theme with extra fine tuning, also fast switching by F5
let g:luminance=system('get_luminance')
if g:luminance ==? 'high'
  call SunnyDays()
elseif g:luminance ==? 'low'
  call LateNight()
else
  call InDoor()
endif

if !empty(glob('~/.vimrc.after'))
  source ~/.vimrc.after
end

augroup on_startup
  autocmd VimEnter *
              \   if !argc()
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | endif
augroup END
