-- Map a key with optional options
local function map(mode, keys, action, options)
  if options == nil then
    options = {}
  end
  vim.api.nvim_set_keymap(mode, keys, action, options)
end

map('n', '<C-s>', '<esc>:up<CR><esc>')
map('i', '<C-s>', '<esc>:up<CR><esc>')

-- Save and exit shortcut
map('n', '<leader>x', '<esc>:x<CR><esc>')

-- quit all
map('n', '<leader>q', '<esc>:qa!<CR><esc>')

map('n', '<S-q>', 'q', { noremap = true })
map('n', 'q', '<Nop>', { noremap = true })

map("v", "<C-J>", ":m '>+1<CR>gv=gv")
map("v", "<C-K>", ":m '<-2<CR>gv=gv")

-- Visual linewise up and down by default (and use gj gk to go quicker)
map('n', 'gj', '5j', { noremap = true });
map('n', 'gk', '5k', { noremap = true });
map('v', 'gj', '5j', { noremap = true });
map('v', 'gk', '5k', { noremap = true });

-- When jump to next match also center screen
-- Note: Use :norm! to make it count as one command. (i.e. for i_CTRL-o)
map('n', 'n', ':norm! nzz<CR>', { noremap =true, silent = true })
map('n', 'N', ':norm! nzz<CR>', { noremap =true, silent = true })
map('v', 'n', ':norm! nzz<CR>', { noremap =true, silent = true })
map('v', 'n', ':norm! nzz<CR>', { noremap =true, silent = true })


map('n', '<leader>vr', ':source $MYVIMRC<CR>', { noremap =true, silent = true })
map('n', '<leader>vs', ':vsplit $MYVIMRC<CR>', { noremap =true, silent = true })

map('n', '<leader>g', ':copen<CR>', { noremap =true, silent = true })
map('n', '<leader>n', ':cnext<CR>', { noremap =true, silent = true })
map('n', '<leader>p', ':cprevious<CR>', { noremap =true, silent = true })

-- CTRL-Tab is next tab
map('n', '<C-t>', ':tabnext<CR>', { noremap =true })
-- CTRL-SHIFT-Tab is previous tab
map('n', '<C-T>', ':tabprevious<CR>', { noremap =true })

map('n', '<leader>nt', ':tabe<CR>', { noremap =true })
map('n', '<leader>bn', ':bnext<CR>', { noremap =true })
map('n', '<leader>bp', ':bprevious<CR>', { noremap =true })
map('n', '<leader>bd', ':BufferDelete<CR>', { noremap =true })

-- dont't loose selection while move
map('x', '<' , '<gv', { noremap =true });
map('x', '>' , '>gv', { noremap =true });

-- clean search after esc
map('n', '<ESC>' , ':noh<CR><ESC>', { noremap =true });
map('n', '<leader>p' , '0p');

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- map("n", "<C-k>", "<cmd>cnext<CR>zz")
-- map("n", "<C-j>", "<cmd>cprev<CR>zz")
-- map("n", "<leader>k", "<cmd>lnext<CR>zz")
-- map("n", "<leader>j", "<cmd>lprev<CR>zz")
