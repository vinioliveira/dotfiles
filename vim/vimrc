source ~/.dotfiles/vim/vimrc.bundler

" ======    GENERAL CONFIGURATIONS  ==========
set nocompatible            " not compatible with vi
set autoread                " detect when a file is changed
" set inccommand=nosplit

if (has('nvim') && has("termguicolors"))
  set termguicolors
  set t_8f=^[[38;2;%lu;%lu;%lum
  set t_8b=^[[48;2;%lu;%lu;%lum
endif

if (!has('nvim'))
  " set Vim-specific sequences for RGB colors
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
end

syntax sync minlines=256
syntax sync maxlines=256

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_contrast_light='normal'
let g:gruvbox_bold=0
set background=dark

try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
endtry

set number                  " show line numbers
set relativenumber          " show relative line numbers
set regexpengine=1
set listchars=tab:▸\ ,trail:•,extends:❯,precedes:❮,eol:¬
set list
set guicursor=

" TAB Control Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" code folding settings
set foldmethod=indent       " fold based on indent
set foldnestmax=10          " deepest fold is 10 levels
set nofoldenable            " don't fold by default

" Copy settings
set clipboard=unnamed

" General perfomance Improvment
set ttyfast                 " faster redrawing
set laststatus=2            " show the satus line all the time
set so=7                    " set 7 lines to the cursors - when moving vertical
set wildmenu                " enhanced command line completion
set hidden                  " current buffer can be put into background
set showcmd                 " show incomplete commands
set wildmode=list:longest   " complete files like a shell
set shell=$SHELL

" Searching
set ignorecase              " case insensitive searching
set smartcase               " case-sensitive if expresson contains a capital letter
set hlsearch                " highlight search results
set lazyredraw              " don't redraw while executing macros
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

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" " ================ Neomake =======================
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:neomake_javascript_enabled_makers = ['eslint']

autocmd! BufWritePost * Neomake
" au BufWritePost * Neomake


"============== FZF  ===========================
let $FZF_DEFAULT_COMMAND= 'ag -s -g ""'
let g:fzf_layout = { 'down': '~30%' }

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags --tag-relative -R --sort=yes --languages=ruby,javascript --exclude=.git --exclude=log . $(bundle list --paths)'

let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

let g:fzf_prefer_tmux = 1

"============== LIGHT LINE ===========================
set laststatus=2
let g:lightline = {
      \ 'colorscheme' : 'gruvbox',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive'], ['filename' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \   'fugitive': 'LightLineFugitive',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? branch.' ' : ''
  endif
  return ''
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ '' != expand('%:t') ? @% : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

"=========== VIm - Test ==========================
" let g:dispatch_quickfix_height=15
let test#strategy = "dispatch"

" ============ Vim Indentent Line =================
let g:indentLine_enabled = 1
let g:indentLine_setColors = 0
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2

"========== Delete trailing white space when saving ================
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

au BufWrite * :call DeleteTrailingWS()

"=============== VimFiler =====================
let g:vimfiler_as_default_explorer= 1
let g:vimfiler_define_wrapper_commands= 1
let g:vimfiler_safe_mode_by_default=0

"========== FileTypes Map ===============
" Ruby
" -----------------------------------------------------------------
augroup rubyfiletype
  autocmd BufRead,BufNewFile *.ru setfiletype ruby
  autocmd BufRead,BufNewFile Gemfile setfiletype ruby
augroup END

" tmux
" -----------------------------------------------------------------
augroup tmuxfiletype
  autocmd BufRead,BufNewFile .tmux.conf setfiletype tmux
augroup END

" JavaScript
" -----------------------------------------------------------------
augroup javascriptfiletype
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript.jsx
  autocmd BufRead,BufNewFile *.js.es6 set filetype=javascript.jsx
augroup END

let g:jsx_ext_required = 0

"========== NVIM configuration ===============
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

"========== UltiSnips Map ===============

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"


"========== GitGutter Map ===============
let g:gitgutter_map_keys = 0


"========== Key Map ===============
source ~/.dotfiles/vim/keymap.vim

