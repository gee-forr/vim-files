let g:ctrlp_map           = '<c-p>' " Open CTRL P with ctrl+p
let g:ctrlp_open_new_file = 1       " Open new, empty files in a tab
let g:ctrlp_open_multi    = '1t'    " When marking multiple files, open each of them up in their own tabs
let g:ctrlp_max_height    = 25      " Max height of window

" Ignore git, hg and svn dirs and vim swap files
set wildignore+=*/.hg/*,*/.svn/*,*.swp,*.swo
