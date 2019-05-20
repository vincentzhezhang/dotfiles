" TODO
" - function for setting correct python path if a venv is available
" - add contional loading for pluggins
" - make use of prettier, yapf, and other fixers with ALE
" - check if there is a way to only highlight search keywords in current buffer
" - learn far.vim
" - compare preview feature with fzf ag preview: https://github.com/junegunn/fzf.vim/blob/master/README.md#advanced-customization
" - checkout defx.nvim as an alternative to nerdtree
" - remove vim-jsx-typescript after vim-polyglot added support | not ready 23, Nov 2018
" - try ncm2 as an alternative to YCM
" - think about the colorscheme crap
"
" FIXME
" - colorscheme load is delayed when open multiple files
" - fix cursorline caused slowness, in fast scroll and gblame
" - this is too buggy but the idea is great: Plug 'jiangmiao/auto-pairs'
"
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

" Make use of bash utilities in vim
let $BASH_ENV = '~/.bash_utilities'

if !empty(glob('~/.vimrc.before'))
  source ~/.vimrc.before
end

source ~/.vim/variables.vim
source ~/.vim/functions.vim

" temporary workaround for editorconfig-vim slowness
let g:EditorConfig_core_mode = 'external_command'

" {{{ Plugins
call SetupVimPlug() " in case vim-plug is missing
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ajmwagar/vim-deus'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ap/vim-css-color', { 'for': ['css', 'sass', 'scss'] }
Plug 'brooth/far.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'cocopon/iceberg.vim'
Plug 'editorconfig/editorconfig-vim'
" Plug 'flazz/vim-colorschemes'
Plug 'honza/vim-snippets'
Plug 'jparise/vim-graphql' " TODO this is removed from vim-polyglot for now
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mhinz/vim-startify'
Plug 'ntpeters/vim-better-whitespace'
Plug 'peitalin/vim-jsx-typescript', { 'for': ['ts', 'tsx'] }
Plug 'Raimondi/delimitMate'
Plug 'romainl/flattened'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
" Plug 'sheerun/vim-polyglot', { 'for': ['jsx'] }
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
" }}}

" {{{ Basic settings
"
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
  syntax enable                  " Enable syntax highlight
end

" force utf-8 encoding cause we have multi-bytes chars here
scriptencoding utf-8

set autowrite                       " Save changes before switching buffers
set completeopt-=preview            " Get rid of the annoying preview window on autocomplete
set expandtab                       " Expand tabs to spaces
set fillchars+=vert:│               " Make vertical split bar prettier
" set guicursor=                      " Seems buggy? Have to unset to mitigate junk chars
set ignorecase                      " Make search case-insensitive
set list                            " Enable whitespace characters' display
set listchars=nbsp:¬,tab:»·,trail:· " Better whitespace symbols
set mouse=a                         " Grab mouse event within tmux
set lazyredraw                      " FIXME mitigate with jsx until find a fix
set nobackup                        " Be environment friendly
set backupcopy=no                   " Be environment friendly
set noshowmode                      " Hide the default mode text cause we have *whatever*line
set noshowcmd                       " Hide the annoying command from bottom right
set noswapfile                      " Get rid of the annoying .swp file
set nowrap                          " Don't wrap on long lines
set nowritebackup                   " Write file in place
set number                          " Display line numbers on the left
set pastetoggle=<F2>                " bind paste mode for ease of use
set scrolloff=6                     " Have some context around the current line always on screen
set signcolumn=yes                  " always display the sign column to avoid content flickering
set shiftwidth=2                    " Number of spaces to use for each step of (auto)indent
set showtabline=0                   " Don't need the tab line man
set smartcase                       " Make search case-insensitive smart!
set smartindent                     " Do smart auto indenting when starting a new line
set spell                           " Check spell is good when we added all the keywords!
set spelllang=en_us                 " Use en_us for better collaboration, sorry en_gb
set splitbelow                      " Intuitively split to below when doing horizontal split
set splitright                      " Split to right when doing vertical split
set synmaxcol=180                   " Limit syntax color for long lines to improve rendering speed
set tabstop=2                       " Number of spaces that a <Tab> in the file counts for
set tags=./.tags,./tags,.tags,tags; " Use hidden tags files
set undodir=~/.vim/undo/            " Persistent undo directory
set undofile                        " Persistent undo
set updatetime=666                  " Make update related events slightly faster
let &showbreak='↪ '                 " Make soft wrap visually appealing FIXME not showing up?
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
let g:airline_section_a                        = ''
let g:airline_section_b                        = ''
" let g:airline_section_c                        = ''
let g:airline_section_x                        = ''
let g:airline_section_z                        = airline#section#create(["%{col('.')}:%{line('.')}"])
let g:airline_symbols_ascii                    = 1
" }}}


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" TODO get familiar with this
let g:UltiSnipsExpandTrigger='<c-e>'
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

function! TextMagic()
  set textwidth=0
  set wrapmargin=0
  set colorcolumn=79
  " FIXME
  " - this will get reset on window resize, need to prevent that
  " - columns are buggy with multiple buffers
  " set columns=100
  set linebreak
  set nolist
  set wrap
  nmap j gj
  nmap k gk
  " FIXME can't link to LineNr due to a bug
  hi ColorColumn ctermbg=239 guibg=#242a32
endfunction

"
" Custom Highlight rules
" XXX note vim-better-whitespace does not deal with leading tabs
"
function! CustomHighlights()
  syntax match PeskyTabs /\v\t+/
endfunction

"
" auto commands that make your life easier
"
" XXX no space is allowed between events
augroup general_enhancements
  autocmd!
  autocmd BufCreate * call SetUpBuffer()
  autocmd BufEnter *.log set nospell " no spell check for log files
  autocmd BufEnter *.md set nowrap
  autocmd BufEnter *.md,*.txt,*.doc,*.rst call TextMagic()
  autocmd BufEnter,InsertLeave * set cursorline
  autocmd BufLeave,InsertEnter * set nocursorline
  autocmd BufEnter * call CustomHighlights()

  " FIXME temporary workaround for Docker issue
  autocmd BufEnter *Dockerfile set ft=dockerfile

  " FIXME use filetype to disable cursorline within fugitiveblame

  " temporary disabled during the refactoring period
  " autocmd BufWritePre * StripWhitespace " strip whitespaces on save

  autocmd VimResized * wincmd =  " make panes responsive on window resize
  autocmd FocusGained,BufEnter * checktime " make autoread behave intuitively
augroup END



" {{{ PlantUML enchancements
"
" dependencies:
" - plantuml/plantuml-server docker image for set up the server
"   docker run -d -p 8080:8080 plantuml/plantuml-server
" - npm package node-plantuml for encode the uml file
"   npm i -g node-plantuml
"
" the prototype will try to encode the uml file upon save, and communicate
" with the server, then open a viewer if it's not opened yet
" TODO need to make this asynchronous, checkout jobstart
"
function! RenderPlantUML()
  echo 'generating PlantUML diagram...'
  let l:file_path = expand('%:p')
  let l:file_dir = expand('%:p:h')
  let l:png_name = expand('%:r') . '.png'
  let l:png_path = l:file_dir . '/' . l:png_name
  let l:cmd = '!curl -sS "localhost:8080/png/$(puml encode ' . l:file_path . ')" -o ' . expand('%:r') . '.png'
  let l:cmd = l:cmd . " && (ps x | pgrep -af '". l:png_path . "$' && : || xdg-open " . l:png_path . ')'
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

"
" Smart Python env finder
"
function! s:match_highlight(highlight, pattern) abort
  let matches = matchlist(a:highlight, a:pattern)
  if len(matches) == 0
    return 'NONE'
  endif
  return matches[1]
endfunction

" use Python from virtual env
let g:conda_venv_dir = system('clever_conda_path' . ' ' . expand('%'))
if empty(g:conda_venv_dir)
  let g:ycm_python_binary_path = 'python'
else
  let g:ycm_python_binary_path = g:conda_venv_dir . '/bin/python'
  let g:ale_virtualenv_dir_names = [g:conda_venv_dir]
endif

function! ShowPythonPath()
  if !empty(g:conda_venv_dir)
    echohl Question " pity that there isn't an appropriate hi group
    echo 'Found and loaded Python virtual env from: ' . g:conda_venv_dir
    echohl None
  endif
endfunction

augroup tmp
  autocmd VimEnter * call ShowPythonPath()
augroup END

" typescript setup for YCM
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

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
let g:linter_sign = ' •'   " good on Ubuntu mono
" let g:git_sign = '┃ '      " good on Ubuntu mono
let g:git_sign = '│ '      " good on Ubuntu mono

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
let g:gitgutter_sign_removed = g:git_sign
let g:gitgutter_sign_removed_first_line = g:git_sign

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
  highlight ALEWarningSign        guifg=#FF9900 guibg=NONE

  highlight YcmErrorSign          guifg=#FB4934 guibg=NONE
  highlight YcmWarningSign        guifg=#FF9900 guibg=NONE

  highlight GitGutterAdd          guifg=#98C379 guibg=NONE ctermbg=NONE
  highlight GitGutterChange       guifg=#FF9900 guibg=NONE ctermbg=NONE
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

endfunction
let g:show_spaces_that_precede_tabs=1

" Adapt sign color upon color theme change
augroup colorscheme_tweaks
  autocmd!
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
nnoremap <leader>gb :Gblame<CR>
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
nnoremap <leader>r :!%:p<CR><CR>

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
nnoremap <A-]> :GitGutterNextHunk<CR>
nnoremap <A-[> :GitGutterPrevHunk<CR>
" nmap <silent> <A-[> <Plug>(ale_previous_wrap)
" nmap <silent> <A-]> <Plug>(ale_next_wrap)

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

" Tagbar Toggle
nnoremap <silent> <C-t> :TagbarToggle<CR>

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
map <F10> :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`<CR>

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

" Fzf bindings
function! SmartFindFiles()
  " FindRootDirectory from vim-rooter
  let l:dir = FindRootDirectory()
  let l:cwd = getcwd()

  if empty(l:dir)
    let l:dir = l:cwd
    let l:cmd = 'ag --nocolor -l'
  else
    let l:cmd = $GIT_DEFAULT_LS_COMMAND

    if empty(l:cmd)
      let l:cmd = 'git ls-files --cached --others --exclude-standard'
      echo '$GIT_DEFAULT_LS_COMMAND is not set'
      return
    endif

    if l:cwd !~? l:dir " remove leading path that duplicates with cwd
      let l:cmd = l:cmd . " | awk '$0=\"" . l:dir . "/\"$0'"
    endif
  endif

  echo 'searching using "' . l:cmd . '" ...'
  call fzf#run(fzf#wrap({'source': l:cmd, 'dir': l:dir, 'down': '~18'}))
endfunction

" FIXME why the hell the results does not show immediately after trigger?
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

if !empty(glob('~/.vimrc.after'))
  source ~/.vimrc.after
end

" {{{ Initialization
"
augroup welcome
  autocmd VimEnter *
              \   if !argc()
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | endif
augroup END
" }}}

" vim: set ai tw=119 foldmethod=marker :
