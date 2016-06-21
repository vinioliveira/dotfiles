set nocompatible               " be iMproved

syntax on

if filereadable(expand("~/.dotfiles/vim/vimrc.bundler"))
  source ~/.dotfiles/vim/vimrc.bundler
endif

" ================ Basic Settings  =================
let mapleader = ','
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
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
"
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nocp
" set synmaxcol=100


" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮,eol:¬

" Make it more obvious which paren I'm on
hi MatchParen cterm=none ctermbg=black ctermfg=yellow

" Without this, vim breaks in the middle of words when wrapping
autocmd FileType markdown setlocal nolist wrap lbr

" Wrap the quickfix window
autocmd FileType qf setlocal wrap linebreak

" Make it more obviouser when lines are too long
highlight ColorColumn ctermbg=235
set colorcolumn=80

" set wrap       "wrap lines
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
"

set background=dark
colorscheme base16-eighties

" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
" colorscheme hybrid
" colorscheme distinguished
"

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
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \ 'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? @% : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

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

"========== Remaping Record Key ================
noremap <Leader>q q
noremap q <Nop>

au BufWrite * :call DeleteTrailingWS()

"=============== RSpec  =======================
"
let g:rspec_command = "Dispatch bundle exec rspec --color --drb {spec}"

"=============== VimFiler =====================

let g:vimfiler_as_default_explorer= 1
let g:vimfiler_define_wrapper_commands= 1

"============== CTAGS ========================
" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
nnoremap <silent> <leader>f <C-]>

" Note that remapping C-s requires flow control to be disabled
" (e.g. in .bashrc or .zshrc)
"

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
map <C-s> <esc>:w<CR><esc>
imap <C-s> <esc>:w<CR><esc>

"========== VimFiler Map ===============
map <leader>d <esc>:VimFiler <C-R>=getcwd()<CR><esc>
imap <leader>d <esc>:VimFiler <C-R>=getcwd()<CR><esc>

" NERDTree view style
map <leader>n <esc>:VimFilerBufferDir -explorer<CR>
imap <leader>n <esc>:VimFilerBufferDir -explorer<CR>

"Open in the current directory
map <Leader>e :VimFiler <C-R>=escape(expand("%:p:h")," ")<CR><esc>
imap <Leader>e :VimFiler <C-R>=escape(expand("%:p:h"),' ')<CR><esc>

"Adding es6 syntaxe
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" use ,F to jump to tag in a vertical split
nnoremap <silent> <leader>F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" Rubocop
"
let g:vimrubocop_config = getcwd() + '/.rubocop.yml'

source ~/.dotfiles/vim/alias
source ~/.dotfiles/vim/keymap.vim

