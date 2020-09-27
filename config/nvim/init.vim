" {{{ FIXME
" - [ ] colorscheme load is delayed when open multiple files
" - [ ] fix cursorline caused slowness, in fast scroll and gblame
" - [ ] this is too buggy but the idea is great: Plug 'jiangmiao/auto-pairs'
" }}}
"
" {{{ TODO
" - [ ] function for setting correct python path if a venv is available
" - [ ] add contional loading for pluggins
" - [ ] make use of prettier, yapf, and other fixers with ALE
" - [ ] check if there is a way to only highlight search keywords in current buffer
" - [ ] learn far.vim
" - [ ] compare preview feature with fzf ag preview: https://github.com/junegunn/fzf.vim/blob/master/README.md#advanced-customization
" - [ ] checkout defx.nvim as an alternative to nerdtree
" - [ ] remove vim-jsx-typescript after vim-polyglot added support | not ready 23, Nov 2018
" - [ ] try ncm2 as an alternative to YCM
" - [ ] try coc.vim as an alternative to YCM
" - [ ] think about the colorscheme crap
" }}}
"
" {{{ handy selection of symbols
" - poker suits:    [♠ ♥ ♣ ♦ ]
" - common symbols: • ￭
" - white space:    ] [(em) XXX needed as leading whitespace in sign column
"
"
" - Box Drawing Characters table (as of Unicode version 11.0)
"
"           0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
"   U+250x  ─  ━  │  ┃  ┄  ┅  ┆  ┇  ┈  ┉  ┊  ┋  ┌  ┍  ┎  ┏
"
"   U+251x  ┐  ┑  ┒  ┓  └  ┕  ┖  ┗  ┘  ┙  ┚  ┛  ├  ┝  ┞  ┟
"
"   U+252x  ┠  ┡  ┢  ┣  ┤  ┥  ┦  ┧  ┨  ┩  ┪  ┫  ┬  ┭  ┮  ┯
"
"   U+253x  ┰  ┱  ┲  ┳  ┴  ┵  ┶  ┷  ┸  ┹  ┺  ┻  ┼  ┽  ┾  ┿
"
"   U+254x  ╀  ╁  ╂  ╃  ╄  ╅  ╆  ╇  ╈  ╉  ╊  ╋  ╌  ╍  ╎  ╏
"
"   U+255x  ═  ║  ╒  ╓  ╔  ╕  ╖  ╗  ╘  ╙  ╚  ╛  ╜  ╝  ╞  ╟
"
"   U+256x  ╠  ╡  ╢  ╣  ╤  ╥  ╦  ╧  ╨  ╩  ╪  ╫  ╬  ╭  ╮  ╯
"
"   U+257x  ╰  ╱  ╲  ╳  ╴  ╵  ╶  ╷  ╸  ╹  ╺  ╻  ╼  ╽  ╾  ╿
"
" - block elements (as of Unicode version 11.0)
"
"           0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
"   U+258x  ▀  ▁  ▂  ▃  ▄  ▅  ▆  ▇  █  ▉  ▊  ▋  ▌  ▍  ▎  ▏
"
"   U+259x  ▐  ░  ▒  ▓  ▔  ▕  ▖  ▗  ▘  ▙  ▚  ▛  ▜  ▝  ▞  ▟
"   }}}

let g:vim_conf_root  = $XDG_CONFIG_HOME
if empty(g:vim_conf_root)
  let g:vim_conf_root = expand('<sfile>:p:h:h')
endif
" }}}

" Make use of bash utilities in vim
let $BASH_ENV = g:vim_conf_root . '/bash/noninteractive'
let g:before_hook = g:vim_conf_root . '/nvim/before.vim'
let g:after_hook = g:vim_conf_root . '/nvim/after.vim'

if filereadable(g:before_hook)
  execute 'source' g:before_hook
endif

execute 'source' g:vim_conf_root . '/nvim/variables.vim'
execute 'source' g:vim_conf_root . '/nvim/functions.vim'

" load my personal plugins
for f in split(glob(g:vim_conf_root . '/nvim/pluginrc.d/*.vim'), '\n')
  execute 'source' f
endfor

let g:polyglot_disabled = ['md', 'markdown']
let g:tex_conceal = ''
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_math = 1
let g:vim_markdown_strikethrough = 1
let g:markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'c',
      \ 'css',
      \ 'html',
      \ 'javascript',
      \ 'python',
      \ 'ruby',
      \ 'scss',
      \ 'sql',
      \]

" {{{ Plugins
call SetupVimPlug() " in case vim-plug is missing
call plug#begin(g:vim_conf_root . '/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ajmwagar/vim-deus'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'brooth/far.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'gyim/vim-boxdraw'
Plug 'honza/vim-snippets'
Plug 'jparise/vim-graphql' " TODO this is removed from vim-polyglot for now
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': g:vim_conf_root . '/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Lokaltog/vim-easymotion'
Plug 'liuchengxu/vista.vim' " Beteralternative to TagBar. TODO more Vista tweaks
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mhinz/vim-startify'
Plug 'NLKNguyen/papercolor-theme'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ntpeters/vim-better-whitespace'
Plug 'peitalin/vim-jsx-typescript', { 'for': ['ts', 'tsx'] }
Plug 'plasticboy/vim-markdown' " FIXME [CAVEAT_1] Not playing well with polyglot
" Plug 'python-rope/ropevim' TODO try rope vim
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot', { 'for': ['jsx'] }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/chlordane.vim'
Plug 'dense-analysis/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'zxqfl/tabnine-vim'
call plug#end()
" }}}

" {{{ Basic settings
if !has('nvim')
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
  syntax on                      " Enable syntax highlight
endif

" force utf-8 encoding cause we have multi-bytes chars here
scriptencoding utf-8

set autowrite                             " Save changes before switching buffers
set completeopt-=preview                  " Get rid of the annoying preview window on autocomplete
set expandtab                             " Expand tabs to spaces
set fillchars+=vert:│                     " Make vertical split bar prettier
set foldopen+=jump                        " Open folded region when jump to it
" set guicursor=                          " Seems buggy? Have to unset to mitigate junk chars
set ignorecase                            " Make search case-insensitive
set list                                  " Enable whitespace characters' display
set listchars=nbsp:¬,tab:»·,trail:·       " Better whitespace symbols
set mouse=a                               " Grab mouse event within tmux
set lazyredraw                            " FIXME mitigate with jsx until find a fix
set nobackup                              " Be environment friendly
set backupcopy=no                         " Be environment friendly
set noshowmode                            " Hide the default mode text cause we have *whatever*line
set noshowcmd                             " Hide the annoying command from bottom right
set noswapfile                            " Get rid of the annoying .swp file
set nowrap                                " Don't wrap on long lines
set nowritebackup                         " Write file in place
set number                                " Display line numbers on the left
set pastetoggle=<F2>                      " bind paste mode for ease of use
set pumblend=9                            " Pseudo transparency for pop-up menu
set scrolloff=6                           " Have some context around the current line always on screen
set signcolumn=yes                        " always display the sign column to avoid content flickering
set shiftwidth=2                          " Number of spaces to use for each step of (auto)indent
set showtabline=0                         " Don't need the tab line man
set smartcase                             " Make search case-insensitive smart!
set smartindent                           " Do smart auto indenting when starting a new line
set spell                                 " Check spell is good when we added all the keywords!
set spelllang=en_us                       " Use en_us for better collaboration, sorry en_gb
set splitbelow                            " Intuitively split to below when doing horizontal split
set splitright                            " Split to right when doing vertical split
set synmaxcol=512                         " Limit syntax color for long lines to improve rendering speed
set tabstop=2                             " Number of spaces that a <Tab> in the file counts for
set tags=./.tags,./tags,.tags,tags;       " Use hidden tags files
" set undodir="$XDG_DATA_HOME/nvim/undo/" " Persistent undo directory FIXME default to XDG_DATA_HOME
set undofile                              " Persistent undo, note undodir default to xdg data
set updatetime=128                        " Make update related events slightly faster
set winblend=9                            " Pseudo transparency for floating window
let &showbreak='↪ '                       " Make soft wrap visually appealing FIXME not showing up?
" }}}

" {{{ airline
"

" call airline#parts#define_accent('file', 'bold')

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'P'
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : '',
    \ 'i'  : '',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : '',
    \ 'V'  : '',
    \ '' : '',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't'  : 'T',
    \ }

" handy selection of symbols
" - poker suits:    ♠ ♥ ♣ ♦
" - common symbols: •
" - white space:    ] [(em) XXX needed as leading whitespace in sign column
"
" - Box Drawing Characters table (as of Unicode version 11.0)
"
"           0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
"   U+250x  ─  ━  │  ┃  ┄  ┅  ┆  ┇  ┈  ┉  ┊  ┋  ┌  ┍  ┎  ┏
"
"   U+251x  ┐  ┑  ┒  ┓  └  ┕  ┖  ┗  ┘  ┙  ┚  ┛  ├  ┝  ┞  ┟
"
"   U+252x  ┠  ┡  ┢  ┣  ┤  ┥  ┦  ┧  ┨  ┩  ┪  ┫  ┬  ┭  ┮  ┯
"
"   U+253x  ┰  ┱  ┲  ┳  ┴  ┵  ┶  ┷  ┸  ┹  ┺  ┻  ┼  ┽  ┾  ┿
"
"   U+254x  ╀  ╁  ╂  ╃  ╄  ╅  ╆  ╇  ╈  ╉  ╊  ╋  ╌  ╍  ╎  ╏
"
"   U+255x  ═  ║  ╒  ╓  ╔  ╕  ╖  ╗  ╘  ╙  ╚  ╛  ╜  ╝  ╞  ╟
"
"   U+256x  ╠  ╡  ╢  ╣  ╤  ╥  ╦  ╧  ╨  ╩  ╪  ╫  ╬  ╭  ╮  ╯
"
"   U+257x  ╰  ╱  ╲  ╳  ╴  ╵  ╶  ╷  ╸  ╹  ╺  ╻  ╼  ╽  ╾  ╿
"
" - block elements (as of Unicode version 11.0)
"
"           0  1  2  3  4  5  6  7  8  9  A  B  C  D  E  F
"   U+258x  ▀  ▁  ▂  ▃  ▄  ▅  ▆  ▇  █  ▉  ▊  ▋  ▌  ▍  ▎  ▏
"
"   U+259x  ▐  ░  ▒  ▓  ▔  ▕  ▖  ▗  ▘  ▙  ▚  ▛  ▜  ▝  ▞  ▟
"
"

" function! NearestMethodOrFunction() abort
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
"
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:airline#extensions#vista#enabled = 1
let g:airline#extensions#branch#enabled        = 0
let g:airline#extensions#tabline#enabled       = 0
let g:airline#extensions#tabline#tab_nr_type   = 2
let g:airline#extensions#whitespace#enabled    = 0
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
let g:airline_detect_spell                     = 0
let g:airline_inactive_collapse                = 1
let g:airline_left_alt_sep                     = ''
let g:airline_left_sep                         = ''
let g:airline_powerline_fonts                  = 0
let g:airline_right_alt_sep                    = ''
let g:airline_right_sep                        = ''
let g:airline_section_a                        = '' " (mode, crypt, paste, spell, iminsert)
let g:airline_section_b                        = '' " (hunks, branch)[*]
" FIXME looks like there is a bug on virtualenv
" let g:airline_section_c                        = '' " (bufferline or filename, readonly)
" let g:airline_section_c                        = airline#section#create(["%{NearestMethodOrFunction()}"])
" let g:airline_section_gutter                   = ' ' (csv)
let g:airline_section_x                        = '' " (tagbar, filetype, virtualenv)
let g:airline_section_y                        = '' " (fileencoding, fileformat)
let g:airline_section_z                        = airline#section#create(["%{col('.')}:%{line('.')}"]) " (percentage, line number, column number)
" let g:airline_section_error                  = '' (ycm_error_count, syntastic-err, eclim, languageclient_error_count)
" let g:airline_section_warning                = '' (ycm_warning_count, syntastic-warn, languageclient_warning_count, whitespace)
let g:airline_symbols_ascii                    = 1
" }}}


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" TODO get familiar with this
let g:UltiSnipsExpandTrigger='<A-e>'
let g:UltiSnipsJumpForwardTrigger='<c-f>'
let g:UltiSnipsJumpBackwardTrigger='<c-b>'

" make some commands case-insensitive
command! Q q
command! W w

function! SetUpBuffer()
  if &modifiable == 1
    setlocal signcolumn=auto
  else
    setlocal signcolumn=yes
  endif
endfunction

" silent on save when editing remote files
let g:netrw_silent=1

" https://vi.stackexchange.com/questions/744/can-i-pass-a-custom-string-to-the-gx-command/751
function! EnhancedBrowseX()
  let l:keyword = expand('<cfile>')
  let l:line = getline('.')

  " add support for go to Github for Plug plugins
  if l:line =~? '\v^Plug ([''"])[a-zA-Z0-9-_./]*\1'
    let l:keyword = 'https://github.com/' . l:keyword
  endif

  call netrw#BrowseX(l:keyword, netrw#CheckIfRemote())
endfunction

nnoremap gx :call EnhancedBrowseX()<CR>
xnoremap gx :call EnhancedBrowseX()<CR>

vmap <LeftRelease> "*ygv

function! TextMagic()
  set textwidth=0
  set wrapmargin=0
  " set colorcolumn=79
  " FIXME
  " - this will get reset on window resize, need to prevent that
  " - columns are buggy with multiple buffers
  " set columns=100
  set linebreak
  set nolist
  set wrap
  nmap j gj
  nmap k gk
  nmap 0 g0
  nmap $ g$
  " FIXME can't link to LineNr due to a bug
  " hi ColorColumn ctermbg=239 guibg=#242a32
endfunction

function! PythonMagic(state)
  if a:state == 'on'
    set cursorcolumn
  else
    set nocursorcolumn
  endif
endfunction

"
" Custom Highlight rules
" XXX note vim-better-whitespace does not deal with leading tabs
"
function! CustomHighlights()
  syntax match PeskyTabs /\v\t+/
  " Python docstring
  " syntax region foldImports start='"""' end='"""' fold keepend
endfunction

"
" auto commands that make your life easier
"
" XXX no space is allowed between events
augroup general_enhancements
  autocmd!
  autocmd BufCreate * call SetUpBuffer()
  autocmd BufEnter *.log set nospell " no spell check for log files
  autocmd BufEnter *.md,*.txt,*.doc,*.rst call TextMagic()
  autocmd BufEnter *.py call PythonMagic('on')
  autocmd BufLeave *.py call PythonMagic('off')
  autocmd BufEnter,InsertLeave * set cursorline
  autocmd BufLeave,InsertEnter * set nocursorline
  autocmd BufEnter * call CustomHighlights()

  " FIXME temporary workaround for Docker issue
  autocmd BufEnter *Dockerfile      set filetype=dockerfile
  autocmd BufEnter Jenkinsfile      set filetype=groovy
  autocmd BufEnter *.bin,*.pcap     set binary

  " FIXME use filetype to disable cursorline within fugitiveblame

  " temporary disabled during the refactoring period
  " autocmd BufWritePre * StripWhitespace " strip whitespaces on save

  autocmd VimResized * wincmd =  " make panes responsive on window resize
  autocmd FocusGained,BufEnter * checktime " make autoread behave intuitively

  " FIXME position hack for file opened with line number
  " autocmd BufEnter * exe 'normal! zz'
augroup END



" {{{ PlantUML enchancements
"
" dependencies:
" - plantuml/plantuml-server: docker image for set up the server
"   docker run -d -p 8080:8080 plantuml/plantuml-server
" - node-plantuml: for encode the uml file
"   npm i -g node-plantuml
"
" the prototype will try to encode the uml file upon save, and communicate
" with the server, then open a viewer if it's not opened yet
" TODO
" - [ ] need to make this asynchronous, checkout jobstart
"
function! RenderPlantUML()
  echo 'generating PlantUML diagram...'
  let l:file_path = expand('%:p')
  let l:file_dir = expand('%:p:h')
  let l:png_name = expand('%:r') . '.png'
  let l:png_path = l:file_dir . '/' . l:png_name
  let l:cmd = '!curl -sS "localhost:12345/png/$(puml encode ' . l:file_path . ')" -o ' . expand('%:r') . '.png'
  " FIXME
  " - [ ] the behaviour of external picture viewer is not deterministic
  " - [ ] find a better platform independent solution
  " let l:cmd = l:cmd . " && (ps x | pgrep -af '". l:png_path . "$' && : || xdg-open " . l:png_path . ' &)'
  silent execute l:cmd
  redraw " FIXME any better way to deal with the messages?
  echo 'generated!'
endfunction

augroup plantuml_enchancements
  " maybe support tags grepping
  autocmd! BufWritePost *.*uml call RenderPlantUML()
augroup END
" }}}

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

" {{{ Python Virtual Env Tweaks start
"
" Priority
" - active conda environment
" - clever_conda_path
" - wherever the current python from
"
if isdirectory(glob("$__conda_env_root"))
  let s:py3_path = glob("$__conda_env_root/py3/bin/python")
  if executable(s:py3_path)
    let g:python3_host_prog = s:py3_path
    let g:ycm_server_python_interpreter = s:py3_path
  endif

  let s:py2_path = glob("$__conda_env_root/py2/bin/python")
  if executable(s:py2_path)
    let g:python_host_prog = s:py2_path
  endif
endif

" active Python path is currently determined by CONDA_PREFIX
" TODO
" - [ ] should delegate this to the system function
let s:py_virtual_env_dir = $CONDA_PREFIX

if empty(s:py_virtual_env_dir)

  if argc()
    let s:current_path = expand('%:p')
  else
    let s:current_path = getcwd()
  endif

  let s:py_virtual_env_dir = system('2>/dev/null' . ' ' . '__.venv.python.prefix' . ' ' . s:current_path)
endif

" see YCM official doc
let g:ycm_python_interpreter_path = s:py_virtual_env_dir . '/bin/python'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = g:vim_conf_root . '/ycm_global_extra_conf.py'
" XXX For historical reason, $VIRTUAL_ENV is used by many Python
" plugins so we just have to abide by it for now
let $VIRTUAL_ENV = s:py_virtual_env_dir
let $PYTHONPATH = s:py_virtual_env_dir
let $PATH = s:py_virtual_env_dir . '/bin' . ':' . $PATH
" XXX https://mypy.readthedocs.io/en/latest/running_mypy.html#finding-imports
" let $MYPYPATH = expand(s:py_virtual_env_dir . '/lib/*/site-packages')

" disable ale's virtual env auto discover feature and use the envvar instead
" because we know the environment better
let g:ale_virtualenv_dir_names = []
"
" }}}

" typescript setup for YCM
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_max_num_candidates = 18

let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = '%#NonText#'
let g:NERDTreeWinSize = 30

" color filename as well by file type in NERDTree
let g:NERDTreeFileExtensionHighlightFullName = 1

" Nerd Commenter
let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
nnoremap <C-_> :call NERDComment('n', 'toggle')<CR>
xnoremap <C-_> :call NERDComment('x', 'toggle')<CR>

" better find and replace
vnoremap <C-r> "hy:%s/<C-r>h//c<left><left>

vnoremap <C-s> :<C-r>0<Home><right>

" NerdTree git plugin
" TODO
" - [ ] find better icons, the previous one looks too bulky and not
" consistent, thus replaced by ascii characters
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  : '*',
    \ 'Staged'    : '+',
    \ 'Untracked' : 'u',
    \ 'Renamed'   : '»',
    \ 'Unmerged'  : '≠',
    \ 'Deleted'   : 'x',
    \ 'Dirty'     : '*',
    \ 'Clean'     : '✓',
    \ 'Ignored'   : '_',
    \ 'Unknown'   : '?'
    \ }

" Customize fzf colors to match your color scheme
" FIXME fix ag colour
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" seamless vim/tmux navigation
let g:tmux_navigator_no_mappings = 1

" {{{ Sign Column Tweaks
"
"

" let g:ale_sign_error = ' ■' " good on fantasque mono, but why it's so fucking huge in Ubuntu mono?
" TODO
" not sure if this is feasible but if we can merge linter symbols
" and git status symbols it will look great!
" let g:linter_sign = '┃•' " good on Ubuntu mono
" let g:linter_sign = ' ￭'   " good on Ubuntu mono
let g:linter_sign = ' •'   " good on Ubuntu mono
" let g:git_sign = '┃ '      " good on Ubuntu mono
" let g:git_sign = '│ '      " good on Ubuntu mono
" let g:git_sign = '▐ '      " good on Ubuntu mono
let g:git_sign = '┃ '      " good on Ubuntu mono

" FIXME still buggy 23 Nov, now check again 2019
" let g:ale_completion_enabled = 1
let g:ale_lint_delay = 666
let g:ale_linters = {'javascript': ['eslint', 'tsserver']}
let g:ale_sign_column_always = 1
let g:ale_sign_error = g:linter_sign
let g:ale_sign_warning = g:linter_sign

" FIXME temporary workaround for neovim ALE issue, see:
" https://github.com/neovim/neovim/issues/9388
let g:ale_sign_offset = 1000

let g:gitgutter_map_keys = 0 " no need of mapping, visual clue only
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added = g:git_sign
let g:gitgutter_sign_modified = g:git_sign
let g:gitgutter_sign_modified_removed = g:git_sign
let g:gitgutter_sign_removed = '‣ '
let g:gitgutter_sign_removed_first_line = '‣ '

let g:ycm_error_symbol = g:linter_sign
let g:ycm_warning_symbol = g:linter_sign

"
" color tweaks
"
" TODO find a better solution for color matching between colorscheme
" and sign column
"
function! s:match_highlight(highlight, pattern) abort
  let matches = matchlist(a:highlight, a:pattern)
  if len(matches) == 0
    return 'NONE'
  endif
  return matches[1]
endfunction

function! s:get_highlight(group) abort
  redir => l:highlight
  silent execute 'silent highlight ' . a:group
  redir END

  let l:link_matches = matchlist(l:highlight, 'links to \(\S\+\)')
  if len(l:link_matches) > 0 " follow the link
    return s:get_highlight(l:link_matches[1])
  endif

  let l:ctermbg = s:match_highlight(l:highlight, 'ctermbg=\([0-9A-Za-z]\+\)')
  let l:ctermfg = s:match_highlight(l:highlight, 'ctermfg=\([0-9A-Za-z]\+\)')
  let l:guibg   = s:match_highlight(l:highlight, 'guibg=\([#0-9A-Za-z]\+\)')
  let l:guifg   = s:match_highlight(l:highlight, 'guifg=\([#0-9A-Za-z]\+\)')
  return [
    \ l:guibg,
    \ l:guifg,
    \ l:ctermbg,
    \ l:ctermfg,
    \ ]
endfunction

function! ColorSchemeTweaks()
  "TODO get color from ALE?
  " let [l:guibg, l:guifg, l:ctermbg, l:ctermfg] = s:get_highlight('SignColumn')

  highlight ALEErrorSign          guifg=#FB4934 guibg=NONE
  highlight ALEWarningSign        guifg=#FABD2F guibg=NONE

  highlight YcmErrorSign          guifg=#FB4934 guibg=NONE
  highlight YcmWarningSign        guifg=#FABD2F guibg=NONE

  highlight GitGutterAdd          guifg=#98C379 guibg=NONE ctermbg=NONE
  highlight GitGutterChange       guifg=#FABD2F guibg=NONE ctermbg=NONE
  " a changed line followed by at least one removed line
  highlight GitGutterChangeDelete guifg=#2C323B guibg=NONE ctermbg=NONE
  highlight GitGutterDelete       guifg=#FB4934 guibg=NONE ctermbg=NONE

  highlight SignColumn            guibg=NONE
  highlight VertSplit             guibg=NONE guifg=#666666

  " TODO use colour blend function instead of hard-code
  highlight Pmenu      guibg=#ebdab2 guifg=#333333
  highlight PmenuSel   guibg=#98C379 guifg=#333333



  " FIXME ts highlighting is doing this seems?
  " Should be the job of linters
  set colorcolumn=0
  " vim-better-whitespace
  highlight link ExtraWhitespace WarningMsg
  highlight link PeskyTabs WarningMsg
  highlight SpellBad cterm=underline gui=undercurl
  " this is needed after switched colorscheme on the fly to trigger correct re-render
  syntax on
endfunction
let g:show_spaces_that_precede_tabs=1

" Adapt sign color upon color theme change
augroup colorscheme_tweaks
  autocmd!
  autocmd ColorSchemePre syntax off
  autocmd ColorScheme * call ColorSchemeTweaks()
augroup END
" }}}

"
" smarter project root by vim-rooter, very useful when combined with fzf below
" TODO
" the detection can be further improved with updated project structures, need
" to find a collection of files that can denote a package though
let g:rooter_patterns = [
  \ 'conda.yaml',
  \ 'meta.yaml',
  \ 'build.sh',
  \ 'package.json',
  \ 'setup.py',
  \ '.git',
  \ '.git/',
  \ ]
let g:rooter_resolve_links = 1
let g:rooter_manual_only = 1

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
" Key Mappings
"

" turn off Ex mode
map Q <Nop>
" turn off Recording mode
map q <Nop>

" make Y behave like other capitals
nnoremap Y y$

" Git Fugititve key mapping
" Check out if there are any floating window alternatives
nnoremap <leader>gb :Gblame <Bar> wincmd = <CR>
nnoremap <leader>gs :Gstatus<CR>

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
" TODO extend this to be intelligent run current file, e.g.
" - open up preview for markdown files
" - render plantuml for puml files
" - run the file if it's executable and has shebang set
nnoremap <leader>r :!%:p<CR>

function EchoOutput(job_id, data, event)
  if a:data == 0
    echom 'compiled!'
    !notify-send 'compiled'
  else
    echom 'failed!'
    !notify-send 'failed'
  endif
endfunction

"
" Centralized movement
"
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <silent> gg ggzz
nnoremap <silent> <A-}> :GitGutterNextHunk <CR> zz
nnoremap <silent> <A-{> :GitGutterPrevHunk <CR> zz
nnoremap <silent> <A-[> :ALEPreviousWrap <CR> zz
nnoremap <silent> <A-]> :ALENextWrap <CR> zz

"
" more intuitive next/prev result keymapping
"
nnoremap <silent> * *N <Bar> zz
nnoremap <silent> # #N <Bar> zz
nnoremap <expr> n (v:searchforward ? 'nzz' : 'Nzz')
nnoremap <expr> N (v:searchforward ? 'Nzz' : 'nzz')

" Quick switch between numbers ruler
nnoremap <silent> <F12> :set number!<CR>
nnoremap <silent> <F8> :execute ':silent !google-chrome %'<CR>
nnoremap <silent> <F4> :set ts=4 sw=4<CR>

" Vista Toggle (better alternative of TagBar)
" FIXME why wincmd not working here
nnoremap <silent><C-t> :Vista!! <Bar> wincmd =<CR>
nnoremap <silent><leader>t :Vista finder<CR>
" TODO
" - [ ] maybe enable this again when find a good font
let g:vista#renderer#enable_icon = 0
let g:vista_sidebar_width = 60
" FIXME consistent styling of floating window
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_keep_fzf_colors = 1

" jump to first match
nnoremap <C-]> :YcmCompleter GoTo<CR>

" Quick edit .vimrc
nnoremap <leader>V :e $MYVIMRC<CR>

" Break line at cursor
nnoremap <leader>j i<return><esc>

" NERDTree
map <C-\> :NERDTreeFind <Bar> wincmd =<CR>

" FIXME this only works with Python (hopefully), will need a proper
" implementation
" let g:ycm_collect_identifiers_from_tags_files = 1
" map <F10> :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`<CR>


" TODO
" - add more precise ext based matching instead of the naïve one below
" - let sink command go to the matching line, see: https://github.com/junegunn/fzf/wiki/Examples-(vim)#jump-to-tags
function! FindReferenceOfCurrentFile()
  let l:dir = FindRootDirectory()
  let l:filename = expand('%:t:r')
  let l:extension = strpart(expand('%:e'), 0, 2)
  let l:search = 'ag --no-color --nogroup --word-regexp -G .' . l:extension . '* ' . l:filename . ' | column -s: -t'
  call fzf#run(fzf#wrap({'source': l:search, 'dir': l:dir }))
  echo 'finding referece of ' . l:filename . '...'
endfunction
nnoremap <silent> <leader>rf :call FindReferenceOfCurrentFile()<CR>

" find word under cursor
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
" find whitespace delimited segments
nnoremap <silent> <leader>AG :Ag <C-R><C-A><CR>
" find selection
xnoremap <silent> <leader>rw y:Ag <C-R>"<CR>

let g:fzf_buffers_jump = 1
" FZF with floating window
" TODO
" - FZF_DEFAULT_OPTS should follow vim colorscheme
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let min_height = 6
  let max_height = &lines - 36
  let dynamic_height = &lines * 1 / 2
  let height = max([min([max_height, dynamic_height]), min_height])

  let min_width = 60
  let max_width = &columns - 24
  let dynamic_width = &columns * 2 / 3
  let width = max([min([max_width, dynamic_width]), min_width])

  let horizontal = (&columns - width) / 2
  let vertical = (&lines - height) / 2

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction


" Fzf bindings
function! SmartFindFiles()
  " FindRootDirectory from vim-rooter
  let l:dir = FindRootDirectory()
  let l:cwd = getcwd()
  let l:options = ''

  if empty(l:dir)
    let l:dir = l:cwd
    " TODO maybe replace with rg
    " XXX the reason why we are not using find here even it's faster it's because
    " find won't ignore common ignored files
    let l:cmd = 'ag --nocolor -l'
  else
    let l:cmd = $GIT_DEFAULT_LS_COMMAND

    if empty(l:cmd)
      " this shouldn't happen but anyway
      " FIXME for some reason this won't work when invoked via a variable
      let l:cmd = 'comm -13 <(git ls-files --deleted | sort) <(git ls-files --cached --others --exclude-standard | sort)'
    endif

    if l:cwd !~? l:dir " remove leading path that duplicates with cwd
      let l:cmd .= " | awk '$0=\"" . l:dir . "/\"$0'"
    endif


    " XXX experimenting handle sort manually for git projects, order:
    " - file in the same directory first
    " - file in children directory
    " - file in parent directory
    " - file is ordered by levels of directories and then file name
    " TODO
    " - [ ] in this way, we will want to ls-files use relative path
    " let l:cmd .= " |
    "   \ awk --field-separator '[/.]' '{print NF-1\" \"$0}' |
    "   \ sort --key=1n --key=2i |
    "   \ cut --delimiter=' ' --fields=2"
    let l:options = l:options . ' --no-sort --tiebreak=index'
  endif

  " echo 'searching using "' . l:cmd . '" ...'
  call fzf#run(fzf#wrap({
    \ 'dir': l:dir,
    \ 'options': l:options,
    \ 'source': l:cmd,
    \ 'window': 'call FloatingFZF()',
    \ }
  \ ))
endfunction

nnoremap <silent> <leader>f :call SmartFindFiles()<CR>
nnoremap <silent> <leader>B :Buffers<CR>
" fast switch with previous buffer
nnoremap <silent> <leader>b :b#<CR>
nnoremap <silent> <leader>L :Lines<CR>

"
" fzf tweaks

" fzf#ag#vim with preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:70%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Tmux/Vim seamless navigation
nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
nnoremap <silent> <A-,> :TmuxNavigatePrevious<CR>


" FIXME need to have a second thought on this
" nnoremap <silent> <C-h> :vertical res +10<CR>
" nnoremap <silent> <C-j> :res +5<CR>
" nnoremap <silent> <C-k> :res -5<CR>
" nnoremap <silent> <C-l> :vertical res -10<CR>

" FIXME default colour setting of deusBg2 is too dark
highlight! link NonText deusBg3

if filereadable(g:after_hook)
  execute 'source' g:after_hook
endif

hi Comment cterm=italic

" FIXME no lowercase color name supported yet, check later
function! LuaColorizer()
lua << EOF
require 'colorizer'.setup({
  '*';
  css = { names = true };
  scss = { names = true };
  html = { names = true };
}, {
  rgb_fn = true;
})
EOF
endfunction

call LuaColorizer()

" {{{ Initialization
"
augroup welcome
  let has_piped_input = 0
  autocmd StdinReadPost * let has_piped_input = 1
  autocmd VimEnter *
              \   if !argc()
              \ && has_piped_input == 0
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | endif
augroup END
" }}}

" vim: set ai tw=119 foldmethod=marker :
