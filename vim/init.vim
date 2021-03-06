" ======    GENERAL CONFIGURATIONS  ==========
" https://neovim.io/doc/user/options.html
" set nocompatible            " always set in neovim
" set autoread                " detect when a file is changed

" these are gruvbox specifics
if (has("termguicolors"))
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
"
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

" set synmaxcol=200
syntax sync minlines=50

set number                  " show line numbers
set relativenumber          " show relative line numbers
" set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮,eol:¬,space:␣
" set listchars=tab:→\ ,nbsp:␣,trail:•,eol:¬,precedes:«,extends:»
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

" Copy settings
set clipboard=unnamed

" General perfomance Improvment
set lazyredraw              " don't redraw while executing macros
" set magic                  " this is enabled by default on neovim
" set regexpengine=1
" set ruler                 "on by default
" set re=1

set laststatus=2            " show the satus line all the time
set so=7                    " set 7 lines to the cursors - when moving vertical
set wildmenu                " enhanced command line completion
set hidden                  " current buffer can be put into background
set showcmd                 " show incomplete commands
" set wildmode=list:longest   " complete files like a shell
set shell=$SHELL
" set nocursorcolumn
" set cursorline

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

source ~/.dotfiles/vim/nvimrc.bundler

let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='medium' " soft medium hard
set background=dark

" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme

try
  " colorscheme badwolf
  " colorscheme carbonized
  " colorscheme gruvbox
  " colorscheme nord
  " colorscheme base16-tomorrow-night
  " colorscheme base16-atelier-forest-light " daily theme
  " colorscheme base16-solarized-light " daily theme
  " colorscheme base16-gruvbox-dark-hard " afternoon theme
  " colorscheme base16-gruvbox-lighj-hard " afternoon theme
  " colorscheme apprentice
  " colorscheme base16-materia
  " colorscheme spacemacs-theme
  " colorscheme ayu
  " colorscheme base16-eighties
  colorscheme base16-oceanicnext
catch /^Vim\%((\a\+)\)\=:E185/
endtry

" load plugin settings
for fpath in split(globpath('~/.dotfiles/vim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor

"========== Others ===============
source ~/.dotfiles/vim/filetype.vim
source ~/.dotfiles/vim/keymap.vim
