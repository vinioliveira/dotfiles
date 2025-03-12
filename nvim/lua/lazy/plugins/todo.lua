return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- @MVS: add your configuration here
    -- MVS add your configuration here
    -- your configuration comes here
    -- MVS:
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    --
    -- @TODO: Implement this feature`
    -- @FIXME: Fix this bug`
    -- @NOTE: Remember to update documentation */`
    keywords = {
      MVS = { icon = " ", color = "info" },
    },
    highlight = {
      pattern = { [[.*<(KEYWORDS)\s*:]], [[.*\@(KEYWORDS)\s*]] }, -- pattern used for highlightng (vim regex)
    },

  }

}
