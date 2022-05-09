local status_lspconfig, _ = pcall(require, "lspconfig")
if (not status_lspconfig) then return end

local lspconfig = require('lspconfig');
local status_lsp_install, lsp_installer = pcall(require, "nvim-lsp-installer")
if (not status_lsp_install) then return end


-- vim.lsp.set_log_level("trace")


-- Always display sign column
vim.o.signcolumn = "yes"

local servers = { "tsserver", "diagnosticls", "sumneko_lua" }

lsp_installer.setup({
  ensure_installed = servers, -- ensure these servers are always installed
  automatic_installation = true
})

local protocol = require('vim.lsp.protocol')

local mopts = { noremap = true, silent = true }
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', mopts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', mopts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', mopts)
  buf_set_keymap('i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', mopts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', mopts)
  buf_set_keymap('n', 'sf', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', mopts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', mopts)

  -- utils
  buf_set_keymap('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', mopts)
  buf_set_keymap('n', '<space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', mopts)
  buf_set_keymap('n', '<leader>f', '<Cmd>lua vim.lsp.buf.document_symbol<CR>', mopts)


  -- diagnostic
  buf_set_keymap('n', '?', '<cmd>lua vim.diagnostic.open_float()<CR>', mopts)
  buf_set_keymap('n', '<leader>ap', '<cmd>lua vim.diagnostic.goto_prev()<CR>', mopts)
  buf_set_keymap('n', '<leader>an', '<cmd>lua vim.diagnostic.goto_next()<CR>', mopts)
  buf_set_keymap('n', '<leader>a?', '<cmd>lua vim.diagnostic.setloclist()<CR>', mopts)

  -- formatting
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = true
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

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

-- for _, lsp in pairs(servers) do
--   require('lspconfig')[lsp].setup {
--     on_attach = on_attach,
--     flags = {
--       -- This will be the default in neovim 0.7+
--       debounce_text_changes = 150,
--     }
--   }
-- end


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
  flags = { debounce_text_changes = 150 },
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss' },
  init_options = {
    linters = {
      eslint = {
        command = './node_modules/.bin/eslint',
        rootPatterns = { '.git' },
        debounce = 600,
        args = { '--stdin', '--stdin-filename', '%filepath', "--format", "json", "--debug" },
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
      eslint = {
        command = './node_modules/.bin/eslint',
        rootPatterns = { '.git' },
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
      },
      prettier = {
        command = './node_modules/.bin/prettier',
        rootPatterns = { '.prettierrc' },
        args = { '--stdin', '--stdin-filepath', '%filename' },
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettier',
      javascriptreact = 'prettier',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'prettier',
      typescriptreact = 'prettier',
    }
  }
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

-- Mappings
