" Fancy glyphs
let g:Powerline_symbols = 'fancy'
" Use this setting instead of 'fancy' for non-patched fonts.
"let g:Powerline_symbols = 'compatible' 

" Short file names.
let g:Powerline_stl_path_style = "short"

" Remove crazy delay when switching between modes
" Taken from https://gist.github.com/brendonrapp/5944296
augroup FastEscape
  autocmd!
  au InsertEnter * set timeoutlen=0
  au InsertLeave * set timeoutlen=1000
augroup END
