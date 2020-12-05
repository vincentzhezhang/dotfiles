"
" https://github.com/norcalli/nvim-colorizer.lua
"

" see: https://github.com/norcalli/nvim-colorizer.lua#customization
function! LuaColorizer()
lua << EOF
require 'colorizer'.setup({
  'css';
  'scss';
  'sass';
  'html';
  'javascript';
  'typescript';
})
EOF
endfunction

call LuaColorizer()
