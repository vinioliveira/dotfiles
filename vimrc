set nocompatible               " be iMproved

syntax on
filetype off                   " required by vundle

set rtp+=~/.dotfiles/vim/vundle
call vundle#begin()
source ~/.dotfiles/vim/vundles
call vundle#end()


" ================ Basic Settings  =================
let mapleader = ','
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set hidden

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nocp

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮,eol:¬

set nowrap       "wrap lines
set linebreak    "Wrap lines at convenient points
set list

filetype plugin indent on

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital"

" Disable the macvim toolbar
set guioptions-=T)

"============== THEME  ===========================
colorscheme badwolf

""============== IGNORE ctrlP  ======================
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|bower_components|node_modules|dist|build|vendor/bundle)$',
   \ 'file': '\v\.(exe|so|dll)$'
   \ }

set clipboard=unnamed           "To copy to clipboard

"============== LIGHT LINE ===========================
set laststatus=2
"
let g:lightline = {
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" ============ Surround Vim Shortcuts ==============
vmap ' S'
vmap " S"

"============= Vim-Tags ==========================
let g:vim_tags_auto_generate = 1

" ============ Vim Identent Line =================
let g:indentLine_enabled = 1

"=========== RSpec VIm ==========================
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" " Delete trailing white space when saving
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

au BufWrite * :call DeleteTrailingWS()

"=============== VimFiler =====================

let g:vimfiler_as_default_explorer= 1
let g:vimfiler_define_wrapper_commands= 1

"============== CTAGS ========================
" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
nnoremap <silent> <leader>f <C-]>

" use ,F to jump to tag in a vertical split
nnoremap <silent> <leader>F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

source ~/.dotfiles/vim/alias
source ~/.dotfiles/vim/keymap.vim
