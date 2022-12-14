local servers = { "tsserver", "diagnosticls", "sumneko_lua", "tailwindcss", "jsonls", "eslint_d" }
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local status_lspconfig, _ = pcall(require, "lspconfig")
if (not status_lspconfig) then return end

require "plugs.lsp_keybinds"
local lspconfig = require('lspconfig');

-- vim.lsp.set_log_level("DEBUG")
-- tail -f  $HOME/.cache/nvim/lsp.log

local protocol = require('vim.lsp.protocol')
local signature_help_cfg = require('plugs.lsp_signature_helper')

local on_attach = function(client, bufnr)
  -- formatting
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end

  require "lsp_signature".on_attach(signature_help_cfg, bufnr)
  -- protocol.CompletionItemKind = {}
  protocol.SymbolKind = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  }
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local sumneko_opts = require('plugs.lsp_sumneko');
sumneko_opts.on_attach = on_attach
lspconfig.sumneko_lua.setup(sumneko_opts)

lspconfig.tsserver.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
}

local diagnosticls_opts = require('plugs.lsp_diagnosticls');
diagnosticls_opts.on_attach = on_attach
lspconfig.diagnosticls.setup(diagnosticls_opts)

local tailwindcss_opts = require('plugs.lsp_tailwindcss');
tailwindcss_opts.on_attach = on_attach
lspconfig.tailwindcss.setup(tailwindcss_opts)

lspconfig.jsonls.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  filetypes = { "json" },
  init_options = { provideFormatter = true }
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/documentSymbol"] = function(_, result, ctx)
  -- export const Class = 5;
  -- export const Method = 6;
  --export const Function = 12;
  -- const filter only classe kind = 5 then 6 or 12
  local new_results = {}
  for _, v in pairs(result) do
    if (v.kind == 12 or v.kind == 14) then
      v.children = {}
      table.insert(new_results, v)
    end

    if (v.kind == 5) then
      for _, child in pairs(v.children) do
        if (child.kind == 6) then
          child.children = {}
          table.insert(new_results, child);
        end
      end
    end
  end

  local title = 'random title'
  local items = vim.lsp.util.symbols_to_items(new_results, ctx.bufnr)
  vim.fn.setqflist({}, ' ', { title = title, items = items, context = ctx })
  vim.api.nvim_command('botright copen')
end
