local function define_custom_snippets(ls)
  local s = ls.snippet
  local i = ls.insert_node
  local fmt = require("luasnip.extras.fmt").fmt

  ls.add_snippets("custom_mail", {
    s("ab", fmt('Acked-by: Antonin Godard <antonin.godard@bootlin.com>', {})),
    s("rb", fmt('Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>', {})),
    s("tb", fmt('Tested-by: Antonin Godard <antonin.godard@bootlin.com>', {})),
  })

  ls.add_snippets("c", {
    s("prd", fmt('pr_info("[%s,%d]\\n", __func__, __LINE__);', {})),
  })

  ls.add_snippets("dts", {
    s("muxam62", fmt('AM62X_IOPAD(0x, , ) /* () . [] */', {})),
  })

  ls.add_snippets("text", {
    s("ly", fmt('https://lore.kernel.org/r/', {})),
    -- s("ypt", fmt('Participate in the Yocto Project Technical Meeting.', {})),
    -- s("ypb", fmt('Participate in the Yocto Project Bug Triage Meeting.', {})),
    -- s("ypp", fmt('Participate in the Yocto Project Patch Review Meeting.', {})),
    -- s("aw", fmt('Participate in the Yocto Project Patch Review Meeting.', {})),
  })
end

return {
  "hrsh7th/nvim-cmp",
  -- load cmp on InsertEnter
  event = "InsertEnter",
  dependencies = {
    -- cmp sources
    "hrsh7th/cmp-buffer", -- buffer completions
    "hrsh7th/cmp-path", -- path completions
    "hrsh7th/cmp-cmdline", -- cmdline completions
    "hrsh7th/cmp-nvim-lsp", -- LSP completions
    "f3fora/cmp-spell", -- Spell checking cmp intergration
    "antznin/cmp-bitbake-path", -- Path completion for bitbake
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- For friendly-snippets and such.
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Custom snippets
    define_custom_snippets(luasnip)

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local kind_icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }

    cmp.setup({
      snippet = {
        -- Specify a snippet engine.
        expand = function(args)
          require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "bitbake_path" },
        {
          name = "spell",
          option = {
            keep_all_entries = false,
            enable_in_context = function()
              return true
            end,
          },
        },
      },
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            bitbake = "[Bitbake]",
            spell = "[Spell]",
          })[entry.source.name]
          return vim_item
        end,
      },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
    })
  end,
}
