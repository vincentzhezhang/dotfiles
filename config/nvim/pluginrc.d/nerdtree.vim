"
" https://github.com/scrooloose/nerdtree
"

let g:NERDTreeMinimalUI = 1
let g:NERDTreeStatusline = '%#NonText#'
let g:NERDTreeWinSize = 30

" color filename as well by file type in NERDTree
let g:NERDTreeFileExtensionHighlightFullName = 1

" NERDTree
map <C-\> :NERDTreeFind <Bar> wincmd =<CR>
