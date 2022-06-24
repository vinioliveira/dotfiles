" https://github.com/vim-test/vim-test
" https://github.com/vim-test/vim-test/blob/master/doc/test.txt
let g:test#preserve_screen = 0
let g:dispatch_quickfix_height=15
let test#strategy = "dispatch"
let g:test#runner_commands = ['RSpec', 'Mocha', 'jest']


let g:test#javascript#mocha#file_pattern = '\v.*.(test|spec)s?\.(js|ts)$'
let g:test#javascript#mocha#environment = {'NODE_ENV': 'test'}
let g:test#javascript#jest#file_pattern = '\v(test|spec)s?\.(jsx|tsx)$'
let test#javascript#jest#executable = 'CI=true npm test'

let test#javascript#nx#options = '--skip-nx-cache --unhandled-rejections=strict --no-cache'
" let test#javascript#nx#executable = 'npm run jest'



let test#javascript#mocha#options =  '--exit'

" function! TypeScriptTransform(cmd) abort
"   let file = g:test#last_position['file']
"   if file =~# '\v.*\.(ts|ts)' || &ft=='typescript'
"     return substitute(a:cmd, '\v(.*)mocha', 'NODE_ENV=test $(yarn bin)/mocha -r ts-node/register', '')
"   else
"     return substitute(a:cmd, '\v(.*)mocha', 'NODE_ENV=test $(yarn bin)/mocha', '')
"   endif
" endfunction

" let g:test#custom_transformations = { 'typescript': function('TypeScriptTransform')}
" let g:test#transformation = 'typescript'

" let test#java#runner = 'gradletest'

"=========== VIm - Test ==========================
nnoremap <silent> tt :TestFile<CR>
nnoremap <silent> ts :TestNearest<CR>
nnoremap <silent> tl :TestLast<CR>
nnoremap <silent> ta :TestSuite<CR>
nnoremap <silent> tgt :TestVisit<CR>
