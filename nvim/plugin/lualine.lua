local status, lualine = pcall(require, "lualine")

if (not status) then return end

local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
  return function(str)
    local win_width = vim.fn.winwidth(0)
    if hide_width and win_width < hide_width then return ''
    elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
      return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
    end
    return str
  end
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    component_separators = '',
    disabled_filetypes = {},
    section_separators = { left = '', right = '' },
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'branch', fmt = function(str) return str:sub(1, 10) .. (str:len() > 10 and "..." or "") end },
      'diagnostics',
    },
    lualine_c = { { 'filename', path = 1, shorting_target = 30 } },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}