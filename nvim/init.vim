" autocmd!

set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

set mouse=a

set title
set inccommand=split

set synmaxcol=200
" syntax sync minlines=50
"
set number                  " show line numbers
set relativenumber          " show relative line numbers
set list " Useful to see the difference between tabs and spaces and for trailing blanks
set listchars=tab:→\ ,nbsp:␣,trail:•,eol:↴,precedes:«,extends:»
" set guicursor=
set backspace=indent,eol,start

" TAB Control Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" code folding settings
" set foldmethod=manual
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default
filetype plugin indent on
set formatoptions+=r
set smartindent
set conceallevel=0
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
let loaded_matchparen = 1
let mapleader=" "

runtime ./nvimrc.bundler
lua << EOF
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
EOF

" load plugin settings
for fpath in split(globpath('~/.config/nvim/settings', '*.vim'), '\n')
  exe 'source' fpath
endfor
syntax enable

"========== Others ===============
" source ~/.dotfiles/vim/filetype.vim
runtime ./keymap.vim

let g:gruvbox_contrast_dark='medium'
let g:gruvbox_invert_selection=0
let g:gruvbox_improved_strings=0
let g:gruvbox_bold=0

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >

" let g:everforest_background = 'medium'
" " For better performance
" let g:everforest_better_performance = 1
let g:nord_contrast = v:true
let g:nord_borders = v:true
" let g:nord_disable_background = v:false
let g:nord_italic = v:false

set termguicolors
set wildoptions=pum
set background=dark
let $BAT_THEME="gruvbox"
colorscheme  nord

