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

"
" Vim Plug callback functions
"
" Note: info is a dictionary with 3 fields
" - name:   name of the plugin
" - status: 'installed', 'updated', or 'unchanged'
" - force:  set on PlugInstall! or PlugUpdate!
"
function! BuildYCM(...)
  " XXX
  " - g:ycm_server_python_interpreter is current set to g:python3_host_prog
  " - only enable certain completer for now:
  "   - Python (default)
  "   - JS/TS
  if a:0 < 1 || a:1.status ==? 'installed' || a:1.status ==? 'updated' || a:1.force
    execute '!' . g:ycm_server_python_interpreter . ' install.py --ts-completer'
  endif
endfunction

function! EnsureRubySupport(...)
  " TODO
  " - add rbenv support if necessary
  !gem install neovim
endfunction
command! EnsureRubySupport call EnsureRubySupport()

function! EnsurePythonSupport(...)
  execute '!' . g:python3_host_prog . '-m pip  install --upgrade --user neovim'
endfunction
command! EnsurePythonSupport call EnsurePythonSupport()

"
" quick switch between color schemes
"
let g:gruvbox_italic = 1
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_contrast_dark = 'soft'

function SunnyDays()
  colorscheme PaperColor
  set background=light
endfunction

let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
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
  let g:theme_index = (g:theme_index + 1) % len(l:themes)
  let l:t = l:themes[g:theme_index]
  call {l:t}()
  let &syntax = &syntax
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
function EnsureVimPlug()
  if has('nvim')
    let l:plug_path='~/.config/nvim/autoload/plug.vim'
  else
    let l:plug_path='~/.vim/autoload/plug.vim'
  endif

  if empty(glob(l:plug_path))
    echo 'Installing Vim Plug ...'
    execute '!curl
          \ --fail
          \ --silent
          \ --location
          \ --create-dirs
          \ --output ' . l:plug_path . '
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  endif
endfunction

function EnsureVimPlugPlugins()
  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
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
  " make editing text files more intuitive
  set wrap
  nmap j gj
  nmap k gk
  nmap 0 g0
  nmap $ g$
endfunction

augroup text_file_enhancements
  autocmd BufEnter *.md,*.txt,*.doc,*.rst call TextMagic()
augroup END


" adaptive theme with extra fine tuning, also fast switching by F5
" XXX this has to be put after ColorSchemeTweaks in order to detect correct bg
" color for the gutter
function! AdaptiveTheme()
  let g:luminance=system('get_luminance')
  if g:luminance ==? 'high'
    call SunnyDays()
  elseif g:luminance ==? 'low'
    call LateNight()
  else
    call InDoor()
  endif
  call airline#switch_theme(g:colors_name)
endfunction

augroup adaptive_theme
  autocmd VimEnter * call AdaptiveTheme()
augroup END

function! OutOfScopeIndication()
  if &buftype !=# ''
    setlocal winhighlight=
    return
  endif

  let g:project_root = get(g:, 'project_root', FindRootDirectory())
  let l:path = resolve(expand('%:p'))

  if stridx(l:path, g:project_root) == 0
    setlocal winhighlight=
    return
  endif

  " FIXME
  " There is a bug in stable release of neovim that causing CursorLine
  " highlight not working as expected, newer versions don't have this issue so
  " not bothered to have workarounds now
  highlight LibraryFile     guibg=#322818
  highlight LfHighlight     guibg=#282412
  highlight NonProjectFile  guibg=#122436
  highlight NpHighlight     guibg=#082032

  if stridx(l:path, 'lib/python') >= 0
    setlocal winhighlight=Normal:LibraryFile,SignColumn:LibraryFile,CursorLine:LfHighlight
    setlocal readonly
  else
    setlocal winhighlight=Normal:NonProjectFile,SignColumn:NonProjectFile,CursorLine:NpHighlight
  endif
endfunction

augroup magic
  autocmd BufEnter * call OutOfScopeIndication()
augroup END
