local root_markers = { 'Gemfile', 'package.json', '.git/' }
function _G.RunVimTest(cmd_name)
  return function()
    for _, marker in ipairs(root_markers) do
      local marker_file = vim.fn.findfile(marker, vim.fn.expand('%:p:h') .. ';')
      if #marker_file > 0 then
        vim.g['test#project_root'] = vim.fn.fnamemodify(marker_file, ":p:h")
        break
      end
      local marker_dir = vim.fn.finddir(marker, vim.fn.expand('%:p:h') .. ';')
      if #marker_dir > 0 then
        vim.g['test#project_root'] = vim.fn.fnamemodify(marker_dir, ":p:h")
        break
      end
    end

    vim.cmd(':' .. cmd_name)
  end
end

return {
  'janko-m/vim-test',
  cmd = { 'TestFile', 'TestNearest' },
  keys = {
    { 'ts', RunVimTest('TestNearest'), desc = "Run nearest test" },
    { 'tt', RunVimTest('TestFile'),    desc = "Run all tests in the current file" },
    { 'tl', RunVimTest('TestLast'),    desc = "Run last test again" }
  },
  config = function()
    vim.g['test#preserve_screen'] = 0
    vim.g['dispatch_quickfix_height'] = 15

    vim.g['test#javascript#vitest#executable'] = 'NO_COLOR=true pnpm vitest '
    vim.g['test#strategy'] = 'dispatch_background'

    -- vim.g['test#javascript#runner'] = 'jest'

    vim.g['g:test#javascript#mocha#file_pattern'] = '\\v.*.(test|spec)s?\\.(js|ts)$'
    vim.g['g:test#javascript#mocha#environment'] = { NODE_ENV = 'test' }

    vim.g['g:test#javascript#jest#file_pattern'] = '\\v(test|spec)s?\\.(jsx|tsx|ts|js)$'
    vim.g['test#javascript#jest#executable'] = 'COLORS=false DEBUG_PRINT_LIMIT=100000 pnpm jest '

    -- Don't close  after running tests
    vim.g['test#preserve_screen'] = 1
  end
  -- init = function()
  --   -- vimscript
  --   vim.api.nvim_exec([[
  --     let g:test#preserve_screen = 0
  --     let g:dispatch_quickfix_height=15

  --     let test#python#runner = 'pytest'
  --     " let test#javascript#runner = 'jest'

  --     " let g:test#javascript#mocha#file_pattern = '\v.*.(test|spec)s?\.(js|ts)$'
  --     " let g:test#javascript#mocha#environment = {'NODE_ENV': 'test'}

  --     " let g:test#javascript#jest#file_pattern = '\v(test|spec)s?\.(jsx|tsx|ts|js)$'
  --     " let test#javascript#jest#executable = 'COLORS=false DEBUG_PRINT_LIMIT=100000 pnpm jest '

  --     let g:neomake_list_height = -1
  --     let test#strategy = 'dispatch_background'

  --     " function! TypeScriptTransform(cmd) abort
  --     "   let acmd = substitute(a:cmd, '\[', '\\[', 'g')
  --     "   return acmd
  --     " endfunction

  --     " let g:test#custom_transformations = { 'typescript': function('TypeScriptTransform')}
  --     " let g:test#custom_transformations = { 'javascript': function('TypeScriptTransform')}
  --     " let g:test#transformation = 'typescript'
  --     " let g:test#transformation = 'javascript'

  --     " let test#javascript#mocha#options =  '--exit'

  --     nnoremap <silent> tt :TestFile<CR>
  --     nnoremap <silent> ts :TestNearest<CR>
  --     nnoremap <silent> tl :TestLast<CR>
  --     nnoremap <silent> tgt :TestVisit<CR>
  --   ]], true);
  -- end
}
