return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        { "L3MON4D3/LuaSnip", version = "v2.*" },
        { "antznin/cmp-bitbake-path" },
      },
    },
    version = "1.*",
    opts = {
      -- super-tab behavior + ctrl-j/k to navigate entries
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-j>"] = { "select_next", "fallback_to_mappings" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = true,
          window = {
            border = "rounded",
          },
        },
        menu = {
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "source_name", gap = 1 } },
          },
          border = "rounded",
        },
        list = {
          selection = {
            auto_insert = false,
          },
        },
      },

      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "bitbake",
          "projects",
          "yoctodocs_terms",
          "yoctodocs_refs",
          "yoctodocs_titles",
        },
        providers = {
          bitbake = {
            name = "bitbake_path",
            module = "blink.compat.source",
          },
          projects = {
            name = "projects",
            module = "plugins.blink.cmd",
            opts = {
              cmd = "env -C /data/bootlin/intragit/weeklies/antonin-godard/"
                .. vim.fn.strftime("%Y")
                .. ' rg --no-filename "^ \\* .+:" | cut -c4- | cut -d: -f1 | sort | uniq',
              ft = "weekly",
            },
          },
          yoctodocs_refs = {
            name = "refs",
            module = "plugins.blink.cmd",
            opts = {
              cmd = 'env -C $ydocs '
                .. 'rg --no-filename "^(\\.\\. _ref-.+:|\\.\\. _structure-.+:)" '
                .. '| cut -c5- '
                .. '| cut -d: -f1 '
                .. '| sort | uniq',
              ft = "custom_rst",
              trigger_characters = { "\\`" },
            },
          },
          yoctodocs_terms = {
            name = "terms",
            module = "plugins.blink.cmd",
            opts = {
              cmd = {
                'env -C $ydocs/documentation/ref-manual '
                .. 'rg --no-filename "^   :term:\\`" terms.rst variables.rst '
                .. '| cut -d\\` -f 2 '
                .. '| sort | uniq',
              },
              ft = "custom_rst",
              trigger_characters = { '`' },
            },
          },
          yoctodocs_titles = {
            name = "titles",
            module = "plugins.blink.cmd",
            opts = {
              cmd = {
                'env -C $ydocs '
                .. 'rg --no-filename -U "(\\*|-|=|~)+\nYocto Project .+\n(\\*|-|=|~)+" '
                .. '| grep "^Yocto Project" '
                .. '| sort | uniq',
              },
              ft = "custom_rst",
              trigger_characters = { "Y" },
            },
          },
        },
      },

      fuzzy = { implementation = "prefer_rust" },
    },
    opts_extend = { "sources.default" },
  },
  {
    "saghen/blink.compat",
    -- use v2.* for blink.cmp v1.*
    version = "2.*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },
}
