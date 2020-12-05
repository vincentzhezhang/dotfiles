"
" https://github.com/liuchengxu/vista.vim
"
" Better alternative to TagBar.
" TODO
" - more Vista tweaks

" function! NearestMethodOrFunction() abort
"   return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
"
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Vista Toggle (better alternative of TagBar)
" FIXME why wincmd not working here
nnoremap <silent><C-t> :Vista!! <Bar> wincmd =<CR>
nnoremap <silent><leader>t :Vista finder<CR>
" TODO
" - maybe enable this again when find a good font
let g:vista#renderer#enable_icon = 0
let g:vista_sidebar_width = 60
" FIXME consistent styling of floating window
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_keep_fzf_colors = 1
