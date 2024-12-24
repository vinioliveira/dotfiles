return {
  'rose-pine/neovim',
  'sainnhe/everforest',
  'sainnhe/edge',
  -- install tokyo colorscheme
  {
    'folke/tokyonight.nvim',
    opts = {
      transparent = true,
      styles = {
        keywords = { italic = false },
      }
    }
  },
  -- 'maxmx03/solarized.nvim',
  {
    'rebelot/kanagawa.nvim',
    opts = {
      transparent = true
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
      vim.g.gruvbox_material_transparent_background = 2

      -- vim.g.gruvbox_material_background = 'medium'
      -- vim.g.gruvbox_material_statusline_style = 'default'
      vim.g.gruvbox_material_foreground = 'mix'
      -- vim.g.gruvbox_material_better_performance = 1
    end
  },
  -- {
  --   'Tsuzat/NeoSolarized.nvim',
  --   opts = {
  --     transparent = false,
  --   }
  -- }
}
