return {
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
