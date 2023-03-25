-- highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
-- highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000


-- vim.api.nvim_command([[ hi LineNr guifg=#d3b987 ctermfg=180 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE ]])
-- vim.api.nvim_command([[ hi Visual guifg=NONE ctermfg=NONE guibg=#-8c4b4b ctermbg=0 gui=NONE cterm=NONE ]])




vim.g.nord_uniform_status_lines = 0
vim.g.nord_cursor_line_number_background = 0
vim.g.nord_uniform_diff_background = 0
vim.g.nord_bold_vertical_split_line = 1
vim.g.nord_italic = 0
vim.g.nord_italic_comments = 0

-- vim.api.nvim_command([[colorscheme nightfox]])


-- vim.api.nvim_command([[ hi Normal guibg=NONE ctermbg=NONE ]])



-- hi Visual guibg=#535760 ctermbg=0
-- if below gets too light can use the one above
-- hi Visual guibg=#5c616b ctermbg=0
-- vim.highlight.create('Visual', {ctermbg=0, guibg='#5c616b'}, false)
vim.api.nvim_set_hl(0, 'Visual', {ctermbg=0, bg='#5c616b'})
vim.api.nvim_set_hl(0, 'Comment', {ctermbg=14, fg='#7b88a1'})
vim.api.nvim_set_hl(0, 'Folded', {ctermbg=14, fg='#7b8eb3'})

-- augroup nord-theme-overrides
--   autocmd!
--   " Use 'nord7' as foreground color for Vim comment titles.
--   autocmd ColorScheme nord highlight vimCommentTitle ctermfg=14 guifg=#8FBCBB
-- augroup END
