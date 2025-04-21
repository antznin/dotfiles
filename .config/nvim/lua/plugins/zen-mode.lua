return {
  "folke/zen-mode.nvim",
  version = "*",
  config = function()
    require("zen-mode").setup({
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 90, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          signcolumn = "no", -- disable signcolumn
          number = false, -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false, -- disable cursorline
          cursorcolumn = false, -- disable cursor column
          foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        gitsigns = { enabled = true }, -- disables git signs
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        alacritty = {
          enabled = true,
          font = "13", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
        local view = require("zen-mode.view")
        local layout = view.layout(view.opts)
        vim.api.nvim_win_set_config(win, {
          width = layout.width,
          height = layout.height - 1,
        })
        vim.api.nvim_win_set_config(view.bg_win, {
          width = vim.o.columns,
          height = view.height() - 1,
          row = 1,
          col = layout.col,
          relative = "editor",
        })
        vim.cmd("cabbrev <buffer> q let b:quit_zen = 1 <bar> q")
        vim.cmd("cabbrev <buffer> Q let b:quit_zen = 1 <bar> q")
        vim.cmd("cabbrev <buffer> wq let b:quit_zen = 1 <bar> wq")
        vim.cmd("cabbrev <buffer> Wq let b:quit_zen = 1 <bar> wq")
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        if vim.b.quit_zen == 1 then
          vim.b.quit_zen = 0
          vim.cmd("q")
        end
      end,
    })

    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      pattern = { "aerc-compose-*.eml" },
      callback = require("zen-mode").open,
    })

    vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
      pattern = { "aerc-compose-*.eml" },
      callback = require("zen-mode").close,
    })

  end,
}
