return {
  'rose-pine/neovim',
  "tpope/vim-repeat",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-dispatch",
  "JoosepAlviste/nvim-ts-context-commentstring",
  'lukas-reineke/indent-blankline.nvim',
  'AndrewRadev/splitjoin.vim',
  'vim-scripts/IndexedSearch',
  'norcalli/nvim-colorizer.lua',
  { 'chrisbra/nrrwrgn', cmd = { "NrrwrgnDo" } },
  {
    "tpope/vim-surround",
    init = function()
      vim.keymap.set("v", "'", "S'", { remap = true })
      vim.keymap.set("v", '"', 'S"', { remap = true })
      vim.keymap.set("v", ")", "S)", { remap = true })
      vim.keymap.set("v", "(", "S(", { remap = true })
      vim.keymap.set("v", "]", "S]", { remap = true })
      vim.keymap.set("v", "[", "S[", { remap = true })
    end
  },
  {
    'tpope/vim-dispatch',
    cmd = { 'Dispatch', 'Make', 'Focus', 'Start' },
    config = function()
      vim.cmd([[
        autocmd FileType java let b:dispatch = 'java %; java `basename % .java`'
        autocmd FileType ruby let b:dispatch = 'ruby %'
        autocmd FileType sh let b:dispatch = 'sh %'
        autocmd FileType javascript let b:dispatch = 'node %'
        autocmd FileType typescript let b:dispatch = 'ts-node %'
        autocmd FileType python let b:dispatch = 'python3 %'
      ]])
    end
  },
  {
    "tpope/vim-commentary",
    config = function()
      if vim.g["context#commentstring#table"] then
        vim.g["context#commentstring#table"]["react"] = {
          jsComment = "// %s",
          jsImport = "// %s",
          jsxStatment = "// %s",
          jsxRegion = "{/*%s*/}",
        }
      end

      vim.keymap.set("n", "<c-_><c-_>", "gcc", { remap = true })
      vim.keymap.set("v", "<c-_><c-_>", "gc", { remap = true })
      vim.keymap.set("i", "<c-_><c-_>", "<esc>gcc", { remap = true })

      vim.keymap.set("n", "<c-c><c-_>", "gcc", { remap = true })
      vim.keymap.set("v", "<c-c><c-_>", "gc", { remap = true })
      vim.keymap.set("i", "<c-c><c-_>", "<esc>gcc", { remap = true })
    end,
  },
}
