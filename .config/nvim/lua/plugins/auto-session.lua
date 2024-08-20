local options = {
  log_level = "error",
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
}

return {
  'rmagatti/auto-session',
  lazy = false,
  version = '*',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('auto-session').setup(options)
  end,
}
