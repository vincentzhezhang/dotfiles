"
" https://github.com/Xuyuanp/nerdtree-git-plugin
"

" TODO
" - find better icons, the previous one looks too bulky and not consistent, thus replaced by ascii characters
" - checkout defx.nvim as an alternative to nerdtree
"
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  : '*',
    \ 'Staged'    : '+',
    \ 'Untracked' : 'u',
    \ 'Renamed'   : '»',
    \ 'Unmerged'  : '≠',
    \ 'Deleted'   : 'x',
    \ 'Dirty'     : '*',
    \ 'Clean'     : '✓',
    \ 'Ignored'   : '_',
    \ 'Unknown'   : '?'
    \ }
