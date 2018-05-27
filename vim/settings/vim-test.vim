let g:dispatch_quickfix_height=15
let g:test#runner_commands = ['Mocha']
let test#strategy = "dispatch"
let g:test#javascript#mocha#file_pattern = '\v.*.(test|spec)s?\.(js|jsx|coffee)$'


"=========== VIm - Test ==========================
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>
