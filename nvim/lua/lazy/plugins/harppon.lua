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

    vim.keymap.set("n", "<leader>ht", function() harpoon:list():toggle() end)
    vim.keymap.set("n", "<leader>hi", function()
      harpoon:list():add()
      vim.notify("File: " .. vim.fn.expand('%') .. " Added")
    end)
    vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "<leader>hg", function() harpoon:list():select(5) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end
}
