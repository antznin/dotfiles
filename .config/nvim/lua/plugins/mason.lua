return {
  {
    'williamboman/mason.nvim', -- Install linters, formatters, LSPs...
    version = '*',
    config = function()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim', -- Gives a configuration that nvim-lspconfig can use
    version = '*',
    lazy = false,
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup()
    end,
  },
}
