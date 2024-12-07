return {
  "hoob3rt/lualine.nvim",
  config = function()
    local lualine = require("lualine")

    local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
      return function(str)
        local win_width = vim.fn.winwidth(0)
        if hide_width and win_width < hide_width then
          return ''
        elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
          return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
        end
        return str
      end
    end

    local function hello()
      if (vim.g.test_all_status == -1) then
        return ''
      elseif (vim.g.test_all_status == 1) then
        return ''
      elseif (vim.g.test_all_status == 0) then
        return ''
      end

      return ''
    end

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
        component_separators = '',
        disabled_filetypes = {},
        section_separators = { left = '', right = '' },
        always_divide_middle = false,
        globalstatus = false,
      },
      sections = {
        lualine_a = { { 'mode', fmt = function(res) return res:sub(1, 1) end } },
        lualine_b = {
          -- split branch name by slash and grab the last bit
          {
            'branch',
            fmt = function(str)
              -- split branch name by slash and grab the last bit
              local branch = str:match('([^/]+)$')
              -- return branch:sub(1, 15) .. (str:len() > 15 and "..." or "")
              return branch
            end,
          },
        },
        lualine_c = { { 'filename', path = 1, shorting_target = 30 } },
        lualine_x = {
          'encoding',
          'filetype',
          { 'diagnostics', sources = { 'nvim_lsp' } },
        },
        lualine_y = {
          'progress',
        },
        lualine_z = { 'location' }
      },
      tabline = {},
      inactive_sections = {
        lualine_a = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {}
    }
  end
}
