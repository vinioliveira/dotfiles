-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
local harpoon = require("harpoon")
harpoon.setup({
  menu = {
    width = 120,
  }
})

vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end)
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>hq", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>hw", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>he", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>hr", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)


-- vim.api.nvim_create_user_command("HarpoonClear", function()
--   mark.clear_all()
-- end, {})
