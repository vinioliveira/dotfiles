local status, treesitter = pcall(require, "nvim-treesitter.configs");
if (not status) then return end


treesitter.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = false
  },
  indent = {
    enable = false,
  },
  ensure_installed = {
    "markdown",
    "tsx",
    "typescript",
    "json",
    "python",
    "go",
    "javascript",
    "yaml",
    "html",
    "lua",
    "scss",
    "solidity"
  },
  -- autotag = {
  --   enable = true,
  -- }
   context_commentstring = {
    enable = true
  }
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
