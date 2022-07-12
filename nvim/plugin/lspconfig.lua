local status_lspconfig, _ = pcall(require, "lspconfig")
if (not status_lspconfig) then return end

local lspconfig = require('lspconfig');
local status_lsp_install, lsp_installer = pcall(require, "nvim-lsp-installer")
if (not status_lsp_install) then return end


-- vim.lsp.set_log_level("debug")


-- Always display sign column
vim.o.signcolumn = "yes"

local servers = { "tsserver", "diagnosticls", "sumneko_lua", "tailwindcss", "jsonls" }

lsp_installer.setup({
  ensure_installed = servers, -- ensure these servers are always installed
  automatic_installation = true
})

local protocol = require('vim.lsp.protocol')

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local mopts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'td', '<Cmd>lua vim.lsp.buf.definition()<CR>', mopts)
  buf_set_keymap('n', 'ti', '<cmd>lua vim.lsp.buf.implementation()<CR>', mopts)
  buf_set_keymap('n', 'tr', '<cmd>lua vim.lsp.buf.references()<CR>', mopts)
  buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.hover()<CR>', mopts)
  buf_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mopts)

  -- utils
  buf_set_keymap('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', mopts)
  buf_set_keymap('n', '<leader>i', '<Cmd>lua vim.lsp.buf.code_action()<CR>', mopts)
  buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', mopts)

  -- diagnostic
  buf_set_keymap('n', '?', '<cmd>lua vim.diagnostic.open_float()<CR>', mopts)
  buf_set_keymap('n', '<leader>ap', '<cmd>lua vim.diagnostic.goto_prev()<CR>', mopts)
  buf_set_keymap('n', '<leader>an', '<cmd>lua vim.diagnostic.goto_next()<CR>', mopts)

  -- formatting
  if client.name == 'tsserver' then
    -- client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
    client.resolved_capabilities.document_formatting = false
  end

  --   if client.name == 'diagnosticls' and client.supports_method('textDocument/formatting') then
  --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
  --         vim.lsp.buf.formatting_sync()
  --       end,
  --     })
  --   end

  --protocol.SymbolKind = { }
  protocol.CompletionItemKind = {
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
  filetypes = { 'lua' },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
}

lspconfig.diagnosticls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css', 'less', 'scss' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', "--format", "json" },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      prettier = {
        command = './node_modules/.bin/prettier',
        rootPatterns = { '.prettierrc' },
        args = { '--stdin', '--stdin-filepath', '%filename' },
      }
    },
    formatFiletypes = {
      ["*"] = 'prettier',
      -- css = 'prettier',
      -- javascript = 'prettier',
      -- javascriptreact = 'prettier',
      -- json = 'prettier',
      -- scss = 'prettier',
      -- less = 'prettier',
      -- typescript = 'prettier',
      -- typescriptreact = 'prettier',
    }
  }
}

lspconfig.tailwindcss.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
  filetypes = { "typescriptreact", "typescript.tsx", "css" },
  tailwindCSS = {
    classAttributes = { "class", "className" },
    lint = {
      cssConflict = "warning",
      invalidApply = "error",
      invalidConfigPath = "error",
      invalidScreen = "error",
      invalidTailwindDirective = "error",
      invalidVariant = "error",
      recommendedVariantOrder = "warning"
    },
    validate = true
  }
}
--Enable (broadcasting) snippet capability for completion
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.jsonls.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 150 },
  capabilities = capabilities,
  filetypes = { "json" },
  init_options = {
    provideFormatter = true
  }
}

-- lspconfig.eslint.setup {
--   on_attach = on_attach,
--   flags = { debounce_text_changes = 150 },
--   capabilities = capabilities,
--   filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss' },
--   settings = {
--     run = "onType"
--   },
-- }

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
-- vim.cmd [[
--   highlight! DiagnosticVirtualTextError guibg=none guifg=#EEDD00 gui=none
-- DiagnosticVirtualTextWarn
-- DiagnosticVirtualTextInfo
-- DiagnosticVirtualTextHint
-- ]]
