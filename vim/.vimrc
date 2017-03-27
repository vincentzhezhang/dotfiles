" TODO: try vim-easy-align
" TODO: extract variables into .vim/variables.vim
" TODO: check if file detection could work for the file/directory before load the plugins
" TODO: set up Python Environment management
"
if !empty(glob('~/.vimrc.before'))
  source ~/.vimrc.before
end

source ~/.vim/variables.vim
" load helper functions
source ~/.vim/functions.vim

call SetupVimPlug()

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ap/vim-css-color'
Plug 'bling/vim-bufferline'
Plug 'chriskempson/base16-vim'
Plug 'digitaltoad/vim-pug'
Plug 'editorconfig/editorconfig-vim'
Plug 'elzr/vim-json'
Plug 'flazz/vim-colorschemes'
Plug 'godlygeek/tabular'
Plug 'gregsexton/gitv'
Plug 'hail2u/vim-css3-syntax'
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --all' }
Plug 'klen/pylama'
Plug 'Lokaltog/vim-easymotion'
Plug 'lifepillar/vim-solarized8'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-startify'
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
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wakatime/vim-wakatime'
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
  set autoread        " Autoreload buffers
  set encoding=utf-8  " Use UTF-8 encoding
  set hlsearch        " Highlight search results
  set laststatus=2    " Always display the statusline in all windows
  set nocompatible    " be advanced
  set smarttab
  set ttyfast
  syntax enable       " Enable syntax highlight
  " bind paste mode for ease of use
  " TODO: migrate from function keys to other combination as I am going to use
  " smaller keyboard layout
  set pastetoggle=<F2>
end

scriptencoding utf-8

" General formatting config
set autowrite                   " Save changes before switching buffers
set backspace=indent,eol,start  " Make backspace behave more normally
set cursorline
set expandtab                   " Expand tabs to spaces
set exrc
set fileencodings=utf-8
set list
set listchars=nbsp:¬,tab:»·,trail:·
set nobackup
set noswapfile
set nowrap
set nowritebackup               " Write file in place
set number
set secure                      " Only execute safe per-project vimrc commands
set shiftwidth=2
set smartindent
set softtabstop=0
set tabstop=2

" General behavioral config
set splitbelow
set splitright

" needs cleanup
" Recommended settings from powerline
set showtabline=2       " Always display the tabline, even if there is only one tab
set noshowmode          " Hide the default mode text
let &showbreak='↪ '     " Make soft wrap more visible

" airline tweaks
let g:airline_powerline_fonts=1
let g:airline_detect_spell=0
let g:airline_left_sep=''
let g:airline_right_sep=''
" this shall be handled by vim-better-whitespaces
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline#extensions#branch#enabled = 0

" case-insensitive for some common commands
command! Q q
command! W w

" turn off Ex mode
map Q <Nop>
" turn off Recording mode
map q <Nop>

" strip trailing whitespace before save
augroup cleanup
  autocmd!
  autocmd BufWritePre * StripWhitespace
augroup END

" trigger Neomake automatically
augroup neomake_hooks
  autocmd!
  autocmd BufWinEnter * Neomake
  autocmd BufWritePost * Neomake
augroup END

" Quick switch between numbers ruler
noremap <silent> <F12> :set number!<CR>

" should add proper ability detection
if empty($TERMINATOR_UUID) && empty($SSH_CONNECTION)
  if exists('+termguicolors')
    set termguicolors
  endif
endif

" some OS detection and customization here, should bind some dark/light theme
" switcher hotkey
let s:uname = system('uname -s')
let s:hostname = system('uname -n')
let s:sys_hour = str2nr(system("date '+%k'"))
" TODO: dynamic day/night range from system or external API
" NOTE: as the office has constant lighting environment, keep it dark
let s:sunrise = 18
let s:sunset = 8

" Adaptive colorscheme switching
if s:sys_hour >= s:sunrise && s:sys_hour <= s:sunset
  call LightSide()
else
  call DarkSide()
end

" display a recommended column width guide and gray out columns after maximum
" width
" if exists('+colorcolumn')
"   let &colorcolumn='80'
"   if s:sys_hour >= s:sunrise && s:sys_hour <= s:sunset
"     highlight ColorColumn ctermbg=7
"   else
"     highlight ColorColumn ctermbg=237
"   end
" endif

" Syntastic recommended settings
" TODO: check if this is deprecated
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set synmaxcol=256   " limit syntax color for long lines
set scrolloff=3     " Have some context around the current line always on screen
highlight Search ctermfg=202 ctermbg=NONE cterm=bold,underline

augroup ruby_rails_debug_statements
  " Make those debugger statements painfully obvious
  au BufEnter *.rb syn match error contained "\<binding.pry\>"
  au BufEnter *.rb syn match error contained "\<debugger\>"
augroup END

augroup javascript_debug_statements
  " Make those debugger statements painfully obvious
  au BufEnter *.js syn match error contained "\<console\>"
  au BufEnter *.js syn match error contained "\<debugger\>"
  au BufEnter *.jsx syn match error contained "\<console\>"
  au BufEnter *.jsx syn match error contained "\<debugger\>"
augroup END

" language specific format settings
" TODO: try to see if iteration can be used here
augroup indentations
  autocmd!
  autocmd FileType text         setlocal wrap
  autocmd FileType markdown     setlocal wrap
  autocmd FileType c            setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType cpp          setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType python       setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType sh           setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType javascript   setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" change leader key
let g:mapleader=' '

" some key remappings to resolve conflict brought by vim-multiple-cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
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

" quick switch between spit panes
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Run the current script according to shebang!
nnoremap <F8> :!%:p<Enter>

" Clean search highlight when enter is pressed
nnoremap <silent> <CR> :nohlsearch<CR><CR>

" quick jump between recent two files
nnoremap <leader>b :b#<cr>

" quick edit .vimrc
nnoremap <leader>V :e $MYVIMRC<cr>

" Break line at cursor
nnoremap <leader>j i<return><esc>

" NERDTree
map <C-\> :NERDTreeFind<CR>
let g:NERDTreeWinSize=30
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


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

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Disable vim-json double quotes concealing as it's a bit awkward for me
let g:vim_json_syntax_conceal = 0

" Disable python-mode folding as it's quite annoying to me actually
let g:pymode_folding = 0
" Disable python-mode rope look up as it's painfully slow
let g:pymode_rope = 0
let g:pymode_rope_lookup_project = 0
" Disable 80 columns as this will be enforced by linters
let g:pymode_options_colorcolumn = 0

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
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
