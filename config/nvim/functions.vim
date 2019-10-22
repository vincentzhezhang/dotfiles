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
" FIXME neomake is deprecated by ale, need to update accordingly
" - make it path agnostic
" function! PreferLocalNodeBinaries()
"   let l:local_eslint = $PWD . '/node_modules/.bin/eslint'
"   let l:global_eslint = system('which eslint')
" 
"   if executable(l:local_eslint)
"     let g:neomake_javascript_eslint_exe = l:local_eslint
"   elseif executable(l:global_eslint)
"     let g:neomake_javascript_eslint_exe = l:global_eslint
"   endif
" endfunction
" 
" augroup node_path_hack
"   autocmd BufEnter *.js* call PreferLocalNodeBinaries()
" augroup END

"
" Vim Plug callback functions
"
" Note: info is a dictionary with 3 fields
" - name:   name of the plugin
" - status: 'installed', 'updated', or 'unchanged'
" - force:  set on PlugInstall! or PlugUpdate!
"
function! BuildYCM(...)
  " build YouCompleteMe using the same Python3 as used by
  " g:ycm_server_python_interpreter
  " XXX only enable Python (default) and JS (ts-completer) for now to save
  " compile time
  if a:0 < 1 || a:1.status ==? 'installed' || a:1.status ==? 'updated' || a:1.force
    execute '!' . g:ycm_server_python_interpreter . ' install.py --ts-completer'
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
let g:gruvbox_italic = 1
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_contrast_dark = 'soft'

function SunnyDays()
  colorscheme flattened_light
  set background=light
endfunction

let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
function InDoor()
  colorscheme deus
  " colorscheme nord
  set background=dark
endfunction

function LateNight()
  colorscheme chlordane
  set background=dark
endfunction

function! CycleTheme()
  let l:themes = ['InDoor', 'LateNight', 'SunnyDays']
  let g:theme_index = get(g:, 'theme_index', 0)
  let g:theme_index = (g:theme_index + 1) % len(l:themes)
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
  let l:need_init = 0
  if has('nvim') && empty(glob('~/.config/nvim/autoload/plug.vim'))
    let l:need_init = 1
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  elseif empty(glob('~/.vim/autoload/plug.vim'))
    let l:need_init = 1
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  else
    " do nothing
  endif
endfunction

" TODO: try to iterate through g:plug_orders and auto load options for vim
function Z(...)
  Plug(a:000)
endfunction

" file type detection for templates
function PolyFT()
  let l:tmpl_list = ['mako', 'jinja']
  let l:ext = expand('%:e')
  let l:file_types = []

  " FIXME truthy check?
  if len(l:ext) > 0
    if index(l:tmpl_list, l:ext) == -1
      return
    endif

    call add(l:file_types, l:ext)
  endif

  let l:first_line = getline(1)

  if l:first_line =~# '^{'
    call insert(l:file_types, 'json')
  elseif l:first_line =~# '^\[^]]+\]$' || l:first_line =~# '---\s\=$'
    call insert(l:file_types, 'yaml')
  elseif l:first_line =~# '[^:]:\s\=$' || l:first_line =~# '---\s\=$'
    call insert(l:file_types, 'yaml')
  elseif l:first_line =~# 'html>$'
    call insert(l:file_types, 'html')
  elseif l:first_line =~# '^<[^>]*>\s\=$'
    call insert(l:file_types, 'xml')
  endif

  " echo 'set ft via script: ' . l:ext . index(l:tmpl_list, l:ext)

  let l:file_type = join(l:file_types, '.')
  let g:bbq = join(l:file_types, '.')
  let &filetype=l:file_type
endfunction

" TODO
" - add more template extension if needed
" - also need to add separate logic for files has no type detected, note this
"   is different from file without extension
augroup poly_file_type
  autocmd BufEnter *.mako call PolyFT()
augroup END
