vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)


if vim.fn.has("persistent_undo") then
  local target_path = vim.fn.expand(vim.fn.getcwd() .. '/.undodir')

  if not vim.fn.isdirectory(target_path) then
    vim.fn.mkdir(target_path, "p", 0700)
  end

  vim.opt.undodir = target_path
  vim.opt.undofile = true
end
