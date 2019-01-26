" other mappsigs files
" settings/fzf.vim
" settings/vim-test.vim
" settings/vimfiler.vim
" settings/surround.vim
" settings/vim-fugitve.vim

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

"========== Remaping Record Key ================
noremap <Leader>q q
" noremap q <Nop>

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

" use ,F to jump to tag in a vertical split
" nnoremap <silent> <leader>F :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" move lines through the file
nnoremap <C-J> :m .+1<CR>==
nnoremap <C-K> :m .-2<CR>==
inoremap <C-J> <Esc>:m .+1<CR>==gi
inoremap <C-K> <Esc>:m .-2<CR>==gi
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

"============== CTAGS ========================
" hit ,f to find the definition of the current class
" this uses ctags. the standard way to get this is Ctrl-]
" nnoremap <silent> <leader>f <C-]>

" Easier fold toggling
nnoremap <leader>z za

" Start substitute on current word under the cursor
nnoremap <leader>S :%Subvert//gc<Left><Left><Left>

" " Visual linewise up and down by default (and use gj gk to go quicker)
" nnoremap j gj
" nnoremap k gk
nnoremap gj 5j
nnoremap gk 5k
" vnoremap j gj
" vnoremap k gk
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

nnoremap <silent> <leader>n :cnext<CR>
nnoremap <silent> <leader>p :cprevious<CR>

" CTRL-Tab is next tab
noremap <C-t> :<C-U>tabnext<CR>
inoremap <C-t> <C-\><C-N>:tabnext<CR>
cnoremap <C-t> <C-\><C-N>:tabnext<CR>

" CTRL-SHIFT-Tab is previous tab
noremap <C-S-t> :<C-U>tabprevious<CR>
inoremap <C-S-t> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-t> <C-C>:tabprevious<CR>

" delete all buffers
inoremap <leader>bd :bufdo :bdelete<CR>
noremap <leader>bd :bufdo :bdelete<CR>
cnoremap <leader>bd :bufdo :bdelete<CR>


