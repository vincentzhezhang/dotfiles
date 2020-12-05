"
" https://github.com/Valloric/YouCompleteMe
"

" TODO
" - try ncm2 as an alternative to YCM
" - try coc.vim as an alternative to YCM

" The YCM Python path settings with virtual environment is based on the YCM
" official doc with my own virtual path hacks, so that it will automatically
" load the correct virtual environment by the current file or working
" directory path
"
" https://github.com/ycm-core/YouCompleteMe#configuring-through-vim-options
let g:ycm_python_interpreter_path = g:py_virtual_env_dir . '/bin/python'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]

" typescript setup for YCM
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:ycm_max_num_candidates = 18

let g:ycm_error_symbol = g:linter_sign
let g:ycm_warning_symbol = g:linter_sign

if executable(g:py3_path)
  let g:python3_host_prog = g:py3_path
  let g:ycm_server_python_interpreter = g:py3_path
endif

function! s:ColorSchemeTweaks()
  highlight YcmErrorSign          guifg=#FB4934 guibg=NONE
  highlight YcmWarningSign        guifg=#FABD2F guibg=NONE
endfunction

autocmd ColorScheme * call s:ColorSchemeTweaks()

" jump to first match
nnoremap <C-]> :YcmCompleter GoTo<CR>

" FIXME
" - this only works with Python (hopefully), will need a proper implementation
" let g:ycm_collect_identifiers_from_tags_files = 1
" map <F10> :!ctags -R -f ./tags `python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`<CR>
