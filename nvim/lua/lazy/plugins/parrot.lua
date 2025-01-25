return {
  "frankroeder/parrot.nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("parrot").setup {
      -- Providers must be explicitly added to make them available.
      providers = {
        anthropic = {
          api_key = os.getenv "ANTHROPIC_API_KEY",
        },
        github = {
          api_key = os.getenv "GITHUB_COPILOT",
        },
      },
      chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cg" },
      chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cd" },
      chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cs" },
      chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<leader>cn" },
      chat_free_cursor = true,
    }

    -- keymaps
    vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>PrtChatToggle<CR>", { noremap = true, silent = true })
    vim.keymap.set({ "v" }, "<leader>ca", ":<C-u>'<,'>PrtChatPaste<CR>", { noremap = true, silent = true })
    vim.keymap.set({ "v" }, "<leader>ce", "<cmd>PrtRewrite<CR>", { noremap = true, silent = true })
  end
}
