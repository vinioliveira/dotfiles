return {
  'tomasky/bookmarks.nvim',
  event = "VimEnter",
  opts = {
    sign_priority = 8, --set bookmark sign priority to cover other sign
    save_file = vim.fn.expand(vim.fn.getcwd() .. "/.vim-bookmarks"), -- bookmarks save file path
    keywords = {
      ["TODO"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
      ["WARN"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
      ["FIX"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
      ["NOTE"] = " ", -- mark annotation startswith @n ,signs this icon as `Note`
    },
    signs = {
      add = { hl = "BookMarksAdd", text = "󰁕", numhl = "BookMarksAddNr", linehl = "BookMarksAddLn" },
      ann = { hl = "BookMarksAnn", text = "♥", numhl = "BookMarksAnnNr", linehl = "BookMarksAnnLn" },
    },
    on_attach = function(bufnr)
      local bm = require "bookmarks"
      local map = vim.keymap.set
      map("n", "mm", bm.bookmark_toggle)     -- add or remove bookmark at current line
      map("n", "mi", bm.bookmark_ann)        -- add or edit mark annotation at current line
      map("n", "mc", bm.bookmark_clean)      -- clean all marks in local buffer
      map("n", "mn", bm.bookmark_next)       -- jump to next mark in local buffer
      map("n", "mp", bm.bookmark_prev)       -- jump to previous mark in local buffer
      map("n", "ml", bm.bookmark_list)       -- show marked file list in quickfix window
      map("n", "mcc", bm.bookmark_clear_all) -- clean all marks in local buffer
    end
  },
}
