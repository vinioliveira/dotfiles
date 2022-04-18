autocmd FileType java let b:dispatch = 'java %; java `basename % .java`'
autocmd FileType ruby let b:dispatch = 'ruby %'
autocmd FileType javascript let b:dispatch = 'node %'
autocmd FileType typescript let b:dispatch = 'ts-node %'

nnoremap <silent> <leader>vx :Dispatch <CR>
