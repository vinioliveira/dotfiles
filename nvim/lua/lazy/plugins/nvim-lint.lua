return {
  'mfussenegger/nvim-lint',
  event = "BufReadPost",
  config = function()
    require('lint').linters_by_ft = {
      javascript = { 'eslint_d', 'cspell' },
      typescript = { 'eslint_d', 'cspell' },
      typescriptreact = { 'eslint_d', 'cspell' },
      markdown = { "cspell" },
      go = { "cspell" },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end

}
