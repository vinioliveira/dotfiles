return {
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    'clearaspect/onehalf',
    lazy = false,
    priority = 1000,
  },
  {
    'rmehri01/onenord.nvim',
    priority = 1000,
    opts = {
      inverse       = {
        match_paren = true,
      },
      styles        = {
        comments = "NONE",
        strings = "NONE",
        keywords = "NONE",
        functions = "NONE",
        variables = "NONE",
        diagnostics = "underline",
      },
      custom_colors = {
        dark = {
          bg = "#1E222A", -- only applies in dark theme
        },
      }
    }
  },
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
    config = function()
      vim.g.nord_contrast = true
      vim.g.nord_borders = false
      vim.g.nord_disable_background = false
      vim.g.nord_italic = false
      vim.g.nord_uniform_diff_background = true
      vim.g.nord_bold = false


      -- Load the colorscheme
      -- require('nord').set()

      -- vim.cmd("colorscheme nord")
    end
  },
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
      vim.g.everforest_background = 'hard'
      vim.g.everforest_transparent_background = true
      vim.g.everforest_better_performance = 1

      -- vim.cmd("colorscheme everforest")
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
    },
    config = function()
      -- vim.cmd([[colorscheme tokyonight-night]])
    end
  },
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

      -- vim.o.background = 'dark'
      -- vim.cmd([[colorscheme gruvbox-material]])
    end
  },
  {
    'Tsuzat/NeoSolarized.nvim',
    opts = {
      transparent = false,
    }
  },
  'maxmx03/solarized.nvim',
}
