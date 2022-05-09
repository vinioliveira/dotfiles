" " let g:fzf_layout = { 'up': '~40%' }
let g:fzf_history_dir = '~/.config/nvim/fzf-history'
" let g:fzf_preview_window = 'right:60%'

" " In Neovim, you can set up fzf window using a Vim command
" " let g:fzf_layout = { 'window': 'belowright 15sp enew' }

" let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

" function! s:build_quickfix_list(lines)
"   call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
"   copen
"   cc
" endfunction

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit' }


let g:fzf_preview_window = ['right:40%', 'ctrl-/']
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1


" command! -bang -nargs=* -complete=dir Ag
"   \ call fzf#vim#grep('ag --nogroup --column --color '.join(map([<f-args>], 'shellescape(v:val)')), 0
"   \   fzf#vim#with_preview(), <bang>0)
"
command! -bang -nargs=+ -complete=file Ag call fzf#vim#ag_raw(<q-args>, fzf#vim#with_preview(), <bang>0)


" ============ MAPS ==============
nnoremap <leader>b :Buffers<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Ag<space>
nnoremap <leader>ag :Ag<space>
" nnoremap <leader>f :BTags<CR>
" nnoremap <leader>F :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

" " Insert mode completion
" " imap <c-x><c-k> <plug>(fzf-complete-word)
" " imap <c-x><c-f> <plug>(fzf-complete-path)
" " imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" " imap <c-x><c-l> <plug>(fzf-complete-line)
" " inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
