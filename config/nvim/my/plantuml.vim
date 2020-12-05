" PlantUML enchancements
"
" FIXME
" - the behaviour of external picture viewer is not deterministic
" - find a better platform independent solution
" - when this plugin is used remotely, maybe we should print URL instead of
"   open it
"
" dependencies:
" - plantuml/plantuml-server: docker image for set up the server
"   docker run -d -p 8080:8080 plantuml/plantuml-server
" - node-plantuml: for encode the uml file
"   npm i -g node-plantuml
"
" the prototype will try to encode the uml file upon save, and communicate
" with the server, then open a viewer if it's not opened yet
" TODO
" - [ ] need to make this asynchronous, checkout jobstart
"
function! RenderPlantUML()
  echo 'generating PlantUML diagram...'
  let l:file_path = expand('%:p')
  let l:file_dir = expand('%:p:h')
  let l:png_name = expand('%:r') . '.png'
  let l:png_path = l:file_dir . '/' . l:png_name
  let l:cmd = '!curl -sS "localhost:12345/png/$(puml encode ' . l:file_path . ')" -o ' . expand('%:r') . '.png'
  " let l:cmd = l:cmd . " && (ps x | pgrep -af '". l:png_path . "$' && : || xdg-open " . l:png_path . ' &)'
  silent execute l:cmd
  redraw " FIXME any better way to deal with the messages?
  echo 'generated!'
endfunction

augroup plantuml_enchancements
  " maybe support tags grepping
  autocmd! BufWritePost *.*uml call RenderPlantUML()
augroup END
