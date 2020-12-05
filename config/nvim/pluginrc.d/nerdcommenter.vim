"
" https://github.com/scrooloose/nerdcommenter
"

let g:NERDCommentEmptyLines = 1
let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1
nnoremap <C-_> :call NERDComment('n', 'toggle')<CR>
xnoremap <C-_> :call NERDComment('x', 'toggle')<CR>
