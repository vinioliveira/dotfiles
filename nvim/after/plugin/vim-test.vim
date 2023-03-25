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

" let g:test#strategy = 'neomake'
" let test#strategy = "dispatch"
" let test#strategy = "dispatch"
" let test#strategy = "neomake"

let g:neomake_list_height = -1
let test#strategy = {
  \ 'nearest': 'dispatch',
  \ 'file':    'dispatch',
  \ 'suite':   'neomake',
\}

" let test#javascript#nx#executable = 'node --inspect-brk ./node_modules/@nrwl/cli/bin/nx'
let test#javascript#nx#options = '--skip-nx-cache --unhandled-rejections=strict --no-cache'

" function! g:test#javascript#nx#build_options(args, options) abort
"   return  a:args + options
" endfunction

" function! g:test#javascript#nx#build_options(args, options) abort
"   return  a:args + options
" endfunction
" let test#javascript#nx#executable = 'npm run jest'


function! RunDebugger(cmd) abort
  let testName = matchlist(a:cmd, '\v -t ''(.*)''')[1]
  let fileName = matchlist(a:cmd, '\v'' -- (.*)$')[1]
  " let command =  substitute(a:cmd, '\vpnpm jest', 'pnpm jest:dbebug', '')
  call luaeval("require'plugs.debug'.debugJest([[" . testName . "]], [[" . fileName . "]])")
endfunction
let g:test#custom_strategies = { 'jest-debug': function('RunDebugger') }
" let g:test#custom_transformations = { 'jest-debug': function('RunDebugger')}


let test#javascript#mocha#options =  '--exit'
" let g:neomake_open_list=2
" let g:neomake_enabled_makers=1
" let g:neomake_place_signs=1

" function! TypeScriptTransform(cmd) abort
"   if a:cmd =~ '--debug'
"     let command = substitute(a:cmd, '\vpnpm jest', 'pnpm jest:debug', '')
"     return substitute(command, '--debug', '', '')
"   else
"     return a:cmd
"   endif
" endfunction
" let g:test#custom_transformations = { 'typescript': function('TypeScriptTransform')}
" let g:test#transformation = 'typescript'

" let g:test#custom_transformations = { 'typescript': function('TypeScriptTransform')}
" let g:test#transformation = 'typescript'
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
nnoremap <silent> ta :TestSuit<CR>
nnoremap <silent> tgt :TestVisit<CR>
nnoremap <silent> <leader>td :TestNearest -strategy=jest-debug<CR>


function! MyOnNeomakeJobStarted() abort
  let g:test_all_status = -1
endfunction

function! MyOnNeomakeJobFinished() abort
  let context = g:neomake_hook_context
  if context.jobinfo.exit_code == 0
    let g:test_all_status = 0
  endif
  if context.jobinfo.exit_code == 1
    let g:test_all_status = 1
  endif
endfunction

augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished call MyOnNeomakeJobFinished()
  autocmd User NeomakeJobStarted call MyOnNeomakeJobStarted()
augroup END
