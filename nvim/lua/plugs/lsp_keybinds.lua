return function(bufnr)
  local mopts = { buffer = bufnr, noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'tD', '<cmd>lua vim.lsp.buf.declaration()<CR>', mopts)
  vim.keymap.set('n', 'td', '<cmd>lua vim.lsp.buf.definition()<CR>', mopts)
  vim.keymap.set('n', 'ti', '<cmd>lua vim.lsp.buf.implementation()<CR>', mopts)
  vim.keymap.set('n', 'tr', '<cmd>lua vim.lsp.buf.references()<CR>', mopts)
  -- vim.keymap.set('i', '<c-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mopts)
  vim.keymap.set('n', '<c-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', mopts)
  vim.keymap.set('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mopts)


  -- utils
  vim.keymap.set({ 'n', 'v' }, '<leader>f', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', mopts)
  -- vim.keymap.set({ 'n', 'v' }, '<leader>f', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', mopts)
  -- saga is handle it
  -- vim.keymap.set('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', mopts)
  vim.keymap.set('n', '<leader>r', '<Cmd>lua require("plugs/lsp_extand").rename()<CR>', mopts)

  -- vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua Rename.rename()<CR>, {silent = true})
  vim.keymap.set('n', '<leader>i', '<Cmd>lua vim.lsp.buf.code_action()<CR>', mopts)
  vim.keymap.set('n', 'tf', " <cmd> lua vim.lsp.buf.document_symbol()<CR>", mopts)

  -- saga is handle it
  -- diagnostic
  vim.keymap.set('n', '?', '<cmd>lua vim.diagnostic.open_float()<CR>', mopts)
  vim.keymap.set('n', '<leader>ap', '<cmd>lua vim.diagnostic.goto_prev()<CR>', mopts)
  vim.keymap.set('n', '<leader>an', '<cmd>lua vim.diagnostic.goto_next()<CR>', mopts)
  vim.keymap.set('n', '<leader>al', '<cmd>lua vim.diagnostic.setloclist()<CR>', mopts)
end
