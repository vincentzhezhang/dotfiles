"
" https://github.com/junegunn/fzf
"

" FIXME
" - this needs clean up
" TODO
" - compare preview feature with fzf ag preview: https://github.com/junegunn/fzf.vim/blob/master/README.md#advanced-customization

" Prefer Homebrew managed fzf
if isdirectory(glob("$HOMEBREW_PREFIX"))
  exec 'set runtimepath+=' . "$HOMEBREW_PREFIX/opt/fzf"
endif

" TODO
" - FZF_DEFAULT_OPTS should follow vim colorscheme
let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse --margin=1,4'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let g:fzf_buffers_jump = 1
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

" FZF with floating window
function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let max_height = 120
  let dynamic_height = &lines * 2 / 3
  let height = min([dynamic_height, max_height])

  let max_width = 180
  let dynamic_width = &columns * 2 / 3
  let width = min([dynamic_width, max_width])

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
" FIXME decouple with vim-rooter
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

" fzf#ag#vim with preview
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:70%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" find word under cursor
nnoremap <silent> <leader>rg :Rg <C-R><C-W><CR>
" find whitespace delimited segments
nnoremap <silent> <leader>RG :Rg <C-R><C-A><CR>
" find selection
xnoremap <silent> <leader>rw y:Ag <C-R>"<CR>

nnoremap <silent> <leader>f :call SmartFindFiles()<CR>
nnoremap <silent> <leader>B :Buffers<CR>
" fast switch with previous buffer
nnoremap <silent> <leader>b :b#<CR>
nnoremap <silent> <leader>L :Lines<CR>
