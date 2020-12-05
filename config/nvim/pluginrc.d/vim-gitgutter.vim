"
" https://github.com/airblade/vim-gitgutter
"
let g:gitgutter_map_keys = 0 " no need of mapping, visual clue only
let g:gitgutter_sign_added = g:git_sign
let g:gitgutter_sign_modified = g:git_sign
let g:gitgutter_sign_modified_removed = g:git_sign
let g:gitgutter_sign_removed = '‣ '
let g:gitgutter_sign_removed_first_line = '‣ '

nnoremap <A-}> :GitGutterNextHunk<CR>zz
nnoremap <A-{> :GitGutterPrevHunk<CR>zz

function s:ColorSchemeTweaks()
  highlight GitGutterAdd          guifg=#98C379 guibg=NONE ctermbg=NONE
  highlight GitGutterChange       guifg=#FABD2F guibg=NONE ctermbg=NONE
  " a changed line followed by at least one removed line
  highlight GitGutterChangeDelete guifg=#2C323B guibg=NONE ctermbg=NONE
  highlight GitGutterDelete       guifg=#FB4934 guibg=NONE ctermbg=NONE
endfunction

autocmd ColorScheme * call s:ColorSchemeTweaks()
