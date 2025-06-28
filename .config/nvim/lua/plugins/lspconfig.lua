return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      bashls = {
        filetypes = { "bash", "sh" },
      },
      gopls = {},
      lua_ls = {},
      quick_lint_js = {},
      pylsp = {},
      rust_analyzer = {},
      tinymist = {},
      clangd = {},
    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
