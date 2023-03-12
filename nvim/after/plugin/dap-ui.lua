local status_ok, dap = pcall(require, "dap")
if not status_ok then
  return
end
local dapui = require "dapui"

dapui.setup({
  icons = { expanded = "", collapsed = "", circular = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {},
  expand_lines = true,
  layouts = {
    {
      elements = {
        { id = "breakpoints", size = 0.20 },
        { id = "stacks", size = 0.40 },
        { id = "scopes", size = 0.40 },
      },
      size = 0.25,
      position = "right",
    },
    -- {
    --   elements = {
    --     { id = "repl", size = 0.45 },
    --     { id = "console", size = 0.55 },
    --   },
    --   size = 0.25,
    --   position = "bottom",
    -- },
  },
  controls = {
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = 0.9,
    max_width = 0.5, -- Floats will be treated as percentage of your screen.
    border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end




vim.api.nvim_set_keymap('n', '<leader>d?', '<cmd>lua require("dapui").eval()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>du', '<cmd>lua require("dapui").toggle({ reset = true })<CR>',
  { noremap = true, silent = true })
