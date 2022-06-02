" autocmd!

set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

set title
set inccommand=split

set synmaxcol=200
" syntax sync minlines=50
"
set number                  " show line numbers
set relativenumber          " show relative line numbers
set listchars=tab:→\ ,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
set list " Useful to see the difference between tabs and spaces and for trailing blanks
" set guicursor=
set backspace=indent,eol,start

" TAB Control Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" code folding settings
set foldmethod=indent       " fold based on indent
" set foldmethod=manual
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default
filetype plugin indent on
set formatoptions+=r
set smartindent

" Copy settings
set clipboard=unnamed

" General perfomance Improvment
set lazyredraw              " don't redraw while executing macros
" set magic                  " this is enabled by default on neovim
" set regexpengine=1
" set ruler                 "on by default
" set re=1

set laststatus=2            " show the satus line all the time
set so=10                    " set 7 lines to the cursors - when moving vertical
set wildmenu                " enhanced command line completion
set hidden                  " current buffer can be put into background
set showcmd                 " show incomplete commands
" set wildmode=list:longest   " complete files like a shell
" set shell=$SHELL
" set nocursorcolumn
set cursorline

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set hlsearch                " highlight search results
set showmatch               " show matching braces
set mat=2                   " how many tenths of a second to blink

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   execute "normal! g`\"" |
      \ endif

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

"========== Delete trailing white space when saving ================
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

au BufWrite * :call DeleteTrailingWS()

let mapleader = ','

runtime ./nvimrc.bundler


" load plugin settings
for fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
syntax enable

"========== Others ===============
" source ~/.dotfiles/vim/filetype.vim
runtime ./keymap.vim

set termguicolors
set wildoptions=pum
set background=dark
let $BAT_THEME="gruvbox"
colorscheme gruvbox

