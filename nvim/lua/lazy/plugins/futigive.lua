return {
  'tpope/vim-fugitive',
  config = function()
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "gs", ":abo Git<CR>", opts)
    vim.keymap.set("n", "go", ":GBrowse<CR>", opts)
    vim.keymap.set("n", "gd", ":Gvdiff<CR>", opts)
    vim.keymap.set("n", "gu", ":Dispatch git up<CR>", opts)
    vim.keymap.set("n", "gp", ":echom('Pushing... ') \\| Git push<CR>", opts)
    vim.keymap.set("n", "<leader>gf", ":echom('Force pushing... ') \\| Git push --force-with-lease<CR>", opts)
    vim.keymap.set("n", "gb", ":Git blame<CR>", opts)
    vim.keymap.set("v", "go", ":BBrowse<CR>", opts)
  end
}
