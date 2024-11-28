return {
  'mfussenegger/nvim-lint',
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint_d', 'cspell' },
      typescript = { 'eslint_d', 'cspell' },
      typescriptreact = { 'eslint_d', 'cspell' },
      markdown = { "cspell" },
      lua = { "cspell" },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end

}
