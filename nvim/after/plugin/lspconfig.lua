local servers = {
  "tsserver",
  "diagnosticls",
  "lua_ls",
  "tailwindcss",
  "jsonls",
  "pyright",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
})

local status_lspconfig, lspconfig = pcall(require, "lspconfig")
if (not status_lspconfig) then return end

-- local bind_keys = require "plugs.lsp_keybinds"
-- require "plugs.lsp_keybinds"

-- vim.lsp.set_log_level('debug')
-- tail -f  $HOME/.cache/nvim/lsp.log
-- v $HOME/.local/share/nvim/lsp_servers/diagnosticls/node_modules/diagnostic-languageserver/lib/handles/handleDiagnostic.jsj
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    filter = function(client)
      -- apply whatever logic you want (in this example, we'll only use null-ls)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  })
end

local on_attach = function(client, bufnr)
  -- formating preferences
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        lsp_formatting(bufnr)
      end,
    })
  end
  -- formatting
  if client.name == 'tsserver' then
    client.server_capabilities.documentFormattingProvider = false
  end

  if (client.name == 'lua_ls') then
    vim.api.nvim_create_augroup("lsp_format_on_save", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = "lsp_format_on_save",
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end

  -- require "lsp_signature".on_attach(require('plugs.lsp_signature_helper'), bufnr)
  require("plugs.lsp_keybinds")(bufnr)
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local sumneko_opts = require('plugs.lsp_sumneko');
sumneko_opts.on_attach = on_attach
lspconfig.lua_ls.setup(sumneko_opts)


lspconfig.tsserver.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 300 },
  capabilities = capabilities,
  single_file_support = false,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
}

local tailwindcss_opts = require('plugs.lsp_tailwindcss');
tailwindcss_opts.on_attach = on_attach
lspconfig.tailwindcss.setup(tailwindcss_opts)

lspconfig.jsonls.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  filetypes = { "json" },
  init_options = { provideFormatter = true }
}

lspconfig.pyright.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  filetypes = { "python" },
  init_options = { provideFormatter = true }
}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = true
})

-- icon
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = true,
--     virtual_text = {
--       spacing = 4,
--       prefix = ''
--     }
--   }
-- )

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})


--vim.lsp.handlers["textDocument/documentSymbol"] = function(_, result, ctx)
--  -- export const Class = 5;
--  -- export const Method = 6;
--  --export const Function = 12;
--  -- const filter only classe kind = 5 then 6 or 12
--  local new_results = {}
--  for _, v in pairs(result) do
--    if (v.kind == 12 or v.kind == 14) then
--      v.children = {}
--      table.insert(new_results, v)
--    end

--    if (v.kind == 5) then
--      for _, child in pairs(v.children) do
--        if (child.kind == 6) then
--          child.children = {}
--          table.insert(new_results, child);
--        end
--      end
--    end
--  end

--  local title = 'random title'
--  local items = vim.lsp.util.symbols_to_items(new_results, ctx.bufnr)
--  vim.fn.setqflist({}, ' ', { title = title, items = items, context = ctx })
--  vim.api.nvim_command('botright copen')
--end
