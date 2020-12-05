"
" https://github.com/dense-analysis/ale
"

" XXX disable ale's virtual env auto discover feature and use the envvar
" instead because I know the environment better
let g:ale_virtualenv_dir_names = []

" let g:ale_sign_error = ' ■' " good on fantasque mono, but why it's so fucking huge in Ubuntu mono?
"
" FIXME still buggy 23 Nov, now check again 2019
" let g:ale_completion_enabled = 1
let g:ale_lint_delay = 666
let g:ale_linters = {'javascript': ['eslint', 'tsserver']}
let g:ale_sign_column_always = 1
let g:ale_sign_error = g:linter_sign
let g:ale_sign_warning = g:linter_sign

" FIXME temporary workaround for neovim ALE issue, see:
" https://github.com/neovim/neovim/issues/9388
let g:ale_sign_offset = 1000

function! s:ColorSchemeTweaks()
  "TODO get color from ALE?
  " let [l:guibg, l:guifg, l:ctermbg, l:ctermfg] = s:get_highlight('SignColumn')

  highlight ALEErrorSign          guifg=#FB4934 guibg=NONE
  highlight ALEWarningSign        guifg=#FABD2F guibg=NONE
endfunction

autocmd ColorScheme * call s:ColorSchemeTweaks()

nnoremap <silent> <A-[> :ALEPreviousWrap <CR> zz
nnoremap <silent> <A-]> :ALENextWrap <CR> zz
