status_ok, theme = pcall(require, "github-theme")
if not status_ok then
	return
end

theme.setup({
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
})

local colorscheme = "github_light"
status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme not found!")
  return
end
