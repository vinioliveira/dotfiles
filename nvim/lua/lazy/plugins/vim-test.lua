return {
  'janko-m/vim-test',
  cmd = { 'TestFile', 'TestNearest' },
  init = function()
    vim.api.nvim_exec([[
      let g:test#preserve_screen = 0
      let g:dispatch_quickfix_height=15

      let test#python#runner = 'pytest'
      let test#javascript#runner = 'jest'

      let g:test#javascript#mocha#file_pattern = '\v.*.(test|spec)s?\.(js|ts)$'
      let g:test#javascript#mocha#environment = {'NODE_ENV': 'test'}

      let g:test#javascript#jest#file_pattern = '\v(test|spec)s?\.(jsx|tsx|ts|js)$'
      let test#javascript#jest#executable = 'COLORS=false DEBUG_PRINT_LIMIT=100000 pnpm jest'

      let g:neomake_list_height = -1
      let test#strategy = 'dispatch_background'

      function! TypeScriptTransform(cmd) abort
        let acmd = substitute(a:cmd, '\[', '\\[', 'g')
        return acmd
      endfunction

      let g:test#custom_transformations = { 'typescript': function('TypeScriptTransform')}
      let g:test#custom_transformations = { 'javascript': function('TypeScriptTransform')}
      let g:test#transformation = 'typescript'
      let g:test#transformation = 'javascript'

      let test#javascript#mocha#options =  '--exit'

      nnoremap <silent> tt :TestFile<CR>
      nnoremap <silent> ts :TestNearest<CR>
      nnoremap <silent> tl :TestLast<CR>
      nnoremap <silent> ta :TestSuit<CR>
      nnoremap <silent> tgt :TestVisit<CR>
      nnoremap <silent> <leader>td :TestNearest -strategy=jest-debug<CR>
    ]], true);
  end
}
