call pathogen#infect()

set nocompatible                " choose no compatibility with legacy vi
syntax enable
set encoding=utf-8
set showcmd                     " display incomplete commands
set laststatus=2
set scrolloff=7                 " Never scroll to the edge of the window
set history=50                  " Keep the last 50 commands
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

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Editor window dressing
set t_Co=256                    " 256 colours
set cursorline                  " Highlight current line
set ruler                       " Show a ruler
set number                      " Show line numbers
set showmatch                   " Show matching brackets

function! CurDir()
  let curdir = substitute(getcwd(), '/home/gabrielf/', "~/", "g")
  return curdir
endfunction
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

"" Tab shortcuts
map <leader>tn :tabnew %<cr>    " New
map <leader>tc :tabclose<cr>    " Close
map <leader>tm :tabmove         " Move
map <leader>te :tabe            " Edit/Open existing
map <leader><right> :tabn<cr>   " Select tab to the right
map <leader><left> :tabp<cr>    " Select tab to the left

"" Load up bundle specfic configuration
""  -- doesn't clutter up the rest of the vimrc this way.
runtime! bundle_config/*.vim
