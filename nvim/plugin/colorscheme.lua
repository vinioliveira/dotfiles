-- highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
-- highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000


-- vim.api.nvim_command([[ hi LineNr guifg=#d3b987 ctermfg=180 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE ]])
-- vim.api.nvim_command([[ hi Visual guifg=NONE ctermfg=NONE guibg=#-8c4b4b ctermbg=0 gui=NONE cterm=NONE ]])

-- let g:nord_cursor_line_number_background = 1
-- let g:gruvbox_contrast_dark='medium'
-- let g:gruvbox_contrast_light='medium' " soft medium hard



vim.g.nord_uniform_status_lines = 0
vim.g.nord_cursor_line_number_background = 0
vim.g.nord_uniform_diff_background = 0
vim.g.nord_bold_vertical_split_line = 1
vim.g.nord_italic = 0
vim.g.nord_italic_comments = 0

vim.api.nvim_command([[colorscheme nord]])


vim.api.nvim_command([[ hi Normal guibg=NONE ctermbg=NONE ]])



-- hi Visual guibg=#535760 ctermbg=0
-- if below gets light can use the one above
-- hi Visual guibg=#5c616b ctermbg=0
vim.highlight.create('Visual', {ctermbg=0, guibg='#5c616b'}, false)
