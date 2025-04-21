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

    -- lspconfig.texlab.setup({})

    lspconfig.rust_analyzer.setup({})

    -- lspconfig.ltex.setup({
    --   autostart = false,
    --   use_spellfile = true,
    --   settings = {
    --       ltex = {
    --       language = "auto",
    --       disabledRules = {
    --         en = { "WHITESPACE_RULE" },
    --         fr = { "WHITESPACE_RULE" },
    --       },
    --     },
    --   },
    -- })

    lspconfig.quick_lint_js.setup({})

    lspconfig.lua_ls.setup({})

    lspconfig.gopls.setup({})

    lspconfig.tinymist.setup({})

    -- vim.env.VALE_CONFIG_PATH = vim.env.HOME .. "/.config/vale/vale.ini"
    -- lspconfig.vale_ls.setup({})
  end,
}
