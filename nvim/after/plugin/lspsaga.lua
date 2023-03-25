local status, lspsaga = pcall(require, "lspsaga")
if (not status) then return end

lspsaga.setup({
  lightbulb = {
    enable = false,
  },
  symbol_in_winbar = {
    enable = false,
    border = 'single',
    color_mode = false,
    hide_keyword = true
  },
  outline = {
    win_position = 'right',
    win_with = '',
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = '<enter>',
      expand_collapse = 'zx',
      quit = 'q',
    },
  },
  scroll_preview = {
    scroll_down = '<c-d>',
    scroll_up = '<c-u>',
  },
  diagnostic = {
    on_insert = false,
    on_insert_follow = false,
    insert_winblend = 0,
    show_virt_line = true,
    show_code_action = false,
    show_source = false,
    jump_num_shortcut = false,
    max_width = 0.7,
    text_hl_follow = true,
    border_follow = true,
    keys = {
      exec_action = 'o',
      quit = 'q',
      go_action = 'g',
    },
  },
})

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "t*", "<cmd>Lspsaga lsp_finder<CR>", opts)
-- Code action
keymap({ "n", "v" }, "<leader>i", "<cmd>Lspsaga code_action<CR>", opts)
-- Rename
keymap("n", "<leader>r", "<cmd>Lspsaga rename<CR>", opts)

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "tp", "<cmd>Lspsaga peek_definition<CR>", opts)
keymap("n", "td", "<cmd>Lspsaga goto_definition<CR>", opts)
keymap("n", "t?", "<cmd>Lspsaga peek_type_definition<CR>", opts)

-- Diagnostic
keymap("n", "?", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "<leader>cc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
keymap("n", "<leader>al", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts)
keymap("n", "<leader>ap", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "<leader>an", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)

-- Outline
keymap("n", "tf", "<cmd>Lspsaga outline<CR>", opts)

-- Hover Doc
keymap({ "n", "i" }, "<c-k>", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap({ "n" }, "tr", "<cmd>Lspsaga lsp_finder<CR>", opts)

-- -- Only jump to error
-- keymap("n", "[E", function()
--   require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
-- end, opts)
-- keymap("n", "]E", function()
--   require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
-- end, opts)

-- -- Float terminal
-- keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", opts)
-- -- if you want to pass some cli command into a terminal you can do it like this
-- -- open lazygit in lspsaga float terminal
-- keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", opts)
-- -- close floaterm
-- keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], opts)
