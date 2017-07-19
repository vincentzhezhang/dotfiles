" TODO: extract more variables into .vim/variables.vim
" TODO: add contional loading for pluggins
" TODO: try https://github.com/Chiel92/vim-autoformat
" TODO: fix cursorline caused slowness, in fast scroll and gblame

" Make use of bash utilities in vim
let $BASH_ENV = '~/.bash_utilities'

if !empty(glob('~/.vimrc.before'))
  source ~/.vimrc.before
end

source ~/.vim/variables.vim
source ~/.vim/functions.vim

" temporary workaround for editorconfig-vim slowness
let g:EditorConfig_core_mode = 'external_command'

" TODO try to make a vim plugin to add descriptions for pluggins
call SetupVimPlug() " in case vim-plug is missing
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-pug'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json', { 'for': ['json'] }
Plug 'ericpruitt/tmux.vim', { 'rtp': 'vim' }
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color', { 'for': ['css', 'sass', 'scss'] }
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
Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx'] }
Plug 'mileszs/ack.vim'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'plasticboy/vim-markdown'
Plug 'Raimondi/delimitMate'
Plug 'Rykka/riv.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wakatime/vim-wakatime'
Plug 'wavded/vim-stylus'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons' " This has to be put after all supported plugins
call plug#end()

if has('nvim')
  " Window related settings
  " mitigate ctrl-h mess within some terminal
  nmap <BS> <C-W>h
else
  " TODO check out VIM8 see if any default option values been changed
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
set expandtab                       " Expand tabs to spaces
set fillchars+=vert:\               " Make vertical split bar prettier
" set fillchars+=vert:\│              " Make vertical split bar prettier
set ignorecase                      " Make search case-insensitive
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
set scrolloff=6                     " Have some context around the current line always on screen
set shiftwidth=2                    " Number of spaces to use for each step of (auto)indent
set showtabline=2                   " Always display the tabline, even if there is only one tab
set smartcase                       " Make search case-insensitive smart!
set smartindent                     " Do smart auto indenting when starting a new line
set spell                           " Enable spell check
set spelllang=en_us                 " Use en_us for better collaboration, sorry en_gb
set splitbelow                      " Intuitively split to below when doing horizontal split
set splitright                      " Split to right when doing vertical split
set synmaxcol=128                   " Limit syntax color for long lines to improve rendering speed
set tabstop=2                       " Number of spaces that a <Tab> in the file counts for
set tags=./.tags,.tags;             " Use hidden tags files
set undodir=~/.vim/undo/            " Persistent undo directory
set undofile                        " Persistent undo
set updatetime=1000                 " Make update related events slightly faster

let &showbreak='↪ '     " Make soft wrap visually appealing

" TODO verify airline symbol display with Fantastique Sans Mono on different
" screen/font-size/dpi combinations, see left/right_sep below
" airline tweaks
call airline#parts#define_accent('file', 'yellow')

let g:airline#extensions#tabline#enabled       = 1
let g:airline#extensions#whitespace#enabled    = 0
let g:airline_detect_spell                     = 0
let g:airline_inactive_collapse                = 1
let g:airline_left_alt_sep                     = '│'
let g:airline_left_sep                         = ''
let g:airline_powerline_fonts                  = 1
let g:airline_right_alt_sep                    = '│'
let g:airline_right_sep                        = ''
let g:airline_section_b                        = ''
let g:airline_section_x                        = ''
let g:airline_section_z                        = '%v : %l/%L'
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
let g:airline#extensions#tabline#tab_nr_type   = 2
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'y', 'warning', 'error', 'z' ]
    \ ]

" make some commands case-insensitive
command! Q q
command! W w

function! LintFile(threshold, modified)
  if line('$') <= a:threshold && &buftype ==? '' && &modified == a:modified
    Neomake
  endif
endfunction

"
" auto commands that make your life easier
"
augroup general_enhancements
  autocmd!

  autocmd BufEnter,InsertLeave * set cursorline
  autocmd BufLeave,InsertEnter * set nocursorline

  " temporary disabled during the refactoring period
  " autocmd BufWritePre * StripWhitespace " strip whitespaces on save

  " TODO should replace with proper partial linting, seem in progress now
  " see https://github.com/neomake/neomake/pull/1167
  autocmd BufWritePost * call LintFile(999, 0)
  autocmd CursorHold * call LintFile(300, 1)

  autocmd VimResized * wincmd =  " make panes responsive
  autocmd WinEnter * checktime % " make autoread behave intuitively
augroup END

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

let g:ycm_min_num_of_chars_for_completion = 3

" TODO make NERDCommenter smarter, i.e.
" - omni shortcut to toggle comment on/off
" - detect mode automatically and apply corresponding style
" - use comment line left align as default

" jsx settings if want to have jsx in side js
let g:jsx_ext_required = 0
let g:NERDTreeWinSize = 30

" color filename as well by file type in NERDTree
let g:NERDTreeFileExtensionHighlightFullName = 1

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

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Disable vim-json double quotes concealing as it's a bit awkward for me
let g:vim_json_syntax_conceal = 0

" disable folding on markdown which is annoying
let g:vim_markdown_folding_disabled = 1

" seamless vim/tmux navigation
let g:tmux_navigator_no_mappings = 1

" use ag if possible, for better performance
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"
" neomake tweaks, note that gui color settings should also be set because +termguicolors is set
"
" prefer eslint_d for better speed, note current version is patched by me
" let g:neomake_javascript_enabled_makers = ['eslint_d']
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

" always display the sign column to avoid content flickering
let g:gitgutter_sign_column_always = 1

function! ColorSchemeTweaks()
  " FIXME hack, make use of gitgutter function to get sign column bg
  let [l:guibg, l:ctermbg] = gitgutter#highlight#get_background_colors('SignColumn')
  execute 'highlight NeomakeErrorSign   guifg=#ff3300 guibg=' . l:guibg
  execute 'highlight NeomakeWarningSign guifg=#ff9900 guibg=' . l:guibg
  execute 'highlight NeomakeMessageSign guifg=#0099aa guibg=' . l:guibg
  execute 'highlight NeomakeInfoSign    guifg=#666666 guibg=' . l:guibg

  " HACK for vertical split sign
  " highlight VertSplit gui=NONE guifg=#666666 guibg=NONE
  highlight VertSplit gui=NONE guifg=NONE guibg=NONE
endfunction

" smarter project root by vim-rooter
let g:rooter_silent_chdir = 1
let g:rooter_patterns = [
  \ 'package.json',
  \ 'conda.yaml',
  \ '.git',
  \ '.git/'
  \ ]
let g:rooter_resolve_links = 1

" Adapt neomake sign color after color theme change
augroup colorscheme_tweaks
  autocmd!
  autocmd ColorScheme * call ColorSchemeTweaks()
augroup END

" adaptive theme with extra fine tuning, also fast switching by F5
" XXX this has to be put after ColorSchemeTweaks in order to detect correct bg
" color for the gutter
let g:luminance=system('get_luminance')
if g:luminance ==? 'high'
  call SunnyDays()
elseif g:luminance ==? 'low'
  call LateNight()
else
  call InDoor()
endif

"
" Key Mapping
"

" turn off Ex mode
map Q <Nop>
" turn off Recording mode
map q <Nop>

" Git Fugititve key mapping
nnoremap <space>gb :Gblame<CR>
nnoremap <space>gs :Gstatus<CR>

" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" simple spell correction
" TODO needs a better solution, including but not limited to:
" 1. Faster check
" 2. Dropdown with length limit
" 3. Use online service
noremap <space>c ea<C-x><C-s>

" Run the current script according to shebang!
nnoremap <F6> :!%:p<Enter>

" Search related tweaks
highlight Search ctermfg=202 ctermbg=NONE cterm=bold,underline
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> n nzz
nnoremap <silent> N Nzz

" Quick jump between recent two buffers

" Quick switch between numbers ruler
nnoremap <silent> <F12> :set number!<CR>

" Tagbar Toggle
nnoremap <silent> <C-t> :TagbarToggle<CR>

" Quick edit .vimrc
nnoremap <leader>V :e $MYVIMRC<CR>

" Break line at cursor
nnoremap <leader>j i<return><esc>

" NERDTree
map <C-\> :NERDTreeFind<CR> | wincmd p

" FIXME git ls-files --exclude-standard seems not horning global ignore file
function! FindFilesInCurrentProject()
  let l:project_root = FindRootDirectory()
  call fzf#run(fzf#wrap({'source': 'git ls-files ' . l:project_root . ' --exclude-standard'}))
endfunction

function! FindReferenceOfCurrentFile()
  call fzf#vim#ag(expand('%:t:r'))
endfunction
nnoremap <leader>rf :call FindReferenceOfCurrentFile()<CR>

function! FindReferenceOfCurrentWordUnderCursor()
  call fzf#vim#ag(expand('<cword>'))
endfunction
nnoremap <leader>rw :call FindReferenceOfCurrentWordUnderCursor()<CR>

" TODO need a neat implementation
function! FindReferenceOfCurrentSelection()
  call fzf#vim#ag(expand('<cword'))
endfunction
nnoremap <leader>rv :call FindReferenceOfCurrentSelection()<CR>

" Fzf bindings
nnoremap <silent> <leader>f :call FindFilesInCurrentProject()<CR>
nnoremap <silent> <leader>b :Buffers<CR>

" Tmux/Vim seamless navigation
nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-,> :TmuxNavigatePrevious<CR>

if !empty(glob('~/.vimrc.after'))
  source ~/.vimrc.after
end

"
" Initialization
"
augroup welcome
  autocmd VimEnter *
              \   if !argc()
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | endif
augroup END
