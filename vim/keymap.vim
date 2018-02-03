let mapleader = ','

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

"============== FZF  ===========================
" Insert mode completion
" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

nnoremap <C-p> :FZF<CR>
nnoremap <leader>F :BTags<CR>
nnoremap <leader>? :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

nnoremap <leader>b :Unite buffer<CR>

"========== Remaping Record Key ================
noremap <Leader>q q
noremap q <Nop>

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
map <C-s> <esc>:w<CR><esc>
imap <C-s> <esc>:w<CR><esc>

" commentary map
map <c-_><c-_> gcc
imap <c-_><c-_> <esc>gcc
vmap <c-_><c-_> gc

" Save and exit shortcut
map <leader>x <esc>:x<CR><esc>
imap <leader>x <esc>:x<CR><esc>

" quit all
map <leader>q <esc>:qa!<CR><esc>
imap <leader>q <esc>:qa!<CR><esc>

"========== VimFiler Map ===============
map <leader>d <esc>:VimFiler <C-R>=getcwd()<CR><esc>
imap <leader>d <esc>:VimFiler <C-R>=getcwd()<CR><esc>

"Open in the current directory
map <Leader>e :VimFiler <C-R>=escape(expand("%:p:h")," ")<CR><esc>
imap <Leader>e :VimFiler <C-R>=escape(expand("%:p:h"),' ')<CR><esc>

map <leader>E <esc>:VimFilerExplorer <C-R>=getcwd()<CR><esc>
imap <leader>E <esc>:VimFilerExplorer <C-R>=getcwd()<CR><esc>

" use ,F to jump to tag in a vertical split
" nnoremap <silent> <leader>F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" move lines through the file
nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" alias yw to yank the entire word 'yank inner word'
" even if the cursor is halfway inside the word
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>yw yiww

" ,ow = 'overwrite word', replace a word with what's in the yank buffer
" FIXME: will not properly repeat when you use a dot (tie into repeat.vim)
nnoremap <leader>ow "_diwhp

"=========== VIm - Test ==========================
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

" ============ Surround Vim Shortcuts ==============
vmap ' S'
vmap " S"

"============== CTAGS ========================
" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
nnoremap <silent> <leader>f <C-]>

" VIM-FUGTIVE map
nnoremap <silent> <Leader>g :Gstatus<CR>

" Easier fold toggling
nnoremap <leader>z za

" Start substitute on current word under the cursor
nnoremap <leader>S :%Subvert//gc<Left><Left><Left>

" " Visual linewise up and down by default (and use gj gk to go quicker)
nnoremap j gj
nnoremap k gk
nnoremap gj 5j
nnoremap gk 5k
vnoremap j gj
vnoremap k gk
vnoremap gj 5j
vnoremap gk 5k

" When jump to next match also center screen
" Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>

" Reselect last-pasted text
nnoremap gp `[v`]

nnoremap <silent> <leader>r :source $MYVIMRC<CR>

" VIM-FUGTIVE map
" nnoremap <buffer> gd :TernDef<CR>
nnoremap <buffer> gd :TernDef<CR>

