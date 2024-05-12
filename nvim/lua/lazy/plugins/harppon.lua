return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup({
      settitngs = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
      menu = {
        width = 120,
      }
    })

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<leader>hq", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>hw", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>he", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>hr", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end
}
