return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      bashls = {
        filetypes = { "bash", "sh" },
      },
      gopls = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      },
      quick_lint_js = {},
      rust_analyzer = {},
      tinymist = {},
      clangd = {},
      jsonls = {},
      ruff = {},
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                ignore = { "E302", "E305" },
                maxLineLength = 80,
              },
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
