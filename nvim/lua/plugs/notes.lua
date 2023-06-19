local M = {}

M.open_win_notes = function(global_notes)
  local notes_uri = global_notes
      and vim.uri_from_fname(vim.fn.expand('$HOME/.global_notes.md'))
      or vim.uri_from_fname(vim.fn.getcwd() .. "/notes.md")
  local current_win = vim.api.nvim_get_current_win()
  local success, result = pcall(vim.api.nvim_win_get_var, current_win, "note-preview")

  if success and result == 1 then
    vim.api.nvim_win_close(current_win, true)
  else
    local file = vim.uri_to_bufnr(notes_uri)

    local width = vim.api.nvim_get_option("columns")
    local height = vim.api.nvim_get_option("lines")

    local win_height = math.ceil(height * 0.8 - 4)
    local win_width = math.ceil(width * 0.8)

    local row = math.ceil((height - win_height) / 2 - 1)
    local col = math.ceil((width - win_width) / 2)

    local opts = {
      style = "minimal",
      relative = "editor",
      width = win_width,
      height = win_height,
      row = row,
      col = col,
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    }

    local win = vim.api.nvim_open_win(file, true, opts)
    vim.api.nvim_win_set_option(win, "cursorline", true)
    vim.api.nvim_win_set_var(win, "note-preview", 1)
  end
end

return M
