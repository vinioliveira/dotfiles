return {
  {
    'rose-pine/neovim',
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        -- variant = '',
        styles = {
          transparency = false,
        }
      })
    end
  },
  {
    'sainnhe/everforest',
    config = function()
      vim.g.everforest_background = 'medium'
      vim.g.everforest_transparent_background = true
    end
  },
  -- 'sainnhe/edge',
  -- install tokyo colorscheme
  {
    'folke/tokyonight.nvim',
    opts = {
      transparent = false,
      styles = {
        keywords = { italic = false },
      }
    }
  },
  'maxmx03/solarized.nvim',
  {
    'rebelot/kanagawa.nvim',
    opts = {
      transparent = false
    }
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_enable_italic = true
      -- vim.g.gruvbox_material_transparent_background = 2
      vim.g.gruvbox_material_enable_bold = true

      vim.g.gruvbox_material_visual = "reverse"
      vim.g.gruvbox_material_ui_contrast = "high"

      vim.g.gruvbox_material_dim_inactive_windows = 1
      vim.g.gruvbox_material_background = 'hard'
      -- vim.g.gruvbox_material_statusline_style = 'default'
      vim.g.gruvbox_material_foreground = 'material'
      -- vim.g.gruvbox_material_better_performance = 1
      --
      vim.g.gruvbox_material_float_style = 'dim'
      --
      vim.g.gruvbox_material_colors_override = {
        ['bg0'] = { '#141617', '232' },
        ['bg_dim'] = { '#1d2021', '234' },
      }
    end
  },
  {
    'Tsuzat/NeoSolarized.nvim',
    opts = {
      transparent = false,
    }
  }
}
