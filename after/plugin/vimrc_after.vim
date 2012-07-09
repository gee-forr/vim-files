" This loads after vimrc. Use to override certain settings.

if filereadable(expand("~/.vim/vimrc.after"))
  source ~/.vim/vimrc.after
endif
