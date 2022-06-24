" Auto indent pasted text
"Plug 'ayu-theme/ayu-vim' nnoremap p p=`]<C-o>
" nnoremap P P=`]<C-o>

" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
map<C-s> <esc>:w<CR><esc>
imap<C-s> <esc>:w<CR><esc>

" Save and exit shortcut
map <leader>x <esc>:x<CR><esc>

" quit all
map <leader>q <esc>:qa!<CR><esc>


noremap <S-q> q
noremap q <Nop>

" move lines through the file
vnoremap <C-J> :m '>+1<CR>gv=gv
vnoremap <C-K> :m '<-2<CR>gv=gv

" Visual linewise up and down by default (and use gj gk to go quicker)
nnoremap gj 5j
nnoremap gk 5k

" When jump to next match also center screen
" Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
nnoremap <silent> n :norm! nzz<CR>
nnoremap <silent> N :norm! Nzz<CR>
vnoremap <silent> n :norm! nzz<CR>
vnoremap <silent> N :norm! Nzz<CR>

nnoremap <silent> <leader>vr :source $MYVIMRC<CR>
nnoremap <silent> <leader>vs :vsplit $MYVIMRC<CR>

nnoremap <silent> <leader>o :copen<CR>
nnoremap <silent> <leader>n :cnext<CR>
nnoremap <silent> <leader>p :cprevious<CR>

" CTRL-Tab is next tab
noremap <C-t> :tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-T> :tabprevious<CR>
noremap <leader>nt :tabe <CR>

noremap <leader>bn :bnext <CR>
noremap <leader>bp :bprevious <CR>
noremap <leader>bd :BufferDelete <CR>

" nnoremap <enter>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" dont't loose selection while move
xnoremap <  <gv
xnoremap >  >gv

" clean search after esc
nnoremap <ESC> :noh<CR><ESC>
