return {
  'tpope/vim-fugitive',
  dependencies = {
    "tpope/vim-rhubarb",
  },
  config = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "gs", ":abo Git<CR>", opts)
    vim.keymap.set({ "n", "v" }, "go", ":GBrowse<CR>", opts)
    vim.keymap.set("n", "gd", ":Gvdiff<CR>", opts)
    vim.keymap.set("n", "gu", ":Dispatch git up<CR>", opts)
    vim.keymap.set("n", "gp", ":echom('Pushing... ') | Dispatch git push<CR>", opts)
    vim.keymap.set("n", "<leader>gf", ":echom('Force pushing... ') | Dispatch git push --force-with-lease<CR>", opts)
    vim.keymap.set("n", "gb", ":Git blame<CR>", opts)
    vim.keymap.set("n", "gcpr", ":Dispatch gh pr create -f<CR>", opts)
    vim.keymap.set("n", "gopr", ":Dispatch gh pr view --web<CR>", opts)
  end
}
