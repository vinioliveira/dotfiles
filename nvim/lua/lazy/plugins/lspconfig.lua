local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local servers = {
  gopls = {
    flags = { debounce_text_changes = 300 },
    filetypes = { "go" },
    capabilities = {
      documentFormattingProvider = false,
    },
  },
  tsserver = {
    flags = { debounce_text_changes = 300 },
    single_file_support = false,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    capabilities = {
      documentFormattingProvider = false,
    },
  },
  tailwindcss = {
    flags = { debounce_text_changes = 150 },
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
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
  lua_ls = {
    flags = { debounce_text_changes = 150 },
    filetypes = { "lua" },
    capabilities = {
      documentFormattingProvider = false,
    },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
          disable = { "missing-fields" }
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    },
  },
  terraformls = {
    flags = { debounce_text_changes = 150 },
    filetypes = { "terraform", "terraform-vars" },
    capabilities = {
      documentFormattingProvider = false,
    },
    settings = {}
  },
  kotlin_language_server = {
    flags = { debounce_text_changes = 150 },
    filetypes = { "kotlin" },
  },
  java_language_server = {
    flags = { debounce_text_changes = 150 },
    filetypes = { "java" },
  },
}

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPost",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { 'rmagatti/goto-preview', keys = "tp" },
    { "j-hui/fidget.nvim",     opts = {} },
  },
  config = function()
    -- vim.lsp.set_log_level('debug')
    -- tail -f  $HOME/.local/state/nvim/lsp.log
    -- v $HOME/.local/share/nvim/lsp_servers/diagnosticls/node_modules/diagnostic-languageserver/lib/handles/handleDiagnostic.jsj


    require('goto-preview').setup();

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    require("mason").setup({
      -- log_level = vim.log.levels.DEBUG
    })
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    require("mason-lspconfig").setup({
      ensure_installed = servers,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities,
            server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })

    for type, icon in pairs({
      Error = " ",
      Warn = " ",
      Hint = "", -- cspell: make it very noisy
      Info = " ",
    }) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.diagnostic.config({
      virtual_text = false,
    })


    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        -- we don't want to attach to non-filetype buffers
        if event.file == '' then
          return
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)

        local map = function(mode, keys, func)
          vim.keymap.set(mode, keys, func,
            { buffer = event.buf, noremap = true, silent = true })
        end

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        map("n", "tD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
        map("n", "td", "<cmd>lua vim.lsp.buf.definition()<CR>")
        map("n", "ti", "<cmd>lua vim.lsp.buf.implementation()<CR>")
        map("n", "tr", "<cmd>lua vim.lsp.buf.references()<CR>")
        map("i", "<c-j>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
        map("n", "<c-k>", "<cmd>lua vim.lsp.buf.hover()<CR>")
        map("i", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

        -- utils
        -- map({ "n", "v" }, "<leader>f", "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>")
        -- vim.keymap.set({ 'n', 'v' }, '<leader>f', '<Cmd>lua vim.lsp.buf.format({ async = true })<CR>', mopts)
        -- saga is handle it
        -- vim.keymap.set('n', '<leader>r', '<Cmd>lua vim.lsp.buf.rename()<CR>', mopts)
        map("n", "<leader>r", '<Cmd>lua require("plugs/lsp_extand").rename()<CR>')

        -- vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua Rename.rename()<CR>, {silent = true})
        map("n", "<leader>i", "<Cmd>lua vim.lsp.buf.code_action()<CR>")
        map("n", "tf", " <cmd> lua vim.lsp.buf.document_symbol()<CR>")

        -- saga is handle it
        -- diagnostic
        map("n", "?", "<cmd>lua vim.diagnostic.open_float()<CR>")
        map("n", "<leader>ap",
          "<cmd>lua vim.diagnostic.goto_prev({ severity = { min = vim.diagnostic.severity.WARN }})<CR>")
        map("n", "<leader>an",
          "<cmd>lua vim.diagnostic.goto_next({ severity = { min = vim.diagnostic.severity.WARN }})<CR>")
        map("n", "<leader>al", "<cmd>lua vim.diagnostic.setloclist()<CR>")

        map("n", "tp", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
        map("n", "ti", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")

        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })
  end,
}
