local status, autoparis = pcall(require, "nvim-autopairs")
if (not status) then return end

autoparis.setup({
  check_ts = true,
  ts_config = {
    lua = {'string'}, -- it will not add pair on that treesitter node
    javascript = {'template_string'},
    java = false, -- don't check treesitter on java
  }
})


-- vim.g.AutoPairs = {
--   ['('] = ')',
--   ['['] = ']',
--   ['{'] = '}',
--   ["'"] = "'",
--   ['"'] = '"',
--   ['`'] = '`',
-- }
-- vim.g.AutoPairsFlyMode = 0
-- vim.g.AutoPairsShortcutBackInsert= "<C-u>"
-- vim.g.AutoPairsShortcutToggle = ''
-- vim.g.AutoPairsMoveCharacter = ''
