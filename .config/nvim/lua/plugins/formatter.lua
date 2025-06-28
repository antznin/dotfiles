return {
  "mhartington/formatter.nvim",
  version = "*",
  cmd = "Format",
  config = function()
    local util = require("formatter.util")
    require("formatter").setup({
      logging = true,
      log_level = vim.log.levels.WARN,
      filetype = {
        go = {
          require("formatter.filetypes.go").gofumpt,
        },
        lua = {
          require("formatter.filetypes.lua").stylua,

          function()
            -- Supports conditional formatting
            if util.get_current_buffer_file_name() == "special.lua" then
              return nil
            end

            return {
              exe = "stylua",
              args = {
                "--indent-type",
                "Spaces",
                "--indent-width",
                "2",
                "--quote-style",
                "AutoPreferDouble",
                "--sort-requires",
                "--search-parent-directories",
                "--stdin-filepath",
                util.escape_path(util.get_current_buffer_file_path()),
                "--",
                "-",
              },
              stdin = true,
            }
          end,
        },
        -- -- Use the special "*" filetype for defining formatter configurations on
        -- -- any filetype
        -- ["*"] = {
        --   -- "formatter.filetypes.any" defines default configurations for any
        --   -- filetype
        --   require("formatter.filetypes.any").remove_trailing_whitespace
        -- }
      },
    })
  end,
}
