local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-y>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})


function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  require('user.keymaps').toggleterm_keymaps(0) -- 0 for current buffer
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
function _NCDU_TOGGLE()
  ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })
function _HTOP_TOGGLE()
  htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })
function _PYTHON_TOGGLE()
  python:toggle()
end

local tshell_cmd = "cd '/data/txl/md20xx/workspace/wyld/build' && BSP_DIR='/data/txl/md20xx/workspace/wyld/bsp' make shell"
local tshell = Terminal:new({ cmd = tshell_cmd, hidden = true })
function _TSHELL_TOGGLE()
  tshell:toggle()
end

local walog = Terminal:new({ cmd = "watch -n1 -t --color git alog", hidden = true })
function _WALOG_TOGGLE()
  walog:toggle()
end
