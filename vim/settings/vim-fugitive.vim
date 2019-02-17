"============== Maps  ===========================
nnoremap <silent> <Leader>gs :Gstatus<CR>
nnoremap <silent> <Leader>go :Gbrowse<CR>
nnoremap <silent> <Leader>gd :Gdiff<CR>
nnoremap <silent> <Leader>gp :Gpull --rebase origin \"$(git rev-parse --abbrev-ref HEAD)\<CR>
nnoremap <silent> <Leader>gb :Gblame<CR>
