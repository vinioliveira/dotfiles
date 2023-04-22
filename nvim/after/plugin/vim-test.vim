" https://github.com/vim-test/vim-test
" https://github.com/vim-test/vim-test/blob/master/doc/test.txt
let g:test#preserve_screen = 0
let g:dispatch_quickfix_height=15

let test#python#runner = 'pytest'
let test#javascript#runner = 'jest'

let g:test#javascript#mocha#file_pattern = '\v.*.(test|spec)s?\.(js|ts)$'
let g:test#javascript#mocha#environment = {'NODE_ENV': 'test'}

" let g:test#javascript#jest#file_pattern = '\v(test|spec)s?\.(jsx|tsx)$'
let g:test#javascript#jest#file_pattern = '\v(test|spec)s?\.(jsx|tsx|ts|js)$'
let test#javascript#jest#executable = 'pnpm jest'

let g:neomake_list_height = -1
let test#strategy = 'dispatch_background'

" let test#javascript#nx#executable = 'node --inspect-brk ./node_modules/@nrwl/cli/bin/nx'
" let test#javascript#nx#options = '--skip-nx-cache --unhandled-rejections=strict --no-cache'


function! RunDebugger(cmd) abort
  let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
  let fileName = substitute(fileName, '"', '', 'g')
  let fileName = substitute(fileName, '^\s\+', '', '')
  let fileName = substitute(fileName, '\[', '\\[', 'g')

  call luaeval("require'plugs.debug'.debugJest([[" . testName . "]], [[" . fileName . "]])")
endfunction
let g:test#custom_strategies = { 'jest-debug': function('RunDebugger') }


let test#javascript#mocha#options =  '--exit'

"=========== VIm - Test ==========================
nnoremap <silent> tt :TestFile<CR>
nnoremap <silent> ts :TestNearest<CR>
nnoremap <silent> tl :TestLast<CR>
nnoremap <silent> ta :TestSuit<CR>
nnoremap <silent> tgt :TestVisit<CR>
nnoremap <silent> <leader>td :TestNearest -strategy=jest-debug<CR>
