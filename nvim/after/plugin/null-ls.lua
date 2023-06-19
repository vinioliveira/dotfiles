local null_ls = require("null-ls")

null_ls.setup({
  debug = false,
  debounce = 2000,
  sources = {
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.diagnostics.flake8,
  },
  -- on_attach = function(client, bufnr)
  -- end,
})

-- local lsp_formatting = function(bufnr)
--   vim.lsp.buf.format({
--     filter = function(client)
--       -- apply whatever logic you want (in this example, we'll only use null-ls)
--       return client.name == "null-ls"
--     end,
--     bufnr = bufnr,
--   })
-- end

-- if you want to set up formatting on save, you can use this as a callback
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
