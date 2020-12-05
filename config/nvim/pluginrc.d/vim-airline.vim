"
" https://github.com/vim-airline/vim-airline
"
" TODO replace with https://github.com/itchyny/lightline.vim

" call airline#parts#define_accent('file', 'bold')

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'P'
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : '',
    \ 'i'  : '',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : '',
    \ 'V'  : '',
    \ '' : '',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ 't'  : 'T',
    \ }
let g:airline#extensions#vista#enabled = 1
let g:airline#extensions#branch#enabled        = 0
let g:airline#extensions#tabline#enabled       = 0
let g:airline#extensions#tabline#tab_nr_type   = 2
let g:airline#extensions#whitespace#enabled    = 0
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
let g:airline_detect_spell                     = 0
let g:airline_inactive_collapse                = 1
let g:airline_left_alt_sep                     = ''
let g:airline_left_sep                         = ''
let g:airline_powerline_fonts                  = 0
let g:airline_right_alt_sep                    = ''
let g:airline_right_sep                        = ''
let g:airline_section_a                        = split(expand(g:py_virtual_env_dir), '/')[-1] " (mode, crypt, paste, spell, iminsert)
let g:airline_section_b                        = '' " (hunks, branch)[*]
" FIXME looks like there is a bug on virtualenv
" let g:airline_section_c                        = '' " (bufferline or filename, readonly)
" let g:airline_section_c                        = airline#section#create(["%{NearestMethodOrFunction()}"])
" let g:airline_section_gutter                   = ' ' (csv)
let g:airline_section_x                        = '' " (tagbar, filetype, virtualenv)
let g:airline_section_y                        = '' " (fileencoding, fileformat)
let g:airline_section_z                        = airline#section#create(["%{col('.')}:%{line('.')}"]) " (percentage, line number, column number)
" let g:airline_section_error                  = '' (ycm_error_count, syntastic-err, eclim, languageclient_error_count)
" let g:airline_section_warning                = '' (ycm_warning_count, syntastic-warn, languageclient_warning_count, whitespace)
let g:airline_symbols_ascii                    = 1
