let g:neomake_error_sign = {
      \ 'text': 'E▶',
      \ 'texthl': 'ErrorMsg',
      \ }

let g:neomake_warning_sign = {
      \ 'text': 'W▶',
      \ 'texthl': 'WarnMsg',
      \ }

autocmd! BufWritePost * Neomake

 "Syntax
"let g:syntastic_enable_signs=1
"let g:syntastic_error_symbol="E▶"
"let g:syntastic_style_error_symbol="E▷"
"let g:syntastic_warning_symbol="W▶"
"let g:syntastic_style_warning_symbol="W▷"
 "these work better with molokai
"highlight! link SyntasticWarningSign Comment
"highlight! link SyntasticErrorSign Statement
"highlight! link SignColumn String
