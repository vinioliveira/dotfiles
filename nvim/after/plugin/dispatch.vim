autocmd FileType java let b:dispatch = 'java %; java `basename % .java`'
autocmd FileType ruby let b:dispatch = 'ruby %'
autocmd FileType sh let b:dispatch = 'sh %'
autocmd FileType javascript let b:dispatch = 'node %'
autocmd FileType typescript let b:dispatch = 'ts-node %'
autocmd FileType python let b:dispatch = 'python3 %'

nnoremap <silent> <leader>vx :Dispatch <CR>
