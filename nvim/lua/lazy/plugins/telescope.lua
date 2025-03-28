local function parseSearchString(str)
  -- Remove everything after --glob if it exists
  local search = str:match("^(.-)%s-%-%-glob") or str

  -- Trim trailing spaces while preserving intentional spaces
  search = search:match("^(.-)%s*$")

  -- Case 1: Matches strings with escaped quotes like "\"term\""
  local escaped_quotes = search:match('^%s*"\\+"([^"]+)\\+""%s*$')
  if escaped_quotes then
    return '"' .. escaped_quotes .. '"'
  end

  -- Case 2: Matches strings with single quotes containing double quotes like '"term"'
  local single_quoted = search:match("^%s*'([^']+)'%s*$")
  if single_quoted then
    return single_quoted
  end

  -- Case 3: Matches strings with double quotes like "term"
  local double_quoted = search:match('^%s*"([^"]+)"%s*$')
  if double_quoted then
    return double_quoted
  end

  -- Case 4: If no special quotes, return the string as is
  return search
end

local function getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    'nvim-telescope/telescope-ui-select.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      "nvim-telescope/telescope-fzf-native.nvim",

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = "make",

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
  },
  config = function()
    local actions = require("telescope.actions")
    local resolve = require("telescope.config.resolve")
    local p_window = require("telescope.pickers.window")

    local calc_tabline = function(max_lines)
      local tbln = (vim.o.showtabline == 2) or
          (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
      if tbln then
        max_lines = max_lines - 1
      end
      return max_lines, tbln
    end

    local get_border_size = function(opts)
      if opts.window.border == false then
        return 0
      end

      return 1
    end

    local calc_size_and_spacing = function(cur_size, max_size, bs, w_num, b_num, s_num)
      local spacing = s_num * (1 - bs) + b_num * bs
      cur_size = math.min(cur_size, max_size)
      cur_size = math.max(cur_size, w_num + spacing)
      return cur_size, spacing
    end
    -- Custom layout strategy
    require("telescope.pickers.layout_strategies").fzf_upper_layout = function(
        self,
        max_columns,
        max_lines,
        layout_config
    )
      local initial_options = p_window.get_initial_window_options(self)
      local results = initial_options.results
      local prompt = initial_options.prompt
      local preview = initial_options.preview
      layout_config = layout_config or self.layout_config.bottom_pane

      local tbln
      max_lines, tbln = calc_tabline(max_lines)

      local height = vim.F.if_nil(
        resolve.resolve_height(layout_config.height)(self, max_columns, max_lines), 25)
      if type(layout_config.height) == "table" and type(layout_config.height.padding) == "number" then
        -- Since bottom_pane only has padding at the top, we only need half as much padding in total
        -- This doesn't match the vim help for `resolve.resolve_height`, but it matches expectations
        height = math.floor((max_lines + height) / 2)
      end

      local bs = get_border_size(self)

      -- Cap over/undersized height
      height, _ = calc_size_and_spacing(height, max_lines, bs, 2, 3, 0)

      -- Height
      prompt.height = 1
      results.height = height - prompt.height - (2 * bs)
      preview.height = results.height - bs

      -- Width
      prompt.width = max_columns - 2 * bs
      if self.previewer and max_columns >= layout_config.preview_cutoff then
        -- Cap over/undersized width (with preview)
        local width, w_space = calc_size_and_spacing(max_columns, max_columns, bs, 2, 4, 0)

        preview.width =
            resolve.resolve_width(vim.F.if_nil(layout_config.preview_width, 0.5))(self, width,
              max_lines)
        results.width = width - preview.width - w_space
      else
        results.width = prompt.width
        preview.width = 0
      end

      results.line = 1 + bs
      prompt.line = results.height + 1 + bs + 1
      -- results.line = prompt.line + 1
      preview.line = results.line
      if results.border == true then
        results.border = { 1, 1, 0, 1 }
      end
      if type(results.title) == "string" then
        results.title = { { pos = "S", text = results.title } }
      end
      if type(preview.title) == "string" then
        preview.title = { { pos = "S", text = preview.title } }
      end
      -- Col
      prompt.col = 0 -- centered
      if layout_config.mirror and preview.width > 0 then
        results.col = preview.width + (3 * bs) + 1
        preview.col = bs + 1
      else
        results.col = bs + 1
        preview.col = results.width + (3 * bs) + 1
      end

      if tbln then
        prompt.line = prompt.line + 1
        results.line = results.line + 1
        preview.line = preview.line + 1
      end

      return {
        preview = self.previewer and preview.width > 0 and preview,
        prompt = prompt,
        results = results,
      }
    end

    require("telescope").setup({
      defaults = {
        layout_strategy = "fzf_upper_layout",
        layout_config = {
          bottom_pane = {
            height = 0.4,
          },
        },
        -- vimgrep_arguments = {
        --   'rg',
        --   '--color=never',
        --   '--no-heading',
        --   '--with-filename',
        --   '--line-number',
        --   '--column',
        --   '--smart-case',
        --   '-u' -- thats the new thing
        -- },
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            -- ["<esc>"] = require('telescope.actions').close,
            -- ["q"] = require('telescope.actions').close,
            ["<c-a>"] = actions.toggle_all,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
            ["<c-o>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        path_display = {
          "truncate",
        },
      },
      -- lua require('telescope.builtin').lsp_document_symbols({ symbols = 'function' })
      pickers = {
        command_history = {
          theme = "dropdown",
        },
        search_history = {
          theme = "dropdown",
        },
        buffers = {
          sort_lastused = true,
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            i = {
              ["<c-d>"] = actions.delete_buffer,
            },
          },
        },
        lsp_document_symbols = {
          theme = "dropdown",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown()
        },
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
    })

    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<c-p>", function() builtin.find_files() end, {})
    vim.keymap.set("n", "<c-b>", function() builtin.buffers() end, {})
    vim.keymap.set("n", "<c-g>", function() builtin.git_status() end, {})
    vim.keymap.set("n", "<leader>sa", function() builtin.live_grep() end, {})
    vim.keymap.set("n", "<leader>sc", function() builtin.command_history({ theme = "dropdown" }) end, {})
    vim.keymap.set("n", "<leader>ss", function() builtin.search_history() end, {})
    vim.keymap.set("n", "<leader>sg", function() builtin.git_commits() end, {})
    vim.keymap.set("n", "<leader>ff", function() builtin.lsp_document_symbols({ symbols = "method" }) end, {})
    vim.keymap.set("n", "<leader>fa", function() builtin.lsp_document_symbols() end, {})


    --Grep string for selection and under the cursor
    vim.keymap.set("n", "<leader>*", ":Telescope grep_string search=<CR>")

    vim.api.nvim_create_user_command("Quickfix", function()
      require('telescope.builtin').quickfix()
    end, {})

    vim.api.nvim_create_user_command("Maps", function()
      require('telescope.builtin').keymaps()
    end, {})

    vim.api.nvim_create_user_command("Colorscheme", function()
      require('telescope.builtin').colorscheme()
    end, {})

    vim.keymap.set("v", "<leader>*", function()
      local text = getVisualSelection()
      require('telescope.builtin').grep_string({ search = text })
    end, {})


    vim.api.nvim_create_user_command("Ag", function(params)
      local builtin = require('telescope.builtin')
      local args = params.args
      local search = parseSearchString(args)

      local glob_pattern = nil
      local glob_index = string.find(args, " --glob ")
      if (glob_index) then
        glob_pattern = string.sub(args, glob_index + 6)
      end

      if search == nil then
        search = glob_index and string.sub(args, 1, glob_index - 2) or args
      end

      local aditional_args = {}

      if glob_pattern then
        table.insert(aditional_args, "--glob")
        table.insert(aditional_args, glob_pattern)

        --ignore hidden files
        table.insert(aditional_args, "--glob")
        table.insert(aditional_args, "!.*")
      end


      builtin.grep_string({
        search = search,
        additional_args = aditional_args
      })
    end, { nargs = '+' })
  end,
}
