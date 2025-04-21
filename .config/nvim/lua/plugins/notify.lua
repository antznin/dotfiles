return {
  "rcarriga/nvim-notify",
  version = "*",
  config = function()
    local vim_notify = require("notify")

    vim_notify.setup({
      background_colour = "#000000",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },
      level = 2,
      minimum_width = 50,
      render = "default",
      stages = "fade",
      timeout = 1000,
      top_down = false,
    })

    -- Use nvim-notify for all notifications
    vim.notify = vim_notify

    require("telescope").load_extension("notify")
  end,
}
