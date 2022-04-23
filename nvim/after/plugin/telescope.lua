local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>b', '<cmd>Telescope buffers<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>ag', '<cmd>Telescope live_grep<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim" -- add this value
    },
  }
  -- pickers = {
  --   find_files = {
  --     theme = "ivy",
  --   },
  --   buffers = {
  --     theme = "ivy"
  --   }
  -- }
}
