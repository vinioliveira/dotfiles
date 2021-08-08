autocmd FileType java let b:dispatch = 'java %; java `basename % .java`'
autocmd FileType javascript let b:dispatch = 'node %'

nnoremap <silent> <leader>vx :Dispatch <CR>
