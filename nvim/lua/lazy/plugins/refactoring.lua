return {
  "ThePrimeagen/refactoring.nvim",
  event = "InsertEnter",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("refactoring").setup()

    vim.keymap.set("x", "<space>re", function() require('refactoring').refactor('Extract Function') end)
    vim.keymap.set("x", "<space>rf", function() require('refactoring').refactor('Extract Function To File') end)
    -- Extract function supports only visual mode
    --
    vim.keymap.set("x", "<space>rv", function() require('refactoring').refactor('Extract Variable') end)
    -- Inline var supports both normal and visual mode

    vim.keymap.set("n", "<space>rb", function() require('refactoring').refactor('Extract Block') end)
    vim.keymap.set("n", "<space>rbf", function() require('refactoring').refactor('Extract Block To File') end)
    -- Extract block supports only normal mode
  end,
}
