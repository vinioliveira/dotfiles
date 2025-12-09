return {
  'mfussenegger/nvim-lint',
  enabled = true,
  event = "BufReadPost",
  config = function()
    local lint = require("lint")
    local lspconfig_util = require("lspconfig.util")

    lint.linters_by_ft = {
      javascript = { 'cspell' },
      typescript = { 'cspell' },
      typescriptreact = { 'cspell' },
      --
      -- javascript = { 'eslint', 'cspell' },
      -- typescript = { 'eslint', 'cspell' },
      -- typescriptreact = { 'eslint', 'cspell' },
      markdown = { "cspell" },
      go = { "cspell" },
    }


    lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
      diagnostic.severity = vim.diagnostic.severity.HINT
      return diagnostic
    end)

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        require('lint').try_lint()
      end,
    })
  end
}
