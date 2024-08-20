local options = {
  options = {
    transparent = false,
    styles = {
      comments = 'italic',
      functions = 'bold',
    },
    darken = {
      sidebars = {
        enable = true,
      },
    },
  }
}

return {
  'projekt0n/github-nvim-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup(options)
    vim.cmd('colorscheme github_light')
  end,
}
