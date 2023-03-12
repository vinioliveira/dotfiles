local status, cmp = pcall(require, "cmp")
if (not status) then return end

-- local lspkind = require("lspkind")

vim.o.completeopt = "menuone,noinsert,noselect"


local duplicates = {
  buffer = 1,
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

local lspkind_comparator = function(conf)
  local lsp_types = require('cmp.types').lsp
  return function(entry1, entry2)
    if entry1.source.name ~= 'nvim_lsp' then
      if entry2.source.name == 'nvim_lsp' then
        return false
      else
        return nil
      end
    end
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0
    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local label_comparator = function(entry1, entry2)
  return entry1.completion_item.label < entry2.completion_item.label
end


cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-n>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          cmp.complete()
          -- fallback()
        end
      end,
      s = function(fallback)
        if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
          vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), 'm', true)
        else
          fallback()
        end
      end
    }),
    ['<C-p>'] = cmp.mapping({
      c = function()
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
        end
      end,
      i = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
          fallback()
        end
      end
    }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<C-space>'] = cmp.mapping(cmp.mapping.complete()),
    ['<CR>'] = cmp.mapping.confirm({
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = true
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
    { name = 'ultisnips' },
    { name = 'path' },
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    max_width = 0,
    kind_icons = kind_icons,
    source_names = source_names,
    duplicates = duplicates,
    duplicates_default = 0,
    format = function(entry, vim_item)
      local max_width = 0
      if max_width ~= 0 and #vim_item.abbr > max_width then
        vim_item.abbr = string.sub(vim_item.abbr, 1, max_width - 1) .. ""
      end

      vim_item.kind = kind_icons[vim_item.kind]

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
      vim_item.dup = duplicates[entry.source.name]
      or 0
      return vim_item
    end,
  }
})

vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]
