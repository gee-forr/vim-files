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

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$\|tmp"'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
else
  " Fall back to using git ls-files if Ag is not available
  let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

" Idea from : http://www.charlietanksley.net/blog/blog/2011/10/18/vim-navigation-with-lustyexplorer-and-lustyjuggler/
" Open CtrlP starting from a particular path, making it much
" more likely to find the correct thing first. mnemonic 'jump to [something]'
map <Leader>jm :CtrlP app/models<CR>
map <Leader>jc :CtrlP app/controllers<CR>
map <Leader>jv :CtrlP app/views<CR>
map <Leader>js :CtrlP spec<CR>
map <Leader>jd :CtrlP db<CR>
map <Leader>jC :CtrlP config<CR>
