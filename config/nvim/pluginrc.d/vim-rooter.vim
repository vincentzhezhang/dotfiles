"
" https://github.com/airblade/vim-rooter
"

" smarter project root by vim-rooter, very useful when combined with fzf below
" TODO
" - the detection can be further improved with updated project structures, need
"   to find a collection of files that can denote a package though
" - decouple with fzf
let g:rooter_patterns = [
  \ 'conda.yaml',
  \ 'meta.yaml',
  \ 'build.sh',
  \ 'package.json',
  \ 'setup.py',
  \ '.git',
  \ '.git/',
  \ ]
let g:rooter_resolve_links = 1
let g:rooter_manual_only = 1
