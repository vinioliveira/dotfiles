local kind_icons = {
  Array = "",
  Boolean = "",
  Class = "",
  Color = "",
  Constant = "",
  Constructor = "",
  Enum = "",
  EnumMember = "",
  Event = "",
  Field = "",
  File = "",
  Folder = "",
  Function = "",
  Interface = "",
  Key = "",
  Keyword = "",
  Method = "",
  Module = "",
  Namespace = "",
  Null = "ﳠ",
  Number = "",
  Object = "",
  Operator = "",
  Package = "",
  Property = "",
  Reference = "",
  Snippet = "",
  String = "",
  Struct = "",
  Text = "",
  TypeParameter = "",
  Unit = "",
  Value = "",
  Variable = "",
}

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "SirVer/ultisnips",
    "quangnguyen30192/cmp-nvim-ultisnips",
    "hrsh7th/cmp-nvim-lsp-document-symbol",
    "hrsh7th/cmp-cmdline",
    'github/copilot.vim',
  },
  init = function()
    vim.g.UltiSnipsSnippetDirectories = { '~/.config/nvim/UltiSnips' }
    vim.g.UltiSnipsExpandTrigger = '<Tab>'
    vim.g.UltiSnipsListSnippets = '<C-Tab>'
    vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
    vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
    vim.cmd "autocmd FileType javascriptreact UltiSnipsAddFiletypes javascript"
  end,
  config = function()
    -- See `:help cmp`
    local cmp = require("cmp")

    vim.g.copilot_filetypes = {
      ['dap-repl'] = false,
    }


    vim.cmd([[highlight! default link CmpItemKind CmpItemMenuDefault]])

    local replace_term = function(str)
      return vim.api.nvim_replace_termcodes(str, true, true, true)
    end

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline({
        ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item()),
        ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item()),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm()),
        ["<Tab>"] = cmp.config.disable,
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp_document_symbol" },
      }),
    })

    local duplicates = {
      path = 1,
      nvim_lsp = 0,
      ultisnips = 1,
    }

    local source_names = {
      nvim_lsp = "(LSP)",
      path = "(Path)",
      ultisnips = "(Snippet)",
      copilot = "(Copilot)",
    }

    cmp.setup({
      performance = {
        debounce = 100,
        throttle = 50,
        fetching_timeout = 700,
      },
      completion = {
        keyword_length = 3,
        autocomplete = {
          cmp.TriggerEvent.TextChanged,
        },
      },
      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
        end,
      },
      mapping = {
        ["<c-u>"] = cmp.mapping(function()
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select, count = -4 })
        end, { "i" }),
        ["<C-d>"] = cmp.mapping(function()
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select, count = 4 })
        end, { "i" }),
        ["<C-n>"] = cmp.mapping({
          c = function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              vim.api.nvim_feedkeys(replace_term("<Down>"), "n", true)
            end
          end,
          i = function()
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
              cmp.complete()
            end
          end,
        }),
        -- ['<C-n>'] = cmp.mapping({
        --   c = function()
        --     if cmp.visible() then
        --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --     else
        --       vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        --     end
        --   end,
        --   i = function()
        --     if cmp.visible() then
        --       cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        --       -- elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        --       --   vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        --     else
        --       cmp.complete()
        --       -- fallback()
        --     end
        --   end,
        --   s = function(fallback)
        --     if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        --       vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        --     else
        --       fallback()
        --     end
        --   end
        -- }),
        ["<C-p>"] = cmp.mapping({
          c = function()
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              vim.api.nvim_feedkeys(replace_term("<Up>"), "n", true)
            end
          end,
          i = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            else
              fallback()
            end
          end,
        }),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          -- behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      },

      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, ctx)
            local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
            if kind == "Snippet" and ctx.prev_context.filetype == "java" then
              return false
            end
            if kind == "Text" then
              return false
            end
            return true
          end,
        },
        { name = "ultisnips" },
        { name = "path" },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        max_width = 0,
        -- kind_icons = kind_icons,
        source_names = source_names,
        duplicates = duplicates,
        duplicates_default = 0,
        format = function(entry, vim_item)
          local max_width = 0
          if max_width ~= 0 and #vim_item.abbr > max_width then
            vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. ""
          end

          -- vim_item.kind = kind_icons[vim_item.kind]

          if entry.source.name == "copilot" then
            vim_item.kind = ""
            vim_item.kind_hl_group = "CmpItemKindCopilot"
          end

          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = "ﮧ"
            vim_item.kind_hl_group = "CmpItemKindTabnine"
          end

          if entry.source.name == "crates" then
            vim_item.kind = ""
            vim_item.kind_hl_group = "CmpItemKindCrate"
          end

          if entry.source.name == "lab.quick_data" then
            vim_item.kind = ""
            vim_item.kind_hl_group = "CmpItemKindConstant"
          end

          if entry.source.name == "emoji" then
            vim_item.kind = ""
            vim_item.kind_hl_group = "CmpItemKindEmoji"
          end
          vim_item.menu = source_names[entry.source.name]
          vim_item.dup = duplicates[entry.source.name] or 0
          return vim_item
        end,
      },
    })
  end,
}
