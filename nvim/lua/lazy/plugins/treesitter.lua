return {
  'nvim-treesitter/nvim-treesitter',
  build = ":TSUpdate",
  config = function()
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

    require "nvim-treesitter.configs".setup {
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
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,
      -- List of parsers to ignore installing (or "all")
      ignore_install = { "all" },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = true,
      ensure_installed = {
        "markdown",
        "markdown_inline",
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
        -- "solidity"
      },
      skip_ts_context_commentstring_module = true,
      -- autotag = {
      --   enable = true,
      -- }
    }
  end
}
