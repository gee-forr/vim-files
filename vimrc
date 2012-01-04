call pathogen#infect()

set nocompatible                " choose no compatibility with legacy vi
set nobackup                    " Do not keep a backup file
set encoding=utf-8
set showcmd                     " display incomplete commands
set laststatus=2
set scrolloff=7                 " Never scroll to the edge of the window
set history=50                  " Keep the last 50 commands
syntax enable
filetype plugin indent on       " load file type plugins + indentation

"" Folding
"set nofoldenable
"set fdl=0
"set foldmethod=indent

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set shiftround                  " Always indent/outdent to nearest tabstop
set backspace=indent,eol,start  " backspace through everything in insert mode
set pastetoggle=<leader>pt      " "Set  to toggle paste on and off.

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set wildmenu

"" Editor window dressing
set t_Co=256                    " 256 colours
set cursorline                  " Highlight current line
set ruler                       " Show a ruler
set number                      " Show line numbers
set showmatch                   " Show matching brackets
set guifont=Inconsolata:h18     "Set the font to Inconsolata at 18pt. (Yes, it's huge)
set bg=dark                     " Dark background
"set bg=light                    " Light background
colorscheme solarized

function! CurDir()
  let curdir = substitute(getcwd(), '/home/gabrielf/', "~/", "g")
  return curdir
endfunction
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ %{fugitive#statusline()}\ \ \ Line:\ %l/%L:%c

"" Tab shortcuts
map <leader>tn :tabnew %<cr>    " New
map <leader>tc :tabclose<cr>    " Close
map <leader>tm :tabmove
map <leader>te :tabe
map <leader><right> :tabn<cr>   " Select tab to the right
map <leader><left> :tabp<cr>    " Select tab to the left

" Be clever about pasting from somewhere into the terminal
" This detects a paste from the pasteboard and will temporarily
" set pastetoggle
" Doesn't work with things like tmux and screen
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
    cmap <Esc>[200~ <nop>
    cmap <Esc>[201~ <nop>
endif

" Make vim jump to the last known line
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"" Load up bundle specfic configuration
""  -- doesn't clutter up the rest of the vimrc this way.
runtime! bundle_config/*.vim
