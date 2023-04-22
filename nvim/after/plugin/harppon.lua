local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

require("harpoon").setup({
  menu = {
    width = 120,
  }
})

vim.keymap.set("n", "<leader>ha", mark.toggle_file)
vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

vim.keymap.set("n", "<leader>hq", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>hw", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>he", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>hr", function() ui.nav_file(4) end)




vim.keymap.set("n", "<leader>hh", ui.toggle_quick_menu)

vim.api.nvim_create_user_command("HarpoonClear", function()
  mark.clear_all()
end, {})
