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

require('kanagawa').setup({
  theme = "wave",  -- Load "wave" theme when 'background' option is not set
  transparent = true,  -- Disable transparency
  background = {   -- map the value of 'background' option to a theme
    dark = "wave", -- try "dragon" !
    light = "lotus"
  },
});

-- vim.o.background = "light"
-- vim.cmd('colorscheme gruvbox')
-- vim.cmd('colorscheme tokyonight-storm')
-- vim.cmd('colorscheme tokyonight-day')
-- vim.cmd('colorscheme rose-pine-moon')
-- vim.cmd('colorscheme rose-pine-dawn')
-- vim.cmd('colorscheme deepwhite')
vim.cmd('colorscheme kanagawa-lotus')
-- vim.cmd('colorscheme rose-pine')
