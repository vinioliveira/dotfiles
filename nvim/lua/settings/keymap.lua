-- Map a key with optional options
local function map(mode, keys, action, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_set_keymap(mode, keys, action, options)
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("n", "<C-s>", ":up<CR><esc>")
map("i", "<C-s>", "<esc>:up<CR><esc>")

-- Save and exit shortcut
map("n", "<leader>x", "<esc>:x<CR><esc>")

-- quit all
map("n", "<leader>q", "<esc>:qa!<CR><esc>")

map("n", "<S-q>", "q", { noremap = true })
map("n", "q", "<Nop>", { noremap = true })

map("v", "<C-j>", ":m '>+1<CR>gv=gv")
map("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- Visual linewise up and down by default (and use gj gk to go quicker)
map("n", "gj", "5j", { noremap = true })
map("n", "gk", "5k", { noremap = true })
map("v", "gj", "5j", { noremap = true })
map("v", "gk", "5k", { noremap = true })

-- When jump to next match also center screen
-- Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
map("n", "n", ":norm! nzz<CR>", { noremap = true, silent = true })
map("n", "N", ":norm! nzz<CR>", { noremap = true, silent = true })
map("v", "n", ":norm! nzz<CR>", { noremap = true, silent = true })
map("v", "n", ":norm! nzz<CR>", { noremap = true, silent = true })

map("n", "<leader>vr", ":source $MYVIMRC<CR>", { noremap = true, silent = true })
map("n", "<leader>vs", ":vsplit $MYVIMRC<CR>", { noremap = true, silent = true })

map("n", "<leader>gg", ":Copen<CR> | :cbo<CR>", { noremap = true, silent = true })
map("n", "<leader>gt", ":ToggleQuickFix<CR>", { noremap = true, silent = true })
map("n", "<leader>gn", ":cnext<CR>", { noremap = true, silent = true })
map("n", "<leader>gp", ":cprevious<CR>", { noremap = true, silent = true })

-- CTRL-Tab is next tab
map("n", "<C-T>", ":tabnext<CR>", { noremap = true })
-- CTRL-SHIFT-Tab is previous tab
map("n", "<C-S-T>", ":tabprevious<CR>", { noremap = true })

map("n", "<leader>bn", ":bnext<CR>", { noremap = true })
map("n", "<leader>bp", ":bprevious<CR>", { noremap = true })
map("n", "<leader>nt", ":tabe<CR>", { noremap = true })
map("n", "<leader>bd", ":BufferDelete<CR>", { noremap = true })

map("n", "<C-e>", "<C-e>k", { noremap = true })

-- dont't loose selection while move
map("x", "<", "<gv", { noremap = true })
map("x", ">", ">gv", { noremap = true })

-- clean search after esc
map("n", "<ESC>", ":noh<CR><ESC>", { noremap = true })
map("n", "<leader>p", "0p")

-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

map("n", "<C-e>", "j<C-E>", { noremap = true, silent = true })
map("n", "<C-y>", "k<C-y>", { noremap = true, silent = true })


-- map("n", "n", "nzzzv")
-- map("n", "N", "Nzzzv")

map("n", "<leader>nn", ":lua require('plugs/notes').open_win_notes()<CR>")
map("n", "<leader>ng", ":lua require('plugs/notes').open_win_notes(true)<CR>")

map("n", "<leader>vl", ":lua require('plugs/notes').open_win_notes(true)<CR>")

-- map("n", "<C-k>", "<cmd>cnext<CR>zz")
-- map("n", "<C-j>", "<cmd>cprev<CR>zz")
-- map("n", "<leader>k", "<cmd>lnext<CR>zz")
-- map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- nnoremap <leader>z za
-- vim.api.nvim_set_keymap('n', '<leader>z', 'za', { noremap = true })
