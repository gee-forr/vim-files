set nocompatible                " choose no compatibility with legacy vi
filetype off                    " Set this off whilst we do our Vundle thing

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle' 

" --- Motion utilities
Bundle "vim-scripts/matchit.zip"            
Bundle "haya14busa/incsearch.vim"
Bundle "easymotion/vim-easymotion"            
Bundle "haya14busa/incsearch-easymotion.vim"
Bundle "kien/ctrlp.vim"                     
Bundle "terryma/vim-expand-region"

" --- Interface tweaks
"Bundle "mhinz/vim-startify"
Bundle "sjl/vitality.vim"
Bundle "bling/vim-airline"
Bundle 'edkolev/tmuxline.vim'

" --- Colour schemes
Bundle "altercation/vim-colors-solarized"
Bundle 'morhetz/gruvbox'
"Bundle "junegunn/seoul256.vim"
"Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
"Bundle 'jgdavey/vim-railscasts'
"Bundle 'tomasr/molokai'
"Bundle 'sjl/badwolf'
"Bundle 'nanotech/jellybeans.vim'
"Bundle 'itchyny/lightline.vim'

" Watch for file updates
Bundle 'gee-forr/vim-watch_for_changes'

" --- Ruby utils
Bundle "vim-scripts/ruby-matchit"
Bundle "vim-ruby/vim-ruby"
Bundle "tpope/vim-rails"
Bundle "tpope/vim-endwise"

" --- JS plugins
Bundle "kchmck/vim-coffee-script"
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Bundle 'heartsentwined/vim-emblem'
Bundle 'mustache/vim-mustache-handlebars'

" --- General dev utils
Bundle 'gee-forr/vim-slurper'
Bundle 'EinfachToll/DidYouMean'
Bundle 'dietsche/vim-lastplace'
Bundle "airblade/vim-gitgutter"             
Bundle "scrooloose/syntastic"               
Bundle "tpope/vim-fugitive"                 
Bundle "ervandew/supertab"                  
Bundle "godlygeek/tabular"                  
Bundle "majutsushi/tagbar"                  
Bundle "tpope/vim-surround"                 
Bundle "scrooloose/nerdtree"                
Bundle "jistr/vim-nerdtree-tabs"
Bundle "scrooloose/nerdcommenter"           
Bundle "mileszs/ack.vim"                    
Bundle "kana/vim-smartinput"                
Bundle "Yggdroot/indentLine"
"Bundle 'kien/rainbow_parentheses.vim'       " Colour parens depending on nesting
Bundle 'closetag.vim'

" Ansible plugins
Bundle "Glench/Vim-Jinja2-Syntax"
Bundle "chase/vim-ansible-yaml"

" Snippet management
"Bundle "MarcWeber/vim-addon-mw-utils"
"Bundle "tomtom/tlib_vim"
"Bundle "garbas/vim-snipmate"              

au BufWritePost .vimrc so ~/.vimrc " automatically reload vimrc when it's saved

"" Some general editor stuff
"set clipboard=unnamed           " send yanks to the OS clipboard
set mouse=a
set nobackup                    " Do not keep a backup file
set encoding=utf-8
set showcmd                     " display incomplete commands
set scrolloff=7                 " Never scroll to the edge of the window
set history=50                  " Keep the last 50 commands
set t_ti= t_te=                 " Do not clear the screen when exiting vim, and preserve the window
au FocusLost * :silent! wall    " Autosave on losing focus (works in iTerms2 and tmux using VITality plugin)
syntax enable
filetype plugin indent on       " load file type plugins + indentation

" Leader stuff
let mapleader = "\<Space>"
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nmap <Leader><Leader> V

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

"" Folding
set nofoldenable
set foldmethod=indent
set foldlevelstart=20

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
set gdefault                    " Make global search and replace the default (use /g to make it singular)
set wildmenu
set wildignore+=*/.hg/*,*/.svn/*,*.swp,*.swo

set bg=dark                     " Dark background
colorscheme gruvbox

set t_Co=256                    " 256 colours
set cursorline                  " Highlight current line
set ruler                       " Show a ruler
set relativenumber              " Show lines numbers relative to where you are
au InsertEnter * :set nu        " absolute line numbers in insert mode,
au InsertLeave * :set rnu       " relative otherwise for easy movement
set showmatch                   " Show matching brackets
set guifont=Inconsolata:h18     "Set the font to Inconsolata at 18pt. (Yes, it's huge)
"set bg=light                    " Light background
set listchars=tab:▸\ ,eol:¬,trail:⋅,extends:❯,precedes:❮ " Make the list chars less hideous (and more like textmate)
set showbreak=↪

function! CurDir()
  let curdir = substitute(getcwd(), '/home/gabrielf/', "~/", "g")
  return curdir
endfunction
set laststatus=2                " Show statusline on second last line
set statusline=\ [%F%m%r%h\ %w]\ \ \ [CWD:%r%{CurDir()}%h]\ \ \ [Type=%Y]\ \ \ %{fugitive#statusline()}\ \ \ [Line:%l/%L:%c\ %p%%]\ 

"" Tab shortcuts
map <leader>tn :tabnew 
map <leader>tm :tabmove 
map <leader>te :tabe 
map <leader>tc :tabclose<cr>    " Close
map <leader><right> :tabn<cr>   " Select tab to the right
map <leader><left> :tabp<cr>    " Select tab to the left
map <leader>k :tabn<cr>         " Select tab to the right using k
map <leader>j :tabp<cr>         " Select tab to the left using j

"" Split window shortcuts
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

"" Make vim jump to the last known line
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"" Fix silly typos to DWIM, not DWIS
"cmap W w
cmap Q q

"" Load up bundle specfic configuration
""  -- doesn't clutter up the rest of the vimrc this way.
runtime! bundle_config/*.vim

" Speed up start times when dealing with Ruby files
" For rbenv
let g:ruby_path = system('echo $HOME/.rbenv/shims')
" For rvm
"let g:ruby_path = system('rvm current')

" Abbreviations
iabbrev trye true
