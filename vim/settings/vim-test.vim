let g:test#preserve_screen = 0
let g:dispatch_quickfix_height=15
let test#strategy = "dispatch"
let g:test#runner_commands = ['RSpec', 'Mocha', 'jest']


let g:test#javascript#mocha#file_pattern = '\v.*.(test|spec)s?\.(js|jsx|coffee|ts)$'
let g:test#javascript#jest#file_pattern = '\v.*.(test|spec)s?\.(js|jsx|coffee|ts)$'
let test#javascript#jest#executable = 'CI=true npm test'

" let test#javascript#mocha#options =  '--exit'

"=========== VIm - Test ==========================
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>
