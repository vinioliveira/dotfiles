return {
  flags = { debounce_text_changes = 150 },
  -- capabilities = capabilities,
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
