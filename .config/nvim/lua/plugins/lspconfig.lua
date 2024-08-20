return {
  'neovim/nvim-lspconfig',
  version = '*',
  config = function()
    local lspconfig = require("lspconfig")

    lspconfig.bashls.setup({
      filetypes = { 'bash', 'sh', },
    })

    lspconfig.pylsp.setup{}
  end,
}
