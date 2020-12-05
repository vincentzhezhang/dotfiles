"
" https://github.com/christoomey/vim-tmux-navigator
"

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>
" FIXME add previous key binding for tmux
nnoremap <silent> <A-.> :TmuxNavigatePrevious<CR>
