return {
  'junegunn/goyo.vim',
  keys = {
    { "<leader>z", ":Goyo<CR>", { noremap = true } },
  },
  config = function()
    vim.g.goyo_width = '70%'
    vim.g.goyo_height = 100
    vim.g.goyo_margin_top = 0
    vim.g.goyo_margin_bottom = 0
    vim.g.goyo_linenr = 1
  end
}
