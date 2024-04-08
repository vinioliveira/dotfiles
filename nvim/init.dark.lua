require "global.set"
require "global.keymap"
require "plugger"


-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   group = vim.api.nvim_create_augroup('TrailingSpaces', {}),
--   pattern = "*",
--   command = [[%s/\\s\\+$//e]],
-- })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup('TrailingSpaces', {}),
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})


-- vim.g.onedark_config = {
--   ['style'] = 'darker',
-- }

vim.cmd('colorscheme rose-pine')
