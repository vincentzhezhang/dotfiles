"
" Here contains all the helper functions for vim
"
"

" copy reference of current line to system clipboard
function! CopyReference()
  let l:reference = join([expand('%'), line('.')], ':')
  call system('echo ' . l:reference . ' | xclip -sel clip')
  echo 'copied ' . l:reference . ' to system clipboard!'
endfunction
nnoremap <leader>r :call CopyReference()<CR>

"
" Open help in new tabs with less like quit, courtesy junegunn
"
function! s:helptab()
  if &buftype ==# 'help'
    wincmd T
    nnoremap <buffer> q :q<cr>
  endif
endfunction

augroup vimrc
  autocmd BufEnter *.txt call s:helptab()
augroup END

" Use local node binaries if possible, with fallback to global binaries
" Currently just for eslint, will add other stuff
" TODO
" - make it path agnostic
function! PreferLocalNodeBinaries()
  let l:local_eslint = $PWD . '/node_modules/.bin/eslint'
  let l:global_eslint = system('which eslint')

  if executable(l:local_eslint)
    let g:neomake_javascript_eslint_exe = l:local_eslint
  elseif executable(l:global_eslint)
    let g:neomake_javascript_eslint_exe = l:global_eslint
  endif
endfunction

augroup node_path_hack
  autocmd BufEnter *.js* call PreferLocalNodeBinaries()
augroup END

"
" Vim Plug callback functions
"
" Note: info is a dictionary with 3 fields
" - name:   name of the plugin
" - status: 'installed', 'updated', or 'unchanged'
" - force:  set on PlugInstall! or PlugUpdate!
function! BuildYCM(...)
  if a:0 < 1 || a:1.status ==? 'installed' || a:1.status ==? 'updated' || a:1.force
    !./install.py --clang-completer --tern-completer
  endif
endfunction

function! InstallRubySupport(...)
  if a:0 < 1 || a:1.status ==? 'installed' || a:1.force
    !gem install neovim
  endif
endfunction

" TODO: might need to check conda related python env management
function! InstallPythonSupport(...)
  if a:0 < 1 || a:1.status ==? 'installed' || a:1.force
    !pip  install --upgrade --user neovim
    !pip2 install --upgrade --user neovim
    !pip3 install --upgrade --user neovim
  endif
endfunction

"
" quick switch between color schemes
"
let g:gruvbox_italic=1
let g:gruvbox_contrast_light='soft'
let g:gruvbox_contrast_dark='soft'

function SunnyDays()
  colorscheme flattened_light
  set background=light
endfunction

let g:nord_italic_comments = 1

function InDoor()
  colorscheme deus
  set background=dark
endfunction

function LateNight()
  colorscheme chlordane
  set background=dark
endfunction

function! CycleTheme()
  let l:themes = ['InDoor', 'LateNight', 'SunnyDays']
  let g:theme_index = get(g:, 'theme_index', 0)
  let g:theme_index = (g:theme_index+1)%len(l:themes)
  let l:t = l:themes[g:theme_index]
  call {l:t}()
endfunction
nmap <silent> <F5> :call CycleTheme() <CR>

"
" Other handy helpers
"
function ToggleSyntax()
  if exists('g:syntax_on')
    syntax off
  else
    syntax enable
  endif
endfunction
nmap <silent> <C-F12> :call ToggleSyntax()<CR>

" Install plug for Vim/NeoVim if not exist
" FIXME: could extract the common part
function SetupVimPlug()
  if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  elseif empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endfunction

" TODO: try to iterate through g:plug_orders and auto load options for vim
function Z(...)
  Plug(a:000)
endfunction
