" TODO: add contional loading for pluggins
" TODO: try https://github.com/Chiel92/vim-autoformat
" TODO: fix cursorline caused slowness, in fast scroll and gblame
"
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
" TODO custom gx command for plugin source:
"
" The gx mapping is calling netrw#BrowseX(), so you could call that at the end
" of your function, passing in the l:site variable you've constructed:
"
" call netrw#BrowseX(l:site, netrw#CheckIfRemote())
" I would also suggest that instead of getline('.'), you use
" expand('<cfile>'), which evaluates to the filename under the cursor. This
" will work when the URL is on a line containing other content as well.
call SetupVimPlug() " in case vim-plug is missing
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ajmwagar/vim-deus'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'arcticicestudio/nord-vim', { 'branch': 'develop' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'digitaltoad/vim-pug'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json', { 'for': ['json'] }
Plug 'ericpruitt/tmux.vim', { 'rtp': 'vim' }
Plug 'flazz/vim-colorschemes'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color', { 'for': ['css', 'sass', 'scss'] }
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'kewah/vim-stylefmt'
Plug 'Lokaltog/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'mhinz/vim-startify'
Plug 'moll/vim-node'
Plug 'morhetz/gruvbox'
Plug 'mxw/vim-jsx', { 'for': ['javascript.jsx'] }
Plug 'mileszs/ack.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'plasticboy/vim-markdown'
Plug 'Raimondi/delimitMate'
Plug 'romainl/flattened'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-ruby/vim-ruby', { 'for': ['ruby', 'haml', 'erb'] }
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'wavded/vim-stylus'
Plug 'Xuyuanp/nerdtree-git-plugin'
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
set guicursor=                      " Seems buggy? Have to unset to mitigate junk chars
set ignorecase                      " Make search case-insensitive
set list                            " Enable whitespace characters' display
set listchars=nbsp:¬,tab:»·,trail:· " Better whitespace symbols
set mouse=a                         " Grab mouse event within tmux
set nobackup                        " Be environment friendly
set noshowmode                      " Hide the default mode text cause we have *whatever*line
set noswapfile                      " Get rid of the annoying .swp file
set nowrap                          " Don't wrap on long lines
set nowritebackup                   " Write file in place
set number                          " Display line numbers on the left
set pastetoggle=<F2>                " bind paste mode for ease of use
set scrolloff=6                     " Have some context around the current line always on screen
set signcolumn=yes                  " always display the sign column to avoid content flickering
set shiftwidth=2                    " Number of spaces to use for each step of (auto)indent
set showtabline=2                   " Always display the tabline, even if there is only one tab
set smartcase                       " Make search case-insensitive smart!
set smartindent                     " Do smart auto indenting when starting a new line
set spell                           " Enable spell check
set spelllang=en_us                 " Use en_us for better collaboration, sorry en_gb
set splitbelow                      " Intuitively split to below when doing horizontal split
set splitright                      " Split to right when doing vertical split
set synmaxcol=256                   " Limit syntax color for long lines to improve rendering speed
set tabstop=2                       " Number of spaces that a <Tab> in the file counts for
set tags=./.tags,./tags,.tags,tags; " Use hidden tags files
set undodir=~/.vim/undo/            " Persistent undo directory
set undofile                        " Persistent undo
set updatetime=1000                 " Make update related events slightly faster

let &showbreak='↪ '     " Make soft wrap visually appealing

" TODO verify airline symbol display with Fantastique Sans Mono on different
" screen/font-size/dpi combinations, see left/right_sep below
" airline tweaks
call airline#parts#define_accent('file', 'bold')

let g:airline#extensions#tabline#enabled        = 1
let g:airline#extensions#whitespace#enabled     = 0
let g:airline_detect_spell                      = 0
let g:airline_inactive_collapse                 = 1
let g:airline_left_alt_sep                      = '│'
let g:airline_left_sep                          = ''
let g:airline_powerline_fonts                   = 1
let g:airline_right_alt_sep                     = '│'
let g:airline_right_sep                         = ''
let g:airline_section_b                         = ''
let g:airline_section_x                         = ''
let g:airline#parts#ffenc#skip_expected_string  = 'utf-8[unix]'
let g:airline#extensions#tabline#tab_nr_type    = 2

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
"
" auto commands that make your life easier
"
augroup general_enhancements
  autocmd!
  autocmd BufCreate * call SetUpBuffer()
  autocmd BufEnter *.log set nospell "no spell check for log files
  autocmd BufEnter,InsertLeave * set cursorline
  autocmd BufLeave,InsertEnter * set nocursorline

  " FIXME use filetype to disable cursorline within fugitiveblame

  " temporary disabled during the refactoring period
  " autocmd BufWritePre * StripWhitespace " strip whitespaces on save

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
let g:used_javascript_libs = 'underscore,react'

" let g:ycm_min_num_of_chars_for_completion = 2
" use Python from virtual env
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1

" TODO make NERDCommenter smarter, i.e.
" - omni shortcut to toggle comment on/off
" - detect mode automatically and apply corresponding style
" - use comment line left align as default

" jsx settings if want to have jsx in side js
let g:jsx_ext_required = 0
let g:NERDTreeWinSize = 30
let g:NERDTreeMinimalUI = 1

" color filename as well by file type in NERDTree
let g:NERDTreeFileExtensionHighlightFullName = 1

" Nerd Commenter
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
nnoremap <C-_> :call NERDComment('n', 'toggle')<CR>
xnoremap <C-_> :call NERDComment('x', 'toggle')<CR>

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
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 0

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

" handy selection of symbols
" poker suits:    ♠ ♥ ♣ ♦
" common symbols: •
" table maker:    ─━
" block symbols:  ░▒▓
" white space:    ] [(em)
let g:ale_sign_error = ' ━'
let g:ale_sign_warning = ' ━'
let g:ale_sign_column_always = 1
" FIXME This seems problematic, it raises CssSyntaxError on the first line
" let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
" let g:ale_linter_aliases = {'jsx': 'css'}

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
  "TODO seems like flattnend (solarized alternative) set guibg to Grey which
  "is weird
  let [l:guibg, w, t, f] = s:get_highlight('SignColumn')
"
  execute 'highlight ALEErrorSign   guifg=#ff3300 guibg=' . l:guibg
  execute 'highlight ALEWarningSign guifg=#ff9900 guibg=' . l:guibg

  " HACK make vertical split sign invisible
  highlight VertSplit gui=NONE guifg=NONE guibg=NONE
endfunction

" smarter project root by vim-rooter, very useful when combined with fzf below
let g:rooter_patterns = [
  \ 'package.json',
  \ 'setup.py',
  \ '.git',
  \ '.git/',
  \ ]
let g:rooter_resolve_links = 1
let g:rooter_manual_only = 1

" Adapt sign color upon color theme change
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
nnoremap <F6> :!%:p<Enter>

"
" Centralized movement
"
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> gg ggzz

"
" consistent next/prev result keymapping
"
nnoremap <expr> n (v:searchforward ? 'nzz' : 'Nzz')
nnoremap <expr> N (v:searchforward ? 'Nzz' : 'nzz')


" Quick jump between recent two buffers

" Quick switch between numbers ruler
nnoremap <silent> <F12> :set number!<CR>

" Tagbar Toggle
nnoremap <silent> <C-t> :TagbarToggle<CR>
" jump to first match
nnoremap <C-]> g<C-]>

" Quick edit .vimrc
nnoremap <leader>V :e $MYVIMRC<CR>

" Break line at cursor
nnoremap <leader>j i<return><esc>

" NERDTree
map <C-\> :NERDTreeFind<CR> | wincmd p

" FIXME this only works with Python (hopefully), will need a proper
" implementation
map <F10> :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`<CR>

function! FindReferenceOfCurrentFile()
  " call fzf#vim#ag(expand('%:t:r'))
  let l:root = FindRootDirectory()
  let l:extension = strpart(expand('%:e'), 0, 2)
  let l:filename = expand('%:t:r')
  let l:search = 'ag --color --nogroup --word-regexp --' . l:extension . ' ' . l:filename
  echo l:search
  call fzf#run(fzf#wrap({ 'source': l:search }))
endfunction
nnoremap <silent> <leader>rf :call FindReferenceOfCurrentFile()<CR>

" find word under cursor
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
" find whitespace delimited segments
nnoremap <silent> <leader>AG :Ag <C-R><C-A><CR>
" find selection
xnoremap <silent> <leader>rw y:Ag <C-R>"<CR>

" Fzf bindings
function! FindFilesInCurrentProject()
  let l:args = FindRootDirectory()
  let l:cmd = 'git ls-files --cached --others --exclude-standard '
  call fzf#run(fzf#wrap({'source': l:cmd . l:args}))
endfunction
nnoremap <silent> <leader>f :call FindFilesInCurrentProject()<CR>
nnoremap <silent> <leader>B :Buffers<CR>
" fast switch with previous buffer
nnoremap <silent> <leader>b :b#<CR>
nnoremap <silent> <leader>L :Lines<CR>

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
