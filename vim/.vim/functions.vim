"
" Here contains all the helper functions for vim
"

"
" Vim Plug callback functions
"
" Note: info is a dictionary with 3 fields
" - name:   name of the plugin
" - status: 'installed', 'updated', or 'unchanged'
" - force:  set on PlugInstall! or PlugUpdate!
function! BuildYCM(...)
  if a:0 < 1 || a:info.status ==? 'installed' || a:info.status ==? 'updated' || a:info.force
    !./install.py --clang-completer --tern-completer
  endif
endfunction

function! InstallRubySupport(...)
  if a:0 < 1 || a:info.status ==? 'installed' || a:info.force
    !gem install neovim
  endif
endfunction

function! InstallPythonSupport(...)
  if a:0 < 1 || a:info.status ==? 'installed' || a:info.force
    !pip  install --upgrade --user neovim
    !pip2 install --upgrade --user neovim
    !pip3 install --upgrade --user neovim
  endif
endfunction

"
" quick switch between color schemes
"
function LightSide()
  colorscheme solarized8_light
  let g:airline_theme='solarized'
  set background=light
endfunction

function DarkSide()
  colorscheme gruvbox
  let g:airline_theme='zenburn'
  let g:gruvbox_contrast_dark='soft'
  let g:gruvbox_contrast_light='hard'
  set background=dark
endfunction

function SwitchSide()
  let bg = &background
  if bg ==? 'dark'
    call LightSide()
  elseif bg ==? 'light'
    call DarkSide()
  else
    " ignored
  end
endfunction

map <F5> :call SwitchSide()<CR>

"
" Other handy helpers
"
function! ToggleSyntax()
  if exists('g:syntax_on')
    syntax off
  else
    syntax enable
  endif
endfunction
nmap <silent> <C-F12> :call ToggleSyntax()<CR>
