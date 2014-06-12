"inoremap <silent> = =<Esc>:call <SID>ealign()<CR>a
"function! s:ealign()
"  let p = '^.*=.*$'
"  if exists(':Tabularize') && getline('.') =~# '^.*=' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"    let column = strlen(substitute(getline('.')[0:col('.')],'[^=]','','g'))
"    let position = strlen(matchstr(getline('.')[0:col('.')],'.*=\s*\zs.*'))
"    Tabularize/=/l1
"    normal! 0
"    call search(repeat('[^=]*=',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"  endif
"endfunction

map <leader>= :Tabularize /=<cr> " Map leader= to auto-align assigment blocks
map <leader>: :Tabularize /:\zs/l0r1<cr>
