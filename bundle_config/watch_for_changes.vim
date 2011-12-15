" Calls the WatchForChanges plugin to run as soon as vim starts
" useful for coding with Git as your SCM, as git's branches 
" are changed in situ
autocmd VimEnter * WatchForChanges
