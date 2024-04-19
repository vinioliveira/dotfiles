require('lint').linters_by_ft = {
  typescript = { 'eslint_d' },
  typescriptreact = { 'eslint_d' }
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    require('lint').try_lint()
  end,
})
