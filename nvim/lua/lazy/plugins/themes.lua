return {
  'rose-pine/neovim',
  'sainnhe/everforest',
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
  'maxmx03/solarized.nvim',
  {
    'Tsuzat/NeoSolarized.nvim',
    opts = {
      transparent = false,
    }
  },
  -- {
  --   'maxmx03/solarized.nvim'
  --   lazy = false,
  --   config = function()
  --     vim.cmd.colorscheme 'solarized'
  --   end
  -- },
  -- {
  --   -- 'maxmx03/solarized.nvim',
  --   "craftzdog/solarized-osaka.nvim",
  --   opts = {
  --     transparent = true,
  --     style = "storm",
  --   }
  -- }
}
