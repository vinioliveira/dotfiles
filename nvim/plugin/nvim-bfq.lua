-- lua print(vim.inspect(require('bqf.config')))


require('bqf').setup {
  auto_enable = true,
  magic_window = true,
  auto_resize_height = true,
  -- auto_resize_height = {
  --   description = [[resize quickfix window height automatically.
  --           Shrink higher height to size of list in quickfix window, otherwise extend height
  --           to size of list or to default height (10)]],
  --   default = false
  -- },
  preview = {
    auto_preview = true
    --   auto_preview = {
    --     description = [[enable preview in quickfix window automatically]],
    --     default = false
    --   },
    --   border_chars = {
    --     description = [[border and scroll bar chars, they respectively represent:
    --                 vline, vline, hline, hline, ulcorner, urcorner, blcorner, brcorner, sbar]],
    --     default = { '│', '│', '─', '─', '╭', '╮', '╰', '╯', '█' }
    --   },
    --   delay_syntax = {
    --     description = [[delay time, to do syntax for previewed buffer, unit is millisecond]],
    --     default = 50
    --   },
    --   win_height = {
    --     description = [[the height of preview window for horizontal layout,
    --                 large value (like 999) perform preview window as a "full" mode]],
    --     default = 15
    --   },
    --   win_vheight = {
    --     description = [[the height of preview window for vertical layout]],
    --     default = 15
    --   },
    --   wrap = {
    --     description = [[wrap the line, `:h wrap` for detail]],
    --     default = false
    --   },
    --   should_preview_cb = {
    --     description = [[a callback function to decide whether to preview while switching buffer,
    --                 with (bufnr: number, qwinid: number) parameters]],
    --     default = nil
    --   }
  },
  func_map = {
    -- filter = 'f',
    drop = '<CR>',
    -- split = '<C-s>',
    -- tabdrop = '<C-t>',
    -- tabc = '',
    -- ptogglemode = 'z,',
  },
  filter = {
    fzf = {
      action_for = {
        ['ctrl-t'] = 'tabedit',
        ['ctrl-v'] = 'vsplit',
        ['ctrl-x'] = 'split',
        ['ctrl-q'] = 'signtoggle',
        ['ctrl-c'] = 'closeall'
      },
      extra_opts = {}
    }
  }
}


local function toggle_qf()
  local qf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_open = true
    end
  end
  if qf_open == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  end
end
