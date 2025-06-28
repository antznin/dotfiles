return {
  {
    "williamboman/mason.nvim", -- Install linters, formatters, LSPs...
    version = "*",
    lazy = false,
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim", -- Gives a configuration that nvim-lspconfig can use
    version = "*",
    cmd = "Mason",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup()
    end,
  },
}
