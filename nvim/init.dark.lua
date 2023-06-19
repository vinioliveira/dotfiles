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

-- vim.cmd('colorscheme tokyonight-night')
-- vim.cmd('colorscheme tokyonight-storm')
-- vim.cmd('colorscheme tokyonight-day')
-- vim.cmd('colorscheme rose-pine-moon')
-- vim.cmd('colorscheme rose-pine-dawn')
vim.cmd('colorscheme rose-pine')
