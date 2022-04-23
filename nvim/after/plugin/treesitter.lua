local status, treesitter = pcall(require, "nvim-treesitter.configs");
if (not status) then return end


treesitter.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  incremental_selection = {
    enable = false
  },
  additional_vim_regex_highlighting = false,
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "json",
    "python",
    "go",
    "javascript",
    "yaml",
    "html",
    "lua",
    "scss"
  },
  -- autotag = {
  --   enable = true,
  -- }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
