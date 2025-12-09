return {
  "vimtools/none-ls.nvim",
  enabled = false,
  event = "BufReadPost",
  dependencies = {
    "vimtools/none-ls-extras.nvim", -- extra sources
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        require("none-ls.diagnostics.eslint"), -- requires none-ls-extras.nvim
      },
    })
  end,
}
