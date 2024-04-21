return {
  'rmagatti/goto-preview',
  config = function()
    vim.keymap.set("n", "tp", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true })
    -- vim.keymap.set("n", "tr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true })
    vim.keymap.set("n", "ti", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true })
    -- nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
  end
}
