let g:ctrlp_map                 = '<c-p>' " Open CTRL P with ctrl+p
let g:ctrlp_open_new_file       = 1       " Open new, empty files in a tab
let g:ctrlp_open_multi          = '1t'    " When marking multiple files, open each of them up in their own tabs
let g:ctrlp_max_height          = 25      " Max height of window
let g:ctrlp_switch_buffer       = 2
let g:ctrlp_clear_cache_on_exit = 1       " Delete cache of files on exit
let g:ctrlp_mruf_max            = 250     " Remember this many recently used files
let g:ctrlp_root_markers        = ['Gemfile']

" Ignore git, hg and svn dirs and vim swap files
let g:ctrlp_custom_ignore = {
    \ 'dir': 'bundler_stubs\|tmp\|\.git$\|\.hg$\|\.svn$\|node_modules\|bower_components',
    \ 'file': '\.exe$\|\.so$\|\.dll$',
    \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }
