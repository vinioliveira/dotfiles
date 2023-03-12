local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local null_ls = require("null-ls")

null_ls.setup({
  debug = false,
  debounce = 500,
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.diagnostics.flake8,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
