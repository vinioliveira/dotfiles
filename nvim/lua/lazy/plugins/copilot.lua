return {
  "github/copilot.vim",
  enabled  = false,
  event    = "BufReadPost",
  priority = 15,
  init     = function()
    vim.keymap.set('i', '<Right>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    -- disable default tab keymap
    vim.g.copilot_no_tab_map = true
  end,
}
