local mopts = { noremap = true, silent = true }
local nvim_set_keymap = vim.api.nvim_set_keymap

-- See `:help vim.lsp.*` for documentation on any of the below functions
nvim_set_keymap('n', 'td', '<Cmd>lua vim.lsp.buf.definition()<CR>', mopts)
nvim_set_keymap('n', 'ti', '<cmd>lua vim.lsp.buf.implementation()<CR>', mopts)
nvim_set_keymap('n', 'tr', '<cmd>lua vim.lsp.buf.references()<CR>', mopts)
nvim_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', mopts)
nvim_set_keymap('n', '<c-j>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mopts)
nvim_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mopts)

nvim_set_keymap('n', 'tf', " <cmd> lua vim.lsp.buf.document_symbol()<CR>", mopts)

-- utils
nvim_set_keymap('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', mopts)
nvim_set_keymap('n', '<leader>i', '<Cmd>lua vim.lsp.buf.code_action()<CR>', mopts)
nvim_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', mopts)

-- diagnostic
nvim_set_keymap('n', '?', '<cmd>lua vim.diagnostic.open_float()<CR>', mopts)
nvim_set_keymap('n', '<leader>ap', '<cmd>lua vim.diagnostic.goto_prev()<CR>', mopts)
nvim_set_keymap('n', '<leader>an', '<cmd>lua vim.diagnostic.goto_next()<CR>', mopts)
