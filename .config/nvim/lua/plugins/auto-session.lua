return {
  "rmagatti/auto-session",
  lazy = false,
  version = "*",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      use_git_branch = true,
    })
  end,
}
