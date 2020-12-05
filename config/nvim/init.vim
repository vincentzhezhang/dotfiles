" {{{ FIXME
" }}}

" {{{ TODO
" - function for setting correct python path if a venv is available
" - add contional loading for pluggins
" - make use of prettier, yapf, and other fixers with ALE
" - check if there is a way to only highlight search keywords in current buffer
" - learn far.vim
" - think about the colorscheme crap
" }}}

" force utf-8 encoding cause we have multi-bytes chars here
scriptencoding utf-8

" {{{ Environments
let g:vim_conf_root  = $XDG_CONFIG_HOME

if empty(g:vim_conf_root)
  let g:vim_conf_root = expand('<sfile>:p:h:h')
endif

" Make use of bash utilities in vim
let $BASH_ENV = g:vim_conf_root . '/bash/noninteractive'
" }}}

let g:before_hook = g:vim_conf_root . '/nvim/before.vim'
let g:after_hook = g:vim_conf_root . '/nvim/after.vim'

if filereadable(g:before_hook)
  execute 'source' g:before_hook
endif

execute 'source' g:vim_conf_root . '/nvim/variables.vim'
execute 'source' g:vim_conf_root . '/nvim/functions.vim'

" load my personal plugins
for f in split(glob(g:vim_conf_root . '/nvim/my/*.vim'), '\n')
  execute 'source' f
endfor

" {{{ Plugins
call EnsureVimPlug()
call plug#begin(g:vim_conf_root . '/nvim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'ajmwagar/vim-deus'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'brooth/far.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'liuchengxu/vista.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'NLKNguyen/papercolor-theme'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'SirVer/ultisnips'
Plug 'terryma/vim-multiple-cursors'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/chlordane.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()
call EnsureVimPlugPlugins()
" }}}

" {{{ Basic settings
set autowrite                             " Save changes before switching buffers
set cursorline                            " Highlight the screen line of the cursor with CursorLine
set completeopt-=preview                  " Get rid of the annoying preview window on autocomplete
set expandtab                             " Expand tabs to spaces
set fillchars+=vert:│                     " Make vertical split bar prettier
set foldopen+=jump                        " Open folded region when jump to it
set ignorecase                            " Make search case-insensitive
set list                                  " Enable whitespace characters' display
set listchars=nbsp:¬,tab:»·,trail:·       " Better whitespace symbols
set mouse=a                               " Grab mouse event within tmux
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
set termguicolors                         " Enables 24-bit RGB color in the TUI.  Uses GUI highlight
set undofile                              " Persistent undo, note undodir default to xdg data
set updatetime=128                        " Make update related events slightly faster
set winblend=9                            " Pseudo transparency for floating window
let &showbreak='↪ '                       " Make soft wrap visually appealing FIXME not showing up?
" }}}

" change leader key
let g:mapleader=' '

" make some commands case-insensitive
command! Q q
command! W w

" silent on save when editing remote files
let g:netrw_silent=1

" global variables shared by plugins
let g:linter_sign = ' •'
let g:git_sign = '┃ '

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
  " make editing text files more intuitive
  set wrap
  nmap j gj
  nmap k gk
  nmap 0 g0
  nmap $ g$
endfunction

augroup general_enhancements
  autocmd!
  autocmd FileType tagbar,nerdtree,help setlocal signcolumn=no
  autocmd BufEnter *.log setlocal nospell
  autocmd BufEnter *.md,*.txt,*.doc,*.rst call TextMagic()
  autocmd VimResized * wincmd =  " make panes responsive on window resize
  autocmd FocusGained,BufEnter * checktime " make autoread behave intuitively
augroup END

" {{{ Python Virtual Env Tweaks start
if isdirectory(glob('$__conda_env_root'))
  let g:py3_path = glob('$__conda_env_root/py3/bin/python')
endif

if exists('$CONDA_PREFIX')
  " use Python from active conda environment
  let g:py_virtual_env_dir = '$CONDA_PREFIX'
else
  " or find the suitable environment by given file or cwd using bash add-on
  let s:current_path = argc() ? expand('%:p') : getcwd()
  let g:py_virtual_env_dir = system('2>/dev/null' . ' ' . '__.venv.python.prefix' . ' ' . s:current_path)
endif

" XXX
" According to [pep-0486](https://www.python.org/dev/peps/pep-0486/#id5)
" both virtual_env and the core venv module set the VIRTUAL_ENV environment
" variable thus it's been used by many Python plugins, so we set it here too
" to get their features for free
let $VIRTUAL_ENV = g:py_virtual_env_dir
let $PYTHONPATH = g:py_virtual_env_dir
let $PATH = g:py_virtual_env_dir . '/bin' . ':' . $PATH
" FIXME https://mypy.readthedocs.io/en/latest/running_mypy.html#finding-imports
" let $MYPYPATH = expand(g:py_virtual_env_dir . '/lib/*/site-packages')
" }}}

" better find and replace
vnoremap <C-r> "hy:%s/<C-r>h//c<left><left>


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

"
" Centralized movement
"
nnoremap <silent> <CR> :nohlsearch<CR><CR>
nnoremap <silent> gg ggzz

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
nnoremap <silent> <F9> :set cursorcolumn!<CR>

" Quick edit .vimrc
nnoremap <leader>V :e $MYVIMRC<CR>

" Break line at cursor
nnoremap <leader>j i<return><esc>

" find word under cursor
nnoremap <silent> <leader>ag :Ag <C-R><C-W><CR>
" find whitespace delimited segments
nnoremap <silent> <leader>AG :Ag <C-R><C-A><CR>
" find selection
xnoremap <silent> <leader>rw y:Ag <C-R>"<CR>

nnoremap <silent> <leader>f :call SmartFindFiles()<CR>
nnoremap <silent> <leader>B :Buffers<CR>
" fast switch with previous buffer
nnoremap <silent> <leader>b :b#<CR>
nnoremap <silent> <leader>L :Lines<CR>


" FIXME need to have a second thought on this
" nnoremap <silent> <C-h> :vertical res +10<CR>
" nnoremap <silent> <C-j> :res +5<CR>
" nnoremap <silent> <C-k> :res -5<CR>
" nnoremap <silent> <C-l> :vertical res -10<CR>

"
" load plugin configs
"
for config in split(glob(g:vim_conf_root . '/nvim/pluginrc.d/*.vim'), '\n')
  " use base filename without extension as the plugin name
  let s:plugin_name = split(config, '/')[-1][0:-5]
  if has_key(g:plugs, s:plugin_name)
    execute 'source' config
  endif
endfor

if filereadable(g:after_hook)
  execute 'source' g:after_hook
endif

" {{{ Initialization
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
