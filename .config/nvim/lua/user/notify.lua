local status_ok, vim_notify, telescope
status_ok, vim_notify = pcall(require, 'notify')
if not status_ok then
  return
end

vim_notify.setup({
  background_colour = 'Normal',
  fps = 30,
  icons = {
    DEBUG = '',
    ERROR = '',
    INFO = '',
    TRACE = '✎',
    WARN = ''
  },
  level = 2,
  minimum_width = 50,
  render = 'default',
  stages = 'fade',
  timeout = 1000,
  top_down = false,
})

-- Use nvim-notify for all notifications
vim.notify = vim_notify

status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

telescope.load_extension('notify')
