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
function LightSide()
  let g:airline_theme='solarized'
  set background=light
  colorscheme solarized8_light_high
endfunction

function DarkSide()
  let g:gruvbox_italic=1
  let g:airline_theme='zenburn'
  let g:gruvbox_contrast_dark='hard'
  let g:gruvbox_contrast_light='hard'
  set background=dark
  colorscheme gruvbox
endfunction

function ToxicSide()
  set background=dark
  colorscheme chlordane
endfunction

function SwitchSide()
  let l:bg = &background
  if l:bg ==? 'dark'
    call LightSide()
  elseif l:bg ==? 'light'
    call DarkSide()
  else
    " ignored
  end
endfunction

map <F5> :call SwitchSide()<CR>

function! CycleTheme()
  let themes = ['LightSide', 'DarkSide', 'ToxicSide']
  let g:theme_index = get(g:, 'theme_index', -1)
  let g:theme_index = (g:theme_index+1)%len(themes)
  let t = themes[g:theme_index]
  call {t}()
endfun
nmap <silent> <F3> :call CycleTheme() <CR>

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
