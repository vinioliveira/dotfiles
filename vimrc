let mapleader = ','

set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.dotfiles/vim/vimrc.bundler"))
  source ~/.dotfiles/vim/vimrc.bundler
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  "Adding es6 syntaxe
  autocmd BufRead,BufNewFile *.es6 setfiletype javascript
  autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

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
highlight ColorColumn ctermbg=235
set colorcolumn=80

" Numbers
set number
set relativenumber
set lazyredraw
set gdefault
set grepprg=ag " Use Silver Searcher instead of grep
set wmh=0
" Set the tag file search order
set tags=./tags;

" ================ Syntastic =======================
"mark syntax errors with :signs
let g:syntastic_enable_signs=1
"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
"show the error list automatically
let g:syntastic_auto_loc_list=1
"don't care about warnings
let g:syntastic_quiet_messages = {'level': 'warnings'}

" I have no idea why this is not working, as it used to
" be a part of syntastic code but was apparently removed
" This will make syntastic find the correct ruby specified by mri
function! s:FindRubyExec()
  if executable("rvm")
    return system("rvm tools identifier")
  endif

  return "ruby"
endfunction

if !exists("g:syntastic_ruby_exec")
  let g:syntastic_ruby_exec = s:FindRubyExec()
endif

" Disable the macvim toolbar
set guioptions-=T)

"============== RUBY  ===========================
set regexpengine=2

"============== THEME  ===========================
"

let base16colorspace=256
set background=dark
colorscheme base16-eighties

let $FZF_DEFAULT_COMMAND= 'ag -g ""'

nnoremap <silent> <C-p> :call fzf#run({
\   'down': '40%',
\   'sink': 'e' })<CR>

set clipboard=unnamed           "To copy to clipboard

"============== LIGHT LINE ===========================
set laststatus=2
"
let g:lightline = {
      \ 'colorscheme' : 'seoul256',
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


" use ,F to jump to tag in a vertical split
nnoremap <silent> <leader>F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" Rubocop
"
let g:vimrubocop_config = getcwd() + '/.rubocop.yml'

source ~/.dotfiles/vim/alias
source ~/.dotfiles/vim/keymap.vim

