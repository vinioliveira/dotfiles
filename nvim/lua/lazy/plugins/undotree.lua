return {
  'mbbill/undotree',
  cmd = { 'UndotreeToggle' },
  -- keys = {
  --   {
  --     '<leader>u',
  --     function()
  --       vim.cmd.UndotreeToggle()
  --     end,
  --     mode = 'n',
  --     desc = 'Toggle undotree'
  --   }
  -- },
  init = function()
    if vim.fn.has("persistent_undo") then
      local target_path = vim.fn.expand(vim.fn.getcwd() .. '/.undodir')

      if not vim.fn.isdirectory(target_path) then
        vim.fn.mkdir(target_path, "p", 0700)
      end

      vim.opt.undodir = target_path
      vim.opt.undofile = true
    end

    vim.g.undotree_SplitWidth = 45

    vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', { noremap = true, silent = true })
  end
}
