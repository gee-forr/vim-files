call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible
set nobackup            " do not keep a backup file, use versions instead
set history=50          " keep 50 lines of command line history
set showcmd             " display incomplete commands
set laststatus=2
set nowrap

syntax enable

"Highlight current
set cursorline

"Fast reloading of the .vimrc
map <leader>v :source ~/.vimrc<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the cursors - when moving vertical..
set scrolloff=7

"Turn on WiLd menu
set wildmenu

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set number
highlight LineNr      term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE 

"Set the font to Inconsolata at 18pt. (Yes, it's huge)
set guifont=Inconsolata:h18

"Do not redraw, when running macros.. lazyredraw
set lazyredraw

"Change buffer - without saving
set hidden

"Set backspace
set backspace=eol,start,indent

"Backspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set matchtime=2

"Highlight search things
set hlsearch

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""

function! CurDir()
    let curdir = substitute(getcwd(), '/home/gabrielf/', "~/", "g")
    return curdir
endfunction

"Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

if &t_Co > 2 || has("gui_running")
   syntax on
endif

if has("autocmd")
    filetype plugin indent on
    filetype on

    autocmd WinEnter,FileType text setlocal    textwidth=78
    "autocmd WinEnter,FileType ruby colorscheme railscasts " Set ruby files to always use this awesome colorscheme
    "autocmd WinEnter,FileType Gemfile colorscheme railscasts " Set ruby files to always use this awesome colorscheme

    autocmd BufReadPost *
       \ if line("'\"") > 0 && line("'\"") <= line("$") |
       \   exe "normal g`\"" |
       \ endif

    autocmd BufNewFile,BufRead *.p? compiler perl

endif " has("autocmd")

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofoldenable
set fdl=0
set foldmethod=indent

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
"Auto indent
set autoindent
"Smart indent
set smartindent
"C-style indenting
set cindent

" Set the contrast type. Is your background dark or light?
set bg=dark
colorscheme solarized

map ' :make<CR>
map , :cnext<CR>
map W :w<CR>:make<CR>

"Set \pt to toggle paste on and off.
set pastetoggle="<leader>pt"

highlight Comment ctermfg=green
highlight Preproc ctermfg=white

" Swap words and swap letters "
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l> 
nmap <silent> gc xph
 
" Tab specific commands "
"--------------------------------------------------
set expandtab    "Convert all tabs typed into spaces"
set tabstop=2    "An indentation level every four columns"
set shiftwidth=2 "Indent/outdent by four columns"
set softtabstop=2
set shiftround   "Always indent/outdent to the nearest tabstop"
try
  set switchbuf=usetab
  set stal=2
catch
endtry
"-------------------------------------------------- 

" SVN stuff
map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>ggzR

" VIM tabs "
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>te :tabe 
map <leader><right> :tabn<cr>
map <leader><left> :tabp<cr>

" Fish hack - fish isnt POSIX compliant...
if $SHELL =~ 'bin/fish'
    set shell=/bin/bash
endif

" Taglist config
map <TAB> :Tlist<CR>
map <leader><TAB> :Tlist<CR>
" Point this to your ctags directory
let Tlist_Ctags_Cmd               = '/opt/local/bin/ctags'
let Tlist_Display_Prototype       = 1
let Tlist_Auto_Update             = 1
let Tlist_Close_On_Select         = 1
let Tlist_Exit_OnlyWindow         = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Show_One_File           = 1
let Tlist_Use_Right_Window        = 1

" NERDTree config
map <leader><TAB> :NERDTreeToggle<CR>
let NERDTreeIgnore     = ['blib$', '_build$']
let NERDTreeQuitOnOpen = 1

set t_Co=256

" Highligh Matching Brackets
let g:HiMtchBrktOn = 1

" Load up dbext config
source $HOME/.vim/dbext.vim

" Calls the WatchForChanges plugin to run as soon as vim starts
" useful for coding with Git as your SCM, as git's branches 
" are changed in situ
autocmd VimEnter * WatchForChanges

" Be clever about pasting from somewhere into the terminal
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

" NerdTree config
let NERDSpaceDelims = 1
let NERDDefaultNesting = 0

"for Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_auto_jump=2

set enc=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc
