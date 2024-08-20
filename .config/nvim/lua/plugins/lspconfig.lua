return {
  "neovim/nvim-lspconfig",
  version = "*",
  config = function()
    local lspconfig = require("lspconfig")

    -- Configure LSP below.

    lspconfig.bashls.setup({
      filetypes = { "bash", "sh" },
    })

    lspconfig.pylsp.setup({})
  end,
}
