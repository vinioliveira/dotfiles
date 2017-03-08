let mapleader = ','

set backspace=2    " Backspace deletes like most programs in insert mode
set history=50
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set laststatus=2   " Always display the status line
set wildmenu       " Enhance command-line completion
set esckeys        " Allow cursor keys in insert mode
set ttyfast        " Optimize for fast terminal connections
set title

" ======    SEARCH  ==========

set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.dotfiles/vim/vimrc.bundler"))
  source ~/.dotfiles/vim/vimrc.bundler
endif

"============== THEME  ===========================
" let base16colorspace=256
set background=dark
let g:hybrid_custom_term_colors = 1
colorscheme gruvbox

filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

set list listchars=tab:»·,trail:·,nbsp:·

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
highlight ColorColumn ctermbg=233
set colorcolumn=80

" Numbers
set number
set gdefault " global Substitute by default
set grepprg=ag " Use Silver Searcher instead of grep
set wmh=0

if exists("&relativenumber")
  set relativenumber
  set lazyredraw
  au BufReadPost * set relativenumber
endif

" " ================ Neomake =======================
" let g:neomake_open_list=2
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
let g:neomake_javascript_eslint_exe = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:neomake_javascript_enabled_makers = ['eslint']
au BufWritePost *.rb :let b:neomake_ruby_rubocop_exe =  system('PATH=$(pwd)/bin:$PATH && which rubocop | tr -d "\n"')
au BufWritePost * Neomake


" Disable the macvim toolbar
set guioptions-=T)

"============== RUBY  ===========================
set regexpengine=2

"============== FZF  ===========================

let $FZF_DEFAULT_COMMAND= 'ag -g ""'

let g:fzf_prefer_tmux = 1
nnoremap <silent> <C-p> :call fzf#run({
\   'down': '40%',
\   'sink': 'e' })<CR>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --languages=ruby --exclude=.git --exclude=log . $(bundle list --paths)'

set clipboard=unnamed           "To copy to clipboard

"============== LIGHT LINE ===========================
set laststatus=2
"
let g:lightline = {
      \ 'colorscheme' : 'PaperColor',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive'], ['filename' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename',
      \   'fugitive': 'LightLineFugitive'
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
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? @% : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" ============ Surround Vim Shortcuts ==============
vmap ' S'
vmap " S"

"============= Vim-Tags ==========================
" let g:vim_tags_auto_generate = 1

" ============ Vim Identent Line =================
let g:indentLine_enabled = 1
" let g:indentLine_setColors = 0
" let g:indentLine_concealcursor = 'inc'
" let g:indentLine_conceallevel = 2

"=========== RSpec VIm ==========================
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>
let test#strategy = "dispatch"
let g:dispatch_quickfix_height=15

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

" use ,F to jump to tag in a vertical split
nnoremap <silent> <leader>F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" Rubocop
"
let g:vimrubocop_config = getcwd() + '/.rubocop.yml'

let g:autotagTagsFile=".tags"
" let g:indentLine_conceallevel = 1
" let g:indentLine_setConceal = 0

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
" augroup javascriptfiletype
"   autocmd BufRead,BufNewFile *.es6 setfiletype javascript
"   autocmd BufRead,BufNewFile *.js.es6 setfiletype javascript
"   autocmd BufNewFile,BufRead *.es6 set filetype=javascript.jsx
"   autocmd BufRead,BufNewFile *.json set filetype=javascript
" augroup END
"
" let g:jsx_ext_required = 0


" deoplete config
let g:deoplete#enable_at_startup = 1
" disable autocomplete
let g:deoplete#disable_auto_complete = 1
if has("gui_running")
  inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
else
  inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
endif

" ======== UltiSnips  ==========
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2

source ~/.dotfiles/vim/alias
source ~/.dotfiles/vim/keymap.vim

